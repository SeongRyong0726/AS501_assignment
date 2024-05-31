//If you want to use this, use have to use git commit "one_tile_Bias+ReLU done"

`timescale 100ns/1ns
module tb_systolic_system_one_tile_bias_relu_full #(
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
    reg sa_reset;
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
    reg [PE_OUT_WIDTH -1 : 0]    w_data_bias;
    reg                          w_en_bias;
    //o_buf
    reg                          o_ag_o_on;
    reg [ADDR_WIDTH -1 : 0]      o_base_addr;
    reg [$clog2(ARRAY_M)-1:0]    o_ram_idx;
    reg [ADDR_WIDTH-1 : 0]       o_read_addr;
    //Intra_net
    reg                          Intranet_on;
    reg                          Intra_sig_start;
    reg[ADDR_WIDTH-1:0]          Intra_O_base_addr;
    reg[ADDR_WIDTH-1:0]          Intra_A_base_addr;

    wire                         Intra_sig_end;
    //dimension parameter
    reg [31: 0] M;
    reg [31: 0] K;
    reg [31: 0] N;
    // ourput
    wire [PE_OUT_WIDTH-1:0] data_to_bram;
    wire [ACT_WIDTH*4*ARRAY_M-1: 0] SIMD_data_out_DEBUG;
    wire [ACT_WIDTH*ARRAY_M-1: 0] Intra_net_data_out_DEBUG;
    wire [ACT_WIDTH*ARRAY_M-1: 0]  Intra_net_data_in_DEBUG;
    wire [10+3:0] DEBUG_A_wen_addr;
    wire [ARRAY_M-1:0] DEBUG_enable_set;

    systolic_system_adv #(
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
        .sa_reset(sa_reset),

        .a_buf_on(a_buf_on),
        .a_base_addr(a_base_addr),
        .a_num_rows(a_num_rows),
        .a_ram_w_data(32'b0),
        .a_ram_w_addr(10'b0),
        .a_ram_w_en(16'b0),

        .mode(mode),
        
        .w_buf_on(w_buf_on),
        .w_base_addr(w_base_addr),
        .w_num_cols(w_num_cols),
        .w_ram_w_data(32'b0),
        .w_ram_w_addr(10'b0),
        .w_ram_w_en(16'b0),

        .operation_signal_in(operation_signal_in),

        .w_index_bias(w_index_bias),
        .w_data_bias(w_data_bias),
        .w_en_bias(w_en_bias),
        
        .o_ag_o_on(o_ag_o_on),
        .o_base_addr(o_base_addr),
        .o_ram_idx(o_ram_idx),
        .o_read_addr(o_read_addr),

        .Intranet_on(Intranet_on),
        .Intra_sig_start(Intra_sig_start),
        .Intra_O_base_addr(Intra_O_base_addr),
        .Intra_A_base_addr(Intra_A_base_addr),
        .Intra_sig_end(Intra_sig_end),

        .data_in_o_bram(data_to_bram),

        .M(M),
        .K(K),
        .N(N),
        .Intra_net_data_out_DEBUG(Intra_net_data_out_DEBUG),
        .Intra_net_data_in_DEBUG(Intra_net_data_in_DEBUG),
        .SIMD_data_out_DEBUG(SIMD_data_out_DEBUG),
        .DEBUG_A_wen_addr(DEBUG_A_wen_addr),
        .DEBUG_enable_set(DEBUG_enable_set)
    );
    integer i, cc;
    integer row_dim = 10;
    integer col_dim = 10;
    integer j=0;

    initial begin
    //mode = OS test [op_signal_in : os flow = b100, os drain = b110]
    // streaming data to systolic array test 
    // config : (16xM Mx16) , M = 30
        //INIT
        clk         = 1;
        reset       = 1;
        sa_reset    = 1;
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
        Intranet_on = 0;
        Intra_sig_start = 0;
        Intra_O_base_addr = 0;
        Intra_A_base_addr = 0;
        M = row_dim;
        K = 30;
        N = col_dim;
        #10


        //SYSTEM SETTING
        reset       = 0;
        sa_reset    = 0;
        mode        = 1; //os
        a_base_addr = 0;
        a_num_rows  = row_dim;
        w_base_addr = 0;
        w_num_cols  = col_dim;
        o_base_addr = 0;
        o_ram_idx   = 0;
        o_read_addr = 0;
        #1
        // BIAS VALUE SETTING
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
        w_data_bias = 'hffffffff;
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
        //RELAX
        w_index_bias = 0;
        w_data_bias = 'h0;
        w_en_bias = 0;
        #1
        //START SYSTOLIC ARRAY OPERATION
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
        operation_signal_in = 3'b110;
        #(16 - 10 +1) // ARRAY_N - row_dim
            //store drain data to ram
        o_ag_o_on = 1;
        for(i=0; i<(10+1); i=i+1) begin
            $display("result : %h", SIMD_data_out_DEBUG);
            $display("w_enable O buf;  %h",DEBUG_enable_set);
            #1
            $display("---------");
        end
        o_ag_o_on = 0;
        #1
        $display("store results in O buf done");
        //(TOD) RESET ACC of PE
        sa_reset = 1;
        #1
        sa_reset = 0;
        //O_buf에 저장된 값 Activation으로 보내기
        for (i=0; i<(10+16-1)+2 ; i=i+1) begin //가능한 최대 값으로 실행 (정확한 count 정하지 않고)
            Intranet_on = 1;
            Intra_sig_start = 1;
            Intra_O_base_addr = 0;
            Intra_A_base_addr = 100;
            #1
            if(i == 10+(16-10)-1) begin
                $display("now?");
            end
            $display("cycle : %d", i);
            $display("data_in : %h", Intra_net_data_in_DEBUG);
            $display("data_out : %h", Intra_net_data_out_DEBUG);
            $display("end_sig : %d",Intra_sig_end);
            $display("A_wen_addr : %h", DEBUG_A_wen_addr);
            $display("---------");
        end
        //FINISH
        Intranet_on = 0;
        Intra_sig_start = 0;
        Intra_O_base_addr = 0;
        Intra_A_base_addr = 0;
        
        #1 
        $display("data_in : %h", Intra_net_data_in_DEBUG);
        $display("data_out : %h", Intra_net_data_out_DEBUG);
        $display("end_sig : %d",Intra_sig_end);
        $display("A_wen_addr : %h", DEBUG_A_wen_addr);
        $display("---------");
        $display("--------end--------");


    end
    always #0.5 clk = !clk;
endmodule