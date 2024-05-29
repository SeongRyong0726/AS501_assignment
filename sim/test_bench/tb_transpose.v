`timescale 100ns/1ns
module tb_systolic_system #(
    parameter integer ROW_DIM = 16,
    parameter integer COL_DIM = 16,
    parameter integer DATA_WIDTH = 8
);

    reg clk;
    reg reset;
    reg T_start;
    reg [$clog2(COL_DIM)-1 : 0]      A;
    reg [$clog2(COL_DIM)-1 : 0]      B;

    reg [ROW_DIM*DATA_WIDTH -1 : 0] data_in;
    wire [COL_DIM*DATA_WIDTH -1 : 0] data_out;
    wire T_end;

    transpose #(
        .ROW_DIM(ROW_DIM),
        .COL_DIM(COL_DIM),
        .DATA_WIDTH(DATA_WIDTH)
    ) transpose_inst (
        .clk(clk),
        .reset(reset),

        .T_start(T_start),
        .A(A),
        .B(B),
        .data_in(data_in),
        .data_out(data_out),
        .T_end(T_end)
    );
    integer i;
    // integer A = 10;
    // integer B = 10;
    // OUTPUT BUFFER (BxA) 로 존재 이 A개씩 나와서 transpose의 옆구리로 들어가니까 
    // transpose의 input dim 은 (A x B)
    // transpose의 output dim 은 (B x A)
    // (A x B) --> (B x A)
    initial begin
        clk = 1;
        reset =1;
        T_start = 0;
        A = 10;
        B = 10;
        data_in = 0;
        #1
        T_start = 1;
        reset = 0;
        data_in = 128'h0102030405060708090A0B0C0D0E0F10;
        #10 //B
        for (i=0; i<10; i=i+1) begin //A=10
            data_in = 128'h0;
            $display("T_end = %d", T_end);
            $display("data_out = %h", data_out);
            #1
            $display("---------");
        end
        $display("T_end = %d", T_end);
        $display("data_out = %h", data_out);
        #1
        $display("T_end = %d", T_end);
        $display("data_out = %h", data_out);
    end
    always #0.5 clk = !clk;
endmodule