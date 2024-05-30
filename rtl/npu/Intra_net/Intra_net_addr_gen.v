`timescale 100ns/1ns
module Intra_net_addr_gen #(
    parameter integer OUT_DATA_WIDTH = 32,
    parameter integer ACT_DATA_WIDTH = 8,
    parameter integer ADDR_WIDTH = 10,
    parameter integer IDX_WIDTH = 4, // 16 bufs
    parameter integer COL_DIM = 16
)(
    input wire clk,
    input wire reset,

    input wire [ADDR_WIDTH-1:0] O_base_addr,
    input wire [ADDR_WIDTH-1:0] A_base_addr,
    input wire [$clog2(COL_DIM)-1 : 0]      A,

    // input wire [IDX_WIDTH-1:0]  num_of_col,
    // input wire [IDX_WIDTH-1:0]  num_of_row,

    input wire start_signal,

    output wire [ADDR_WIDTH-1:0]O_addr,
    output wire [ADDR_WIDTH-1:0]A_addr,
    output wire A_w_en
);
/*
    parameter : base_addr of outputbuf and activation buf, 
                + start_signal
                + end_signal (out)
    Result casting 32 --> 8
*/

reg [ADDR_WIDTH-1:0]O_addr_offset;
reg [ADDR_WIDTH-1:0]A_addr_offset;
reg [IDX_WIDTH : 0] delay_count;
wire start_signal_a;
wire start_signal_o;

always @(posedge clk)
begin
    if(start_signal)
        delay_count <= delay_count + 1;
    else
        delay_count <= 0;
end

assign start_signal_a = (delay_count > A-1)? 1'b1 : 1'b0;  
assign A_w_en = start_signal_a;
assign start_signal_o = start_signal;

always @(posedge clk)
begin
    if(start_signal_o)
    begin
        O_addr_offset <= O_addr_offset + 'b1;
    end
    else begin
        O_addr_offset <= 0;
    end
    if(start_signal_a)
    begin
        A_addr_offset <= A_addr_offset + 'b1;
    end
    else begin
        A_addr_offset <= 0;
    end
end

assign O_addr = O_base_addr + O_addr_offset;
assign A_addr = A_base_addr + A_addr_offset;

    
endmodule