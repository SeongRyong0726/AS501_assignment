// -----------------------
// ?�� accumulator.v
// 	?�� acc.v
// 	?�� index_generator.v
// -----------------------

`timescale 100ns/1ns
module accumulator #(
    parameter integer DEPTH = 8,
    parameter integer ARRAY_M = 8,
    parameter integer DATA_WIDTH = 32,
    parameter integer DATA_SET_WIDTH = ARRAY_M * DATA_WIDTH,
    parameter integer IDX_WIDTH = $clog2(DEPTH),
    parameter integer IDX_SET_WIDTH = IDX_WIDTH * ARRAY_M
) (
    input wire clk,
    input wire reset,
    input wire acc_reset,
    input wire [DATA_SET_WIDTH-1:0] data_set_in,
    input wire                      on,
    input wire [$clog2(ARRAY_M) : 0] num_cols,
    input wire                          drain,
    output wire [DATA_SET_WIDTH-1 : 0] acc_out
);
    wire [IDX_SET_WIDTH-1:0] idx_set_w;
    wire [ARRAY_M-1:0] enable_set_w;

    index_generator #(
        .DEPTH(DEPTH),
        .ARRAY_M(ARRAY_M)
    ) ig_inst (
        .clk(clk),
        .reset(reset),
        .on(on),
        .num_cols(num_cols),
        .drain(drain),
        .idx_set(idx_set_w),            //output
        .enable_set(enable_set_w)       //output
    );

    acc #(
        .DEPTH(DEPTH),
        .ARRAY_M(ARRAY_M),
        .DATA_WIDTH(DATA_WIDTH) 
    ) acc_inst (
        .clk(clk),
        .reset(acc_reset),
        .idx_set(idx_set_w),
        .data_set(data_set_in),
        .enable_set(enable_set_w),
        .drain(drain),
        .acc_out(acc_out)           //output
    );
endmodule