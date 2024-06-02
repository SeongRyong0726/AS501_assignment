// -----------------------
// system_contoller.v
// fsm.v

// A_buffer.v
// 	?�� address_generator_A.v
// 	?�� ram.v

// W_buffer.v
// 	?�� address_generator_W.v
// 	?�� ram.v

// O_buffer_top.v
// ?�� accumulator.v
// 	?�� acc.v
// 	?�� index_generator.v
// ?�� O_buffer.v
// ?�� address_generator_O.v
// ?�� ram.v

// systolic_array.v
// ?�� pe.v
// -----------------------

`timescale 100ns/1ns
module systolic_system #(
    parameter integer ARRAY_N = 16,
    parameter integer ARRAY_M = 16,

    parameter integer ACT_WIDTH = 8,
    parameter integer WGT_WIDTH = 8,
    parameter integer PE_OUT_WIDTH = 32,

    parameter integer RAM_SIZE = 1<<10,
    parameter integer ADDR_WIDTH = $clog2(RAM_SIZE),
    
    parameter integer DATA_WIDTH = 32,
    parameter integer OUT_WIDTH = 32,
    parameter integer   IBUF_DATA_WIDTH = ARRAY_N * ACT_WIDTH,
    parameter integer   WBUF_DATA_WIDTH = ARRAY_M * WGT_WIDTH
) (
    input wire clk,
    input wire reset,
    //A buf READ
    input wire                          a_buf_on,
    input wire [ADDR_WIDTH-1:0]         a_base_addr,
    input wire [$clog2(ARRAY_N) : 0]    a_num_rows, //dimension (M)
    //A buf WRITE
    input wire [32-1:0]                 bram_to_a_ram_w_data,
    input wire      [ADDR_WIDTH-1:0]    bram_to_a_ram_w_addr,
    input wire      [ARRAY_N-1:0]       bram_to_a_ram_w_en,



    //W_buf READ
    input wire                          mode,
    input wire                          w_buf_on,
    input wire [ADDR_WIDTH -1:0]        w_base_addr,
    input wire [$clog2(ARRAY_N):0]      w_num_cols, //dimension (N)
    //W buf WRITE
    input wire [32-1:0]                 bram_to_w_ram_w_data,
    input wire      [ADDR_WIDTH-1:0]    bram_to_w_ram_w_addr,
    input wire      [ARRAY_M-1:0]       bram_to_w_ram_w_en,
    

    //systolic array
    input wire [2:0]                    operation_signal_in,

    //SIMD
    input wire [$clog2(ARRAY_N) : 0]    w_index_bias,
    input wire [OUT_WIDTH -1 : 0]       w_data_bias,
    input wire                          w_en_bias,

    //O_buffer READ
    input wire                          o_ag_o_on,
    input wire [ADDR_WIDTH -1 : 0]      o_base_addr,
    input wire [$clog2(ARRAY_M)-1:0]    o_ram_idx,
    input wire [ADDR_WIDTH-1 : 0]       o_read_addr,
    //O_buf WRITE
    output wire [32-1:0]         data_in_o_bram,
    
    input wire[31: 0] M,
    input wire[31: 0] K,
    input wire[31: 0] N



    // output wire [PE_OUT_WIDTH*ARRAY_M-1:0]      DEBUG_data,
    // output wire [IBUF_DATA_WIDTH-1:0]   DEBUG_act_data_set,
    // output wire [IBUF_DATA_WIDTH-1:0]   DEBUG_wgt_data_set
);
    wire [IBUF_DATA_WIDTH-1:  0]      act_data_set_w;
    wire [WBUF_DATA_WIDTH-1:  0]      wgt_data_set_w;
    wire [PE_OUT_WIDTH*ARRAY_M-1:0]   result_data_set;
    wire [PE_OUT_WIDTH*ARRAY_M-1:0]   result_data_set_simd;
    assign DEBUG_act_data_set = act_data_set_w;
    assign DEBUG_wgt_data_set = wgt_data_set_w;

    wire [ADDR_WIDTH-1:0]       bram_to_a_ram_w_addr_ = bram_to_a_ram_w_addr/(M*4); 
    wire [ADDR_WIDTH-1:0]       bram_to_w_ram_w_addr_ = bram_to_w_ram_w_addr/(N*4); 
    A_buffer #(
        .RAM_SIZE(RAM_SIZE),
        .ARRAY_N(ARRAY_N),
        .ARRAY_M(ARRAY_M),
        .ACT_WIDTH(ACT_WIDTH)
    ) a_buf_inst (
        .clk(clk),
        .reset(reset),
        .on(a_buf_on),
        .base_addr(a_base_addr),
        .num_rows(a_num_rows),

        .bram_to_ram_w_addr(bram_to_a_ram_w_addr_),
        .bram_to_ram_w_en(bram_to_a_ram_w_en),
        .bram_to_ram_w_data(bram_to_a_ram_w_data[ACT_WIDTH-1:0]),

        .act_data_set_out(act_data_set_w)
    );

    W_buffer #(
        .RAM_SIZE(RAM_SIZE),
        .ARRAY_N(ARRAY_N),
        .ARRAY_M(ARRAY_M),
        .WGT_WIDTH(WGT_WIDTH)
    ) w_buf_inst (
        .clk(clk),
        .reset(reset),
        .mode(mode),
        .on(w_buf_on),
        .base_addr(w_base_addr),
        .num_cols(w_num_cols),

        .bram_to_ram_w_addr(bram_to_w_ram_w_addr_),
        .bram_to_ram_w_en(bram_to_w_ram_w_en),
        .bram_to_ram_w_data(bram_to_w_ram_w_data[WGT_WIDTH-1:0]),

        .wgt_data_set_out(wgt_data_set_w)
    );

    systolic_array #(
        .ARRAY_N(ARRAY_N),
        .ARRAY_M(ARRAY_M),
        .ACT_WIDTH(ACT_WIDTH),
        .WGT_WIDTH(WGT_WIDTH),
        .PE_OUT_WIDTH(PE_OUT_WIDTH)
    ) syst_inst (
        .clk(clk),
        .reset(reset),
        .act_data_set_in(act_data_set_w),
        .wgt_data_set_in(wgt_data_set_w),
        .operation_signal_in(operation_signal_in),
        .result_data_set_out(result_data_set)
    );
    // result_data_set로 결과가 나오면 바로 O-buffer로가는것이 아니라 +bias +ReLU과정을 거쳐서 간다.
    // 따라서 이 사이에 Bias_ReLU module을 달아 준다.
    //combination logic ( add for bias + mux for relu )
    Bias_ReLU_simd #(
        .ARRAY_N(ARRAY_N),
        .OUT_WIDTH(OUT_WIDTH)
    ) Bias_ReLU_simd_inst (
        .clk(clk),
        .reset(reset),
        .w_index(w_index_bias),
        .w_data(w_data_bias),
        .w_en(w_en_bias),
        .data_in(result_data_set),
        .data_out(result_data_set_simd)
    );

    O_buffer #(
        .RAM_SIZE(RAM_SIZE),
        .ADDR_WIDTH(ADDR_WIDTH),
        .ARRAY_M(ARRAY_M),
        .OUT_WIDTH(OUT_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) o_buf_top_inst (
        .clk(clk),
        .reset(reset),
        .num_cols(w_num_cols),
        .ag_o_on(o_ag_o_on),
        .data_in(result_data_set_simd),
        .base_addr(o_base_addr),
        .ram_idx(o_ram_idx),
        .read_addr(o_read_addr),
        .data_read(data_in_o_bram)
    ); 
endmodule

//.idx_gen_on(o_idx_gen_on), //
//.drain(o_drain), // 는 포트에서 삭제 안쓰임