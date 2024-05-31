`timescale 100ns/1ns
module tb_accumulator #(
    parameter integer DEPTH = 8,
    parameter integer ARRAY_M = 8,
    parameter integer DATA_WIDTH = 32,
    parameter integer DATA_SET_WIDTH = ARRAY_M * DATA_WIDTH,
    parameter integer IDX_WIDTH = $clog2(DEPTH),
    parameter integer IDX_SET_WIDTH = IDX_WIDTH * ARRAY_M
);
    reg clk;
    reg reset;
    reg [DATA_SET_WIDTH-1:0] data_set_in;
    reg                      on;
    reg [$clog2(ARRAY_M) : 0] num_cols;
    reg                          drain;
    wire [DATA_SET_WIDTH-1 : 0] acc_out;

    accumulator #(
        .DEPTH(DEPTH),
        .ARRAY_M(ARRAY_M),
        .DATA_WIDTH(DATA_WIDTH)
    ) tb_accumulator (
        .clk(clk),
        .reset(reset),
        .data_set_in(data_set_in),
        .on(on),
        .num_cols(num_cols),
        .drain(drain),
        .acc_out(acc_out)
    );
    integer cycle;
    integer c;
    initial begin
        clk = 1;
        reset =1;
        data_set_in =0;
        on = 0;
        num_cols = 0;
        drain = 0;
        #1
        //accumulator start
        reset = 0;
        on = 1;
        num_cols = 8;
        drain = 0;
            //data_set_in
        for(cycle = 0 ; cycle < (DEPTH + ARRAY_M -1); cycle = cycle + 1)
        begin
        for(c = 0; c < ARRAY_M; c = c+1)
        begin
            if(cycle >= c && cycle < DEPTH + c)
                data_set_in[DATA_WIDTH*c+:DATA_WIDTH] = (cycle - c);
            else 
                data_set_in[DATA_WIDTH*c+:DATA_WIDTH] = 'b0;
        end 
        #1;
        end
        //drain
        on = 1;
        drain = 1;



    end
    always #0.5 clk = !clk;
endmodule