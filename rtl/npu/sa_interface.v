
`timescale 100ns/1ns
module NPU_IF #(

)(
    // Basic signals
    input   logic                   clk_i,
    input   logic                   rst_ni,
    // From bus
    input   logic                   sel_i,
    input   logic                   trans_i,
    input   logic                   ready_i,
    input   logic                   write_i,
    input   logic   [DWidth-1:0]    addr_i,
    input   logic   [DWidth-1:0]    wdata_i,
    // From activation
    input   logic   [DWidth-1:0]    rdata_i,
    // To activation
    output  logic                   wen_type_o,
    output  logic                   wen_input_o,
    output  logic   [DWidth-1:0]    addr_o,
    output  logic   [DWidth-1:0]    wdata_o,
    // To master
    output  logic   [DWidth-1:0]    rdata_o,
    output  logic                   resp_o,
    output  logic                   ready_o
);
    localparam ActBufAddr = 'h000;
    localparam WgtBufAddr = 'h400;
    localparam OutBufAddr = 'h800;
    localparam BiasBufAddr = 'hB00;

