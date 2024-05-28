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
    parameter integer ARRAY_N = 8,
    parameter integer ARRAY_M = 8,

    parameter integer ACT_WIDTH = 8,
    parameter integer WGT_WIDTH = 8,
    parameter integer PE_OUT_WIDTH = 32,

    parameter integer RAM_SIZE = 1<<8,
    parameter integer ADDR_WIDTH = $clog2(RAM_SIZE),
    
    parameter integer DEPTH = 8,
    parameter integer DATA_WIDTH = 32,
    parameter integer OUT_WIDTH = 32,
    parameter integer   IBUF_DATA_WIDTH = ARRAY_N * ACT_WIDTH,
    parameter integer   WBUF_DATA_WIDTH = ARRAY_M * WGT_WIDTH
) (
    input wire clk,
    input wire reset,
    input wire acc_reset,
    input wire A_ram_reset,
    input wire W_ram_reset,
    input wire O_ram_reset,
    input wire array_contents_reset,
    //A buf READ
    input wire                          a_buf_on,
    input wire [ADDR_WIDTH-1:0]         a_base_addr,
    input wire [$clog2(ARRAY_N) : 0]    a_num_rows,
    //A buf WRITE
    input wire [32-1:0]                 bram_to_a_ram_w_data,
    input wire      [32-1:0]    bram_to_a_ram_w_addr,
    input wire      [ARRAY_N-1:0]       bram_to_a_ram_w_en,



    //W_buf READ
    input wire                          mode,
    input wire                          w_buf_on,
    input wire [ADDR_WIDTH -1:0]        w_base_addr,
    input wire [$clog2(ARRAY_N):0]      w_num_cols, 
    //W buf WRITE
    input wire [32-1:0]                 bram_to_w_ram_w_data,
    input wire      [32-1:0]    bram_to_w_ram_w_addr,
    input wire      [ARRAY_M-1:0]       bram_to_w_ram_w_en,
    

    //systolic array
    input wire [2:0]                    operation_signal_in,

    //O_buffer READ
    input wire                          o_idx_gen_on,
    input wire                          o_ag_o_on,
    input wire                          o_drain,
    input wire [ADDR_WIDTH -1 : 0]      o_base_addr,
    input wire [$clog2(ARRAY_M)-1:0]    o_ram_idx,
    input wire [ADDR_WIDTH-1 : 0]       o_read_addr,
    //O_buf WRITE
    output wire [32-1:0]         data_in_o_bram,
    
    input wire[31: 0] M,
    input wire[31: 0] K,
    input wire[31: 0] N,



    // output wire [PE_OUT_WIDTH*ARRAY_M-1:0]      DEBUG_data,
    output wire [IBUF_DATA_WIDTH-1:0]   DEBUG_act_data_set,
    output wire [IBUF_DATA_WIDTH-1:0]   DEBUG_wgt_data_set,
    output wire [PE_OUT_WIDTH*ARRAY_M-1:0] DEBUG_result_data_set
);
    wire [IBUF_DATA_WIDTH-1:  0]      act_data_set_w;
    wire [WBUF_DATA_WIDTH-1:  0]      wgt_data_set_w;
    wire [PE_OUT_WIDTH*ARRAY_M-1:0]   result_data_set;
    assign DEBUG_act_data_set = act_data_set_w;
    assign DEBUG_wgt_data_set = wgt_data_set_w;
    assign DEBUG_result_data_set = result_data_set;

    wire [32-1:0]       bram_to_a_ram_w_addr_ = bram_to_a_ram_w_addr/(ARRAY_N*4); 
    wire [32-1:0]       bram_to_w_ram_w_addr_ = bram_to_w_ram_w_addr/(ARRAY_M*4); 
    A_buffer #(
        .RAM_SIZE(RAM_SIZE),
        .ARRAY_N(ARRAY_N),
        .ARRAY_M(ARRAY_M),
        .ACT_WIDTH(ACT_WIDTH)
    ) a_buf_inst (
        .clk(clk),
        .reset(reset),
        .ram_reset(A_ram_reset),
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
        .ram_reset(W_ram_reset),
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
        .reset(array_contents_reset),
        .act_data_set_in(act_data_set_w),
        .wgt_data_set_in(wgt_data_set_w),
        .operation_signal_in(operation_signal_in),
        .result_data_set_out(result_data_set)
    );

    O_buffer_top #(
        .RAM_SIZE(RAM_SIZE),
        .DEPTH(DEPTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .ARRAY_M(ARRAY_M),
        .OUT_WIDTH(OUT_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) o_buf_top_inst (
        .clk(clk),
        .reset(reset),
        .acc_reset(acc_reset),
        .ram_reset(O_ram_reset),
        .data_set_in(result_data_set),
        .idx_gen_on(o_idx_gen_on),
        .ag_o_on(o_ag_o_on),
        .drain(o_drain),
        .num_cols(w_num_cols),
        .base_addr(o_base_addr),
        .mode(mode),
        .ram_idx(o_ram_idx),
        .read_addr(o_read_addr),
        .data_read(data_in_o_bram)
        // .DEBUG_data(DEBUG_data)
    ); 
endmodule