`timescale 100ns/1ns
module tb_mat_mul_system #(
    parameter integer NUM_VAR = 4,

    parameter integer ARRAY_N = 8,
    parameter integer ARRAY_M = 8,

    parameter integer ACT_WIDTH = 8,
    parameter integer WGT_WIDTH = 8,
    parameter integer PE_OUT_WIDTH = 32,

    parameter integer RAM_SIZE = 1024,
    parameter integer ADDR_WIDTH = $clog2(RAM_SIZE),
    
    parameter integer DEPTH = 8,
    parameter integer DATA_WIDTH = 32,
    parameter integer OUT_WIDTH = 32,
    parameter integer IBUF_DATA_WIDTH = ACT_WIDTH * ARRAY_N
);

    reg clk;
    reg reset;

    //SP_BRAM
    wire [32-1:0]         addr_sp_bram;
    wire                  enable_sp_bram;
    reg [32-1:0]         data_out_sp_bram;
    wire [4-1 :0]         w_enable_sp_bram;
    wire [32-1:0]         data_in_sp_bram;
    //A_BRAM
    wire [32-1:0]         addr_a_bram;
    wire                  enable_a_bram;
    reg [32-1:0]         data_out_a_bram;
//    wire [4-1 :0]         w_enable_a_bram; //not use
//    wire [32-1:0]         data_in_a_bram; //not use
    //W_BRAM
    wire [32-1:0]         addr_w_bram;
    wire                  enable_w_bram;
    reg [32-1:0]         data_out_w_bram;
//    wire [4-1 :0]         w_enable_w_bram; //not use
//    wire [32-1:0]         data_in_w_bram;  //not use
    //O_BRAM
    wire [32-1:0]         addr_o_bram;
    wire                  enable_o_bram;
    reg [32-1:0]         data_out_o_bram;
    wire [4-1 :0]         w_enable_o_bram;
    wire [32-1:0]         data_in_o_bram;
    wire [5:0]           DEBUG_state;
    wire [IBUF_DATA_WIDTH-1:0]   DEBUG_act_data_set;
    wire [ARRAY_N-1:0] DEBUG_bram_to_a_ram_w_en;
    wire [IBUF_DATA_WIDTH-1:0]   DEBUG_wgt_data_set;

    mat_mul_system #(
        .NUM_VAR(NUM_VAR),

        .ARRAY_N(ARRAY_N),
        .ARRAY_M(ARRAY_M),

        .ACT_WIDTH(ACT_WIDTH),
        .WGT_WIDTH(WGT_WIDTH),
        .PE_OUT_WIDTH(PE_OUT_WIDTH),

        .RAM_SIZE(RAM_SIZE),

        .DEPTH(DEPTH),
        .DATA_WIDTH(DATA_WIDTH),
        .OUT_WIDTH(OUT_WIDTH)
    ) m_inst (
        .clk(clk),
        .reset(reset),
        .addr_sp_bram(addr_sp_bram),
        .enable_sp_bram(enable_sp_bram),
        .data_out_sp_bram(data_out_sp_bram),
        .w_enable_sp_bram(w_enable_sp_bram),
        .data_in_sp_bram(data_in_sp_bram),

        .addr_a_bram(addr_a_bram),
        .enable_a_bram(enable_a_bram),
        .data_out_a_bram(data_out_a_bram),
//        .w_enable_a_bram(w_enable_a_bram),
//        .data_in_a_bram(data_in_a_bram),

        .addr_w_bram(addr_w_bram),
        .enable_w_bram(enable_w_bram),
        .data_out_w_bram(data_out_w_bram),
//        .w_enable_w_bram(w_enable_w_bram),
//        .data_in_w_bram(data_in_w_bram),

        .addr_o_bram(addr_o_bram),
        .enable_o_bram(enable_o_bram),
//        .data_out_o_bram(data_out_o_bram),
        .w_enable_o_bram(w_enable_o_bram),
        .data_in_o_bram(data_in_o_bram),

        .DEBUG_state(DEBUG_state),
        .DEBUG_act_data_set(DEBUG_act_data_set),
        .DEBUG_bram_to_a_ram_w_en(DEBUG_bram_to_a_ram_w_en),
        .DEBUG_wgt_data_set(DEBUG_wgt_data_set)

    );

    initial begin
        clk =1;
        reset = 1;
        data_out_sp_bram=0;
        data_out_a_bram=0;
        data_out_w_bram=0;
        data_out_o_bram=0;
        #10
        reset = 0;
        data_out_sp_bram=1;
    end
    always #0.5 clk = !clk;
endmodule
