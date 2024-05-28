`timescale 100ns/1ns
module tb_systolic_system #(
    parameter integer ARRAY_N = 8,
    parameter integer ARRAY_M = 8,

    parameter integer ACT_WIDTH = 8,
    parameter integer WGT_WIDTH = 8,
    parameter integer PE_OUT_WIDTH = 32,

    parameter integer RAM_SIZE = 1<<8,
    parameter integer ADDR_WIDTH = $clog2(RAM_SIZE),
    parameter integer DEPTH =8,

    parameter integer   IBUF_DATA_WIDTH = ARRAY_N * ACT_WIDTH,
    parameter integer   WBUF_DATA_WIDTH = ARRAY_M * WGT_WIDTH
);

    reg clk;
    reg reset;
    //A buf
    reg                          a_buf_on;
    reg [ADDR_WIDTH-1:0]         a_base_addr;
    reg [$clog2(ARRAY_N) : 0]    a_num_rows;
    //W_buf
    reg                          mode;
    reg                          w_buf_on;
    reg [ADDR_WIDTH -1:0]        w_base_addr;
    reg [$clog2(ARRAY_N):0]      w_num_cols;
    //systolic array
    reg [2:0]                    operation_signal_in;
    //o_buf
    reg                          o_idx_gen_on;
    reg                          o_ag_o_on;
    reg                          o_drain;
    reg [ADDR_WIDTH -1 : 0]      o_base_addr;
    reg [$clog2(ARRAY_M)-1:0]    o_ram_idx;
    reg [ADDR_WIDTH-1 : 0]       o_read_addr;
    wire [PE_OUT_WIDTH-1:0] data_to_bram;

    systolic_system #(
        .ARRAY_N(ARRAY_N),
        .ARRAY_M(ARRAY_M),
        .ACT_WIDTH(ACT_WIDTH),
        .WGT_WIDTH(WGT_WIDTH),
        .PE_OUT_WIDTH(PE_OUT_WIDTH),
        .RAM_SIZE(RAM_SIZE)
    ) sys_sys_inst (
        .clk(clk),
        .reset(reset),
        .a_buf_on(a_buf_on),
        .a_base_addr(a_base_addr),
        .a_num_rows(a_num_rows),
        .mode(mode),
        .w_buf_on(w_buf_on),
        .w_base_addr(w_base_addr),
        .w_num_cols(w_num_cols),
        .operation_signal_in(operation_signal_in),
        //
        .o_idx_gen_on(o_idx_gen_on),
        .o_ag_o_on(o_ag_o_on),
        .o_drain(o_drain),
        .o_base_addr(o_base_addr),
        .o_ram_idx(o_ram_idx),
        .o_read_addr(o_read_addr),
        .data_in_o_bram(data_to_bram)
    );
    integer i, cc;
    integer M = 15;
    initial begin
    //mode = OS test [op_signal_in : os flow = b100, os drain = b110]
    // streaming data to systolic array test 
    // config : (6xM Mx6) , M = 11
        //init
        clk         = 1;
        reset       = 1;
        a_buf_on    = 0;
        a_base_addr = 0;
        a_num_rows  = 0;
        mode        = 0;
        w_buf_on    = 0;
        w_base_addr = 0;
        w_num_cols  = 0;
        operation_signal_in = 0;
        o_idx_gen_on= 0;
        o_ag_o_on   = 0;
        o_drain     = 0;
        o_base_addr = 0;
        o_ram_idx   = 0;
        o_read_addr = 0;
        
        #10
        //setting
        reset       = 0;
        mode        = 1; //os
        a_base_addr = 0;
        a_num_rows  = 6;
        w_base_addr = 0;
        w_num_cols  = 6;
        o_base_addr = 0;
        o_ram_idx   = 0;
        o_read_addr = 0;
        // STEP1 : OS_FLOW
        a_buf_on    = 1;
        w_buf_on    = 1;
        operation_signal_in = 3'b100;
        #(M) // M 
        a_buf_on    = 0;
        w_buf_on    = 0;
        operation_signal_in = 3'b100;
        #(6+6-1) // num_rows + num_cols -1
        
        // STEP2: OS_DRAIN
        a_buf_on    = 0;
        w_buf_on    = 0;
        operation_signal_in = 3'b110;
        #(ARRAY_N - 6 -1) // ARRAY_N - num_rows -1
            //store drain data to ram
        o_idx_gen_on= 0;
        o_drain     = 0;
        //#(1)//DELAY OBUF
        o_ag_o_on   = 1;
        #(6+1)            //num_rows+1
        // STEP3: check ram contents
        for(cc = 0; cc<8; cc=cc+1)
        begin
        for(i=0; i<8; i=i+1) //W=6  //TODO
        begin
            o_ram_idx   = cc;
            o_read_addr = o_base_addr + i;
            #1;
        end
        end

        //=========================================
    // mode = WS test [op_signal_in : os flow = b100, os drain = b110]
    // 
    // config : weight (DxW) (WxW) , W = 5, D = 8
        //init
        reset       = 1;
        a_buf_on    = 0;
        a_base_addr = 0;
        a_num_rows  = 0;
        mode        = 0;
        w_buf_on    = 0;
        w_base_addr = 0;
        w_num_cols  = 0;
        operation_signal_in = 0;
        o_idx_gen_on= 0;
        o_ag_o_on   = 0;
        o_drain     = 0;
        o_base_addr = 0;
        o_ram_idx   = 0;
        o_read_addr = 0;
        
        #10;
        //setting
        reset       = 0;
        a_base_addr = 0;
        a_num_rows  = 5; //=W
        w_base_addr = 0;
        w_num_cols  = 5; // = W
        mode        = 0; //ws
        o_base_addr = 0;
        o_ram_idx   = 0;
        o_read_addr = 0;
        // STEP1 : W_LOAD
        a_buf_on    = 0;
        w_buf_on    = 1;
        operation_signal_in = 3'b001;
        #(6);                       //TODO  W + 1????????????????? w= 5
        // STEP2: WS_FLOW
        a_buf_on    = 1;
        w_buf_on    = 0;
        operation_signal_in = 3'b000;
        #(ARRAY_N)
            //output occur
        o_idx_gen_on= 1;
        o_ag_o_on   = 0;
        o_drain     = 0;
        a_buf_on    = 0;
        //#(8 + 5 - 1) // ARRAY_N + W -1 [max : ARRAY_N + ARRAY_M -1]
        #(8+5-1)//DEPTH+num_col-1
        //drain
        o_idx_gen_on= 0;
        o_drain     = 1;
        //#(1) 
        o_ag_o_on   = 1;
        #(DEPTH+1)
        // STEP3: check ram contents
        o_idx_gen_on= 0;
        o_ag_o_on   = 0;
        o_drain     = 0;
        for(cc=0; cc<8; cc=cc+1)
        begin
        for(i=0; i<8; i=i+1) //D=8  //TODO
        begin
            o_ram_idx = cc;
            o_read_addr = o_base_addr + i;
            #1;
        end
        end
        reset = 1;
    end
    always #0.5 clk = !clk;
endmodule