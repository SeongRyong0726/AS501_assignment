`timescale 100ns/1ns
module Intra_net_top #(
    parameter integer ROW_DIM = 16,
    parameter integer COL_DIM = 16,
    parameter integer DATA_WIDTH = 8,
    parameter integer OUT_DATA_WIDTH = 32,
    parameter integer ADDR_WIDTH = 10,
    parameter integer IDX_WIDTH = 4
)(
    input wire clk,
    input wire reset,
    input wire sig_start,
    //configuration
    input wire [$clog2(COL_DIM)-1 : 0]      A,
    input wire [$clog2(COL_DIM)-1 : 0]      B,
    input wire [ADDR_WIDTH-1:0] O_base_addr,
    input wire [ADDR_WIDTH-1:0] A_base_addr,

    input wire [ROW_DIM*DATA_WIDTH -1 : 0] data_in,
    output wire [COL_DIM*DATA_WIDTH -1 : 0] data_out,
    output wire sig_end,

    //memory
    output wire [ADDR_WIDTH-1:0]O_addr,
    output wire [ADDR_WIDTH-1:0]A_addr,
    output wire A_w_en
);


    transpose #(
        .ROW_DIM(ROW_DIM),
        .COL_DIM(COL_DIM),
        .DATA_WIDTH(DATA_WIDTH)
    ) transpose_inst (
        .clk(clk),
        .reset(reset),
        .T_start(sig_start),
        .A(A),
        .B(B),
        .data_in(data_in),
        .data_out(data_out),
        .T_end(sig_end)
    );

    Intra_net_addr_gen #(
        .OUT_DATA_WIDTH(OUT_DATA_WIDTH),
        .ACT_DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .IDX_WIDTH(IDX_WIDTH),
        .COL_DIM(COL_DIM)
    ) Intra_net_addr_gen_inst (
        .clk(clk),
        .reset(reset),
        .O_base_addr(O_base_addr),
        .A_base_addr(A_base_addr),
        .A(A),
        .start_signal(sig_start),
        .O_addr(O_addr),
        .A_addr(A_addr),
        .A_w_en(A_w_en)
    );

endmodule