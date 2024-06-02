`timescale 100ns/1ns
module npu_controller #(
    parameter integer DWidth = 8,
    parameter integer ADDR_WIDTH = 32

) (
// EXT - CTRL
    input wire clk_i ,
    input wire rst_ni,
    input wire wen_input_i,
    input wire [ADDR_WIDTH-1 : 0]addr_i,
    input wire [DWidth-1 : 0]  wdata_i,
    output wire [DWidth-1 : 0]  rdata_o
// CTRL - SYS_SYSTEM
    //A buf READ (BUF --> SA : FSM)
    output wire                          a_buf_on,
    output wire [ADDR_WIDTH-1:0]         a_base_addr,
    output wire [$clog2(ARRAY_N) : 0]    a_num_rows, //dimension (M)
    //A buf WRITE (EXT --> BUF)
    output wire [32-1:0]                 a_ram_w_data,
    output wire      [ADDR_WIDTH-1:0]    a_ram_w_addr,
    output wire      [ARRAY_N-1:0]       a_ram_w_en,

    //W_buf READ  (BUF --> SA : FSM)
    output wire                          mode,
    output wire                          w_buf_on,
    output wire [ADDR_WIDTH -1:0]        w_base_addr,
    output wire [$clog2(ARRAY_N):0]      w_num_cols, //dimension (N)
    //W buf WRITE   (EXT --> BUF)
    output wire [32-1:0]                 w_ram_w_data,
    output wire      [ADDR_WIDTH-1:0]    w_ram_w_addr,
    output wire      [ARRAY_M-1:0]       w_ram_w_en,

    //systolic array (FSM)
    output wire [2:0]                    operation_signal_in,

    //SIMD  (EXT --> BUF)
    output wire [$clog2(ARRAY_N) : 0]    w_index_bias,
    output wire [OUT_WIDTH -1 : 0]       w_data_bias,
    output wire                          w_en_bias,
    //O_buffer READ (SA --> BUF : FSM)
    output wire                          o_ag_o_on,
    output wire [ADDR_WIDTH -1 : 0]      o_base_addr,
    //O_buffer READ ( BUF --> EXT)
    output wire [$clog2(ARRAY_M)-1:0]    o_ram_idx,
    output wire [ADDR_WIDTH-1 : 0]       o_read_addr,
    //Intra_net  (O_BUF --> A_BUF : FSM)
    output wire                          Intranet_on,
    output wire                          Intra_sig_start,
    output wire[ADDR_WIDTH-1:0]          Intra_O_base_addr,
    output wire[ADDR_WIDTH-1:0]          Intra_A_base_addr,
    input wire                         Intra_sig_end,
    //O_buf WRITE
    input wire [32-1:0]         data_in_o_bram,

    // PARAMETER : predefined
    output wire[31: 0] M,
    output wire[31: 0] K,
    output wire[31: 0] N

);
    //REGISTERS
    reg op_start;
    reg op_end;
    reg [31: 0] M;
    reg [31: 0] K;
    reg [31: 0] N;
    //DECODER
    npu_decoder #(
        
    ) npu_decoder_inst (
        // EXT - CTRL
        .clk_i(),
        .rst_ni(),
        .wen_input_i(),
        .addr_i(), //[ADDR_WIDTH-1 : 0]
        .wdata_i(), //[DWidth-1 : 0]
        // 
        .operation_type()

    );
    //FSM
        //instr _ os_op

        //instr _ out2act
        
        //instr _ get_max_data

        //instr _ st_data (parameter, bias, act, weight)
    

endmodule