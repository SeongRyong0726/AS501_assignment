`timescale 100ns/1ns'
module Intra_net_addr_gen #(
    parameter integer OUT_DATA_WIDTH = 32,
    parameter integer ACT_DATA_WIDTH = 8,
    parameter integer ADDR_WIDTH = ,
    parameter integer IDX_WIDTH = 4 // 16 bufs
)(
    input wire clk,
    input wire reset,

    input wire O_base_addr,
    input wire A_base_addr,

    input wire num_of_col,
    input wire num_of_row,

    input wire start_signal,
    output wire end_signal
    output wire [ADDR_WIDTH-1:0]O_addr,
    output wire [ADDR_WIDTH-1:0]A_addr,
    output wire A_w_en,
);
/*
    parameter : base_addr of outputbuf and activation buf, num_of_col, num_of_row
                + start_signal
                + end_signal (out)
    Result casting 32 --> 8
*/
    
endmodule