`timescale 100ns/1ns
module tb_Intra_net_top #(
    parameter integer ROW_DIM = 16,
    parameter integer COL_DIM = 16,
    parameter integer DATA_WIDTH = 8,
    parameter integer ADDR_WIDTH = 10,
    parameter integer IDX_WIDTH = 4
);

    reg clk;
    reg reset;
    reg sig_start;
    //configuration
    reg [$clog2(COL_DIM)-1 : 0]      A;
    reg [$clog2(COL_DIM)-1 : 0]      B;
    reg [ADDR_WIDTH-1:0] O_base_addr;
    reg [ADDR_WIDTH-1:0] A_base_addr;

    reg [ROW_DIM*DATA_WIDTH -1 : 0] data_in;
    wire [COL_DIM*DATA_WIDTH -1 : 0] data_out;
    wire sig_end;

    //memory
    wire [ADDR_WIDTH-1:0]O_addr;
    wire [ADDR_WIDTH-1:0]A_addr;
    wire A_w_en;

    Intra_net_top #(
        .ROW_DIM(ROW_DIM),
        .COL_DIM(COL_DIM),
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .IDX_WIDTH(IDX_WIDTH)
    ) Intra_net_top_inst (
        .clk(clk),
        .reset(reset),
        .sig_start(sig_start),
        .A(A),
        .B(B),
        .O_base_addr(O_base_addr),
        .A_base_addr(A_base_addr),
        .data_in(data_in),
        .data_out(data_out),
        .sig_end(sig_end),
        .O_addr(O_addr),
        .A_addr(A_addr),
        .A_w_en(A_w_en)
    );
    //OUTPUT matrix dim = (AxB) --> trans input (BxA) --> (AxB)
    // integer A = 10;
    // integer B = 8;

    initial begin
  
        clk =1;
        reset =1;
        sig_start=0;
        A=10;
        B=8;
        O_base_addr = 100;
        A_base_addr = 200;
        data_in = 0;
        #10
        //setting //128'h0102030405060708090A0B0C0D0E0F10
        reset       = 0;
        sig_start = 1;

        data_in = 128'h000000000000000008090A0B0C0D0E0F; //15 - 0
        #1
        data_in = 128'h000000000000000008090A0B0C0D0E0F; //15 - 0
        #1
        data_in = 128'h000000000000000008090A0B0C0D0E0F; //15 - 0
        #1
        data_in = 128'h000000000000000008090A0B0C0D0E0F; //15 - 0
        #1
        data_in = 128'h000000000000000008090A0B0C0D0E0F; //15 - 0
        #1
        data_in = 128'h000000000000000008090A0B0C0D0E0F; //15 - 0
        #1
        data_in = 128'h000000000000000008090A0B0C0D0E0F; //15 - 0
        #1
        data_in = 128'h000000000000000008090A0B0C0D0E0F; //15 - 0
        $display("A_w_en               = %d", A_w_en);
        $display("Output_buffer_addr   = %d", O_addr);
        $display("Input_buffer_addr    = %d", A_addr);
        $display("Data_to_Input_buffer = %h", data_out);
        $display("end_signal           = %d", sig_end);
        $display("------------------------------------");
        #1
        data_in = 128'h000000000000000008090A0B0C0D0E0F; //15 - 0
        $display("A_w_en               = %d", A_w_en);
        $display("Output_buffer_addr   = %d", O_addr);
        $display("Input_buffer_addr    = %d", A_addr);
        $display("Data_to_Input_buffer = %h", data_out);
        $display("end_signal           = %d", sig_end);
        $display("------------------------------------");
        #1
        data_in = 128'h000000000000000008090A0B0C0D0E0F; //15 - 0
        $display("A_w_en               = %d", A_w_en);
        $display("Output_buffer_addr   = %d", O_addr);
        $display("Input_buffer_addr    = %d", A_addr);
        $display("Data_to_Input_buffer = %h", data_out);
        $display("end_signal           = %d", sig_end);
        $display("------------------------------------");
        #1
        $display("Now data out");
        $display("1");
        $display("A_w_en               = %d", A_w_en);
        $display("Output_buffer_addr   = %d", O_addr);
        $display("Input_buffer_addr    = %d", A_addr);
        $display("Data_to_Input_buffer = %h", data_out);
        $display("end_signal           = %d", sig_end);
        $display("------------------------------------");
        #1
        $display("2");
        $display("A_w_en               = %d", A_w_en);
        $display("Output_buffer_addr   = %d", O_addr);
        $display("Input_buffer_addr    = %d", A_addr);
        $display("Data_to_Input_buffer = %h", data_out);
        $display("end_signal           = %d", sig_end);
        $display("------------------------------------");
        #1
        $display("3");
        $display("A_w_en               = %d", A_w_en);
        $display("Output_buffer_addr   = %d", O_addr);
        $display("Input_buffer_addr    = %d", A_addr);
        $display("Data_to_Input_buffer = %h", data_out);
        $display("end_signal           = %d", sig_end);
        $display("------------------------------------");
        #1
        $display("4");
        $display("A_w_en               = %d", A_w_en);
        $display("Output_buffer_addr   = %d", O_addr);
        $display("Input_buffer_addr    = %d", A_addr);
        $display("Data_to_Input_buffer = %h", data_out);
        $display("end_signal           = %d", sig_end);
        $display("------------------------------------");
        #1
        $display("5");
        $display("A_w_en               = %d", A_w_en);
        $display("Output_buffer_addr   = %d", O_addr);
        $display("Input_buffer_addr    = %d", A_addr);
        $display("Data_to_Input_buffer = %h", data_out);
        $display("end_signal           = %d", sig_end);
        $display("------------------------------------");
        #1
        $display("6");
        $display("A_w_en               = %d", A_w_en);
        $display("Output_buffer_addr   = %d", O_addr);
        $display("Input_buffer_addr    = %d", A_addr);
        $display("Data_to_Input_buffer = %h", data_out);
        $display("end_signal           = %d", sig_end);
        $display("------------------------------------");
        #1
        $display("7");
        $display("A_w_en               = %d", A_w_en);
        $display("Output_buffer_addr   = %d", O_addr);
        $display("Input_buffer_addr    = %d", A_addr);
        $display("Data_to_Input_buffer = %h", data_out);
        $display("end_signal           = %d", sig_end);
        $display("------------------------------------");
        #1
        $display("8");
        $display("A_w_en               = %d", A_w_en);
        $display("Output_buffer_addr   = %d", O_addr);
        $display("Input_buffer_addr    = %d", A_addr);
        $display("Data_to_Input_buffer = %h", data_out);
        $display("end_signal           = %d", sig_end);
        $display("------------------------------------");
        #1
        $display("end");
        $display("A_w_en               = %d", A_w_en);
        $display("Output_buffer_addr   = %d", O_addr);
        $display("Input_buffer_addr    = %d", A_addr);
        $display("Data_to_Input_buffer = %h", data_out);
        $display("end_signal           = %d", sig_end);
        $display("------------------------------------");
       
    end
    always #0.5 clk = !clk;
endmodule