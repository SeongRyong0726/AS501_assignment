`timescale 100ns/1ns

module tb_fsm #(
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
    parameter integer OUT_WIDTH = 32

);
    reg clk;
    reg reset;

    
        //special purpose BRAM
    wire [32-1:0]         addr_sp_bram;
    wire                  enable_sp_bram;
    reg [32-1:0]          data_out_sp_bram;
    wire [4-1 :0]         w_enable_sp_bram;
    wire [32-1:0]         data_in_sp_bram;
        //A_BRAM
    wire [32-1:0]         addr_a_bram;
    wire                  enable_a_bram;
    wire [ARRAY_N-1:0]    bram_to_a_ram_w_en;
        //W_BRAM
    wire [32-1:0]         addr_w_bram;
    wire                  enable_w_bram;
    wire [ARRAY_M-1:0]    bram_to_w_ram_w_en;
        //O_BRAM
    wire [32-1:0]         addr_o_bram;
    wire                  enable_o_bram;
    wire [4-1 :0]         w_enable_o_bram;


    wire                          system_reset;
    //A buf
    wire                          a_buf_on;
    wire [ADDR_WIDTH-1:0]         a_base_addr;
    wire [$clog2(ARRAY_N) : 0]    a_num_rows;
    //W_buf
    wire                          mode;
    wire                          w_buf_on;
    wire [ADDR_WIDTH -1:0]        w_base_addr;
    wire [$clog2(ARRAY_N):0]      w_num_cols;
    //systolic array
    wire [2:0]                    operation_signal_in;
    wire [5 : 0]                  DEBUG_state;
    //O_buffer
    wire                          o_idx_gen_on;
    wire                          o_ag_o_on;
    wire                          o_drain;
    wire [ADDR_WIDTH -1 : 0]      o_base_addr;
    wire [$clog2(ARRAY_M)-1:0]    o_ram_idx;
    wire [ADDR_WIDTH-1 : 0]       o_read_addr;
    


    fsm_copy #(
        .NUM_VAR(NUM_VAR),
        .ARRAY_M(ARRAY_M),
        .ARRAY_N(ARRAY_N),
        .ACT_WIDTH(ACT_WIDTH),
        .WGT_WIDTH(WGT_WIDTH),
        .PE_OUT_WIDTH(PE_OUT_WIDTH),
        .RAM_SIZE(RAM_SIZE),
        .DEPTH(DEPTH),
        .DATA_WIDTH(DATA_WIDTH),
        .OUT_WIDTH(OUT_WIDTH)
    ) fsm_inst (
        .clk(clk),
        .reset(reset),
        .addr_sp_bram(addr_sp_bram),
        .enable_sp_bram(enable_sp_bram),
        .data_out_sp_bram(data_out_sp_bram),
        .w_enable_sp_bram(w_enable_sp_bram),
        .data_in_sp_bram(data_in_sp_bram),
            //A_BRAM
        .addr_a_bram(addr_a_bram),
        .enable_a_bram(enable_a_bram),
        .bram_to_a_ram_w_en(bram_to_a_ram_w_en),
            //W_BRAM
        .addr_w_bram(addr_w_bram),
        .enable_w_bram(enable_w_bram),
        .bram_to_w_ram_w_en(bram_to_w_ram_w_en),
            //O_BRAM
        .addr_o_bram(addr_o_bram),
        .enable_o_bram(enable_o_bram),
        .w_enable_o_bram(w_enable_o_bram),


        .system_reset(system_reset),
        //A buf
        .a_buf_on(a_buf_on),
        .a_base_addr(a_base_addr),
        .a_num_rows(a_num_rows),
        //W_buf
        .mode(mode),
        .w_buf_on(w_buf_on),
        .w_base_addr(w_base_addr),
        .w_num_cols(w_num_cols),
        //systolic array
        .operation_signal_in(operation_signal_in),

        //O_buffer
        .o_idx_gen_on(o_idx_gen_on),
        .o_ag_o_on(o_ag_o_on),
        .o_drain(o_drain),
        .o_base_addr(o_base_addr),
        .o_ram_idx(o_ram_idx),
        .o_read_addr(o_read_addr),
        //DEBUG
        .DEBUG_state(DEBUG_state)
    );

    initial begin
        clk=1;
        reset=1;
        data_out_sp_bram=0;
        #10
        reset=0;
        data_out_sp_bram=1;
        #150
        data_out_sp_bram=0;

    end
    always #0.5 clk = !clk;
endmodule