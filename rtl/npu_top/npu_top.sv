////////////////////////////////////////////////////////////////////////////////
// AS501
// Lab 7
// Activation Top Module
////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024 by Smart Energy-Efficient Design Lab. (SEED), KAIST
// All rights reserved.
//
//                            Written by Hyungjoon Bae (jo_on@kaist.ac.kr)
//                            Supervised by Wanyeong Jung (wanyeong@kaist.ac.kr)
////////////////////////////////////////////////////////////////////////////////

module ACTIVATION_TOP #(
    parameter DWidth   = 32
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
    // To master
    output  logic   [DWidth-1:0]    rdata_o,
    output  logic                   resp_o,
    output  logic                   ready_o
);

    localparam TypeAddr   = 'h0;
    localparam InputAddr  = 'h4;
    localparam OutputAddr = 'h8;

    logic   [DWidth-1:0]            rdata;
    logic                           wen_type;
    logic                           wen_input;
    logic   [DWidth-1:0]            addr;
    logic   [DWidth-1:0]            wdata;

    NPU_IF #(.DWidth(DWidth)) ACTIVATION_IF(
        // From Bus
        .clk_i                      (clk_i),
        .rst_ni                     (rst_ni),
        .sel_i                      (sel_i),
        .trans_i                    (trans_i),
        .ready_i                    (ready_i),
        .write_i                    (write_i),
        .addr_i                     (addr_i),
        .wdata_i                    (wdata_i),

        // NPU
        .rdata_i                    (rdata),
        .wen_type_o                 (wen_type),
        .wen_input_o                (wen_input),
        .addr_o                     (addr),
        .wdata_o                    (wdata),

        // To Bus
        .rdata_o                    (rdata_o),
        .resp_o                     (resp_o),
        .ready_o                    (ready_o)
    );

    NPU #(.DWidth(DWidth)) NPU(
        .clk_i                      (clk_i),
        .rst_ni                     (rst_ni),
        .wen_type_i                 (wen_type),
        .wen_input_i                (wen_input),
        .addr_i                     (addr),
        .wdata_i                    (wdata),
        .rdata_o                    (rdata)
    );

endmodule