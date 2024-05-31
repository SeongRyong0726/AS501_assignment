//If you want to use this, use have to use git commit "one_tile_Bias+ReLU done"

`timescale 100ns/1ns
module tb_systolic_system #(
    parameter integer ARRAY_N = 16,
    parameter integer ARRAY_M = 16,

    parameter integer ACT_WIDTH = 8,
    parameter integer WGT_WIDTH = 8,
    parameter integer PE_OUT_WIDTH = 32,

    parameter integer RAM_SIZE = 1<<10,
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
    //SIMD
    reg [$clog2(ARRAY_N) : 0]    w_index_bias;
    reg [PE_OUT_WIDTH -1 : 0]       w_data_bias;
    reg                          w_en_bias;
    //o_buf
    reg                          o_ag_o_on;
    reg [ADDR_WIDTH -1 : 0]      o_base_addr;
    reg [$clog2(ARRAY_M)-1:0]    o_ram_idx;
    reg [ADDR_WIDTH-1 : 0]       o_read_addr;
    //dimension parameter
    reg [31: 0] M;
    reg [31: 0] K;
    reg [31: 0] N;
    // ourput
    wire [PE_OUT_WIDTH-1:0] data_to_bram;

    systolic_system #(
        .ARRAY_N(ARRAY_N),
        .ARRAY_M(ARRAY_M),
        .ACT_WIDTH(ACT_WIDTH),
        .WGT_WIDTH(WGT_WIDTH),
        .PE_OUT_WIDTH(PE_OUT_WIDTH),
        .RAM_SIZE(RAM_SIZE),
        .DATA_WIDTH(PE_OUT_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) sys_sys_inst (
        .clk(clk),
        .reset(reset),

        .a_buf_on(a_buf_on),
        .a_base_addr(a_base_addr),
        .a_num_rows(a_num_rows),
        .bram_to_a_ram_w_data(32'b0),
        .bram_to_a_ram_w_addr(10'b0),
        .bram_to_a_ram_w_en(16'b0),

        .mode(mode),
        
        .w_buf_on(w_buf_on),
        .w_base_addr(w_base_addr),
        .w_num_cols(w_num_cols),
        .bram_to_w_ram_w_data(32'b0),
        .bram_to_w_ram_w_addr(10'b0),
        .bram_to_w_ram_w_en(16'b0),

        .operation_signal_in(operation_signal_in),

        .w_index_bias(w_index_bias),
        .w_data_bias(w_data_bias),
        .w_en_bias(w_en_bias),
        
        .o_ag_o_on(o_ag_o_on),
        .o_base_addr(o_base_addr),
        .o_ram_idx(o_ram_idx),
        .o_read_addr(o_read_addr),
        .data_in_o_bram(data_to_bram),

        .M(M),
        .K(K),
        .N(N)
    );
    integer i, cc;
    integer row_dim = 10;
    integer col_dim = 10;
    integer j=0;

    initial begin
    //mode = OS test [op_signal_in : os flow = b100, os drain = b110]
    // streaming data to systolic array test 
    // config : (16xM Mx16) , M = 30
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
        w_index_bias = 0;
        w_data_bias = 0;
        w_en_bias = 0;
        o_ag_o_on   = 0;
        o_base_addr = 0;
        o_ram_idx   = 0;
        o_read_addr = 0;
        M = row_dim;
        K = 30;
        N = col_dim;
        #10
        //setting
        reset       = 0;
        mode        = 1; //os
        a_base_addr = 0;
        a_num_rows  = row_dim;
        w_base_addr = 0;
        w_num_cols  = col_dim;
        o_base_addr = 0;
        o_ram_idx   = 0;
        o_read_addr = 0;
        #1
        // bias value setting
        w_data_bias = 'hfffffff0;
        w_en_bias = 1;
        w_index_bias = 'b0000;
        #1
        w_index_bias = 'b0001;
        #1
        w_index_bias = 'b0010;
        #1
        w_index_bias = 'b0011;
        #1
        w_index_bias = 'b0100;
        #1
        w_index_bias = 'b0101;
        #1
        w_index_bias = 'b0110;
        #1
        w_index_bias = 'b0111;
        #1
        w_data_bias = 'hffffffe0;
        w_index_bias = 'b1000;
        #1
        w_index_bias = 'b1001;
        #1
        w_index_bias = 'b1010;
        #1
        w_index_bias = 'b1011;
        w_data_bias = 'h00000010;
        #1
        w_index_bias = 'b1100;
        #1
        w_index_bias = 'b1101;
        #1
        w_index_bias = 'b1110;
        #1
        w_index_bias = 'b1111;
        #1
        // for(j=0;j<ARRAY_N;j=j+1){
        //     w_index_bias = 'b0;
        //     w_data_bias = 'hfffffff0;
        //     w_en_bias = 1;
        //     #1
        // }
        w_index_bias = 0;
        w_data_bias = 'h0;
        w_en_bias = 0;
        #1
        // STEP1 : OS_FLOW
        a_buf_on    = 1;
        w_buf_on    = 1;
        operation_signal_in = 3'b100;
        #30 // K = 30
        a_buf_on    = 0;
        w_buf_on    = 0;
        operation_signal_in = 3'b100;
        #(10 + 10 - 1) // row_dim + col_dim -1
        
        // STEP2: OS_DRAIN
        a_buf_on    = 0;
        w_buf_on    = 0;
        operation_signal_in = 3'b110;
        #(16 - 10 -1) // ARRAY_N - row_dim -1
            //store drain data to ram
        //#(1)//DELAY OBUF
        o_ag_o_on = 1;
        #(10 + 1)            //row_dim+1
        // STEP3: check ram contents
        // for(cc = 0; cc<8; cc=cc+1)
        // begin
        // for(i=0; i<8; i=i+1) //W=6  //TODO
        // begin
        //     o_ram_idx   = cc;
        //     o_read_addr = o_base_addr + i;
        //     #1;
        // end
        // end
        o_ag_o_on = 0;
    end
    always #0.5 clk = !clk;
endmodule