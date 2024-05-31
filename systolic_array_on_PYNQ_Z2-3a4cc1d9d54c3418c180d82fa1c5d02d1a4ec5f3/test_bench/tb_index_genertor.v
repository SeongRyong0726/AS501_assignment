`timescale 100ns/1ns
module tb_index_generator #(
    parameter integer DEPTH = 16,
    parameter integer ARRAY_M = 8,
    parameter integer IDX_WIDTH = $clog2(DEPTH),
    parameter integer IDX_SET_WIDTH = IDX_WIDTH * ARRAY_M
);

    reg                  clk;
    reg                  reset;
    reg                  on;
    reg  [$clog2(ARRAY_M) : 0] num_cols;
    reg                     drain;

    wire [IDX_SET_WIDTH-1:0] idx_set;
    wire [ARRAY_M-1:0]   enable_set;

    index_generator #(
        .DEPTH(DEPTH),
        .ARRAY_M(ARRAY_M)
    ) ig_inst (
        .clk(clk),
        .reset(reset),
        .on(on),
        .num_cols(num_cols),
        .drain(drain),
        .idx_set(idx_set),
        .enable_set(enable_set)
    );

    initial begin
        clk = 1;
        reset = 1;
        on = 0;
        num_cols =0;
        drain = 0;
        #1

        reset = 0;
        on = 1;
        num_cols = 8;
        drain =0;
        #(DEPTH)
        on = 0;
        #(ARRAY_M -1)
        drain = 1;
        #DEPTH
        drain = 0;
        

    end
    always #0.5 clk = !clk;
endmodule