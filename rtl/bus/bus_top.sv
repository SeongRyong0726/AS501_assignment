////////////////////////////////////////////////////////////////////////////////
// AS501
// Lab 7
// Bus Top Module
////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024 by Smart Energy-Efficient Design Lab. (SEED), KAIST
// All rights reserved.
//
//                            Written by Hyungjoon Bae (jo_on@kaist.ac.kr)
//                            Supervised by Wanyeong Jung (wanyeong@kaist.ac.kr)
////////////////////////////////////////////////////////////////////////////////

module BUS_TOP #(
    parameter DWidth      = 32,
    parameter NumofSlave  = 2,
    localparam MuxWidth   = $clog2(NumofSlave+1)
)(
    // Basic signals
    input   logic                   clk_i,
    input   logic                   rst_ni,
    // From master
    input   logic   [DWidth-1:0]    addr_i,
    input   logic                   trans_i,
    // Slave to bus
    input   logic   [DWidth-1:0]    rdata_i[0:NumofSlave-1],
    input   logic                   resp_i[0:NumofSlave-1],
    input   logic                   readyout_i[0:NumofSlave-1],
    // Slave selection signal
    output  logic                   sel_o[0:NumofSlave-1],
    // Bus to Master
    output  logic   [DWidth-1:0]    rdata_o,
    output  logic                   resp_o,
    output  logic                   ready_o
);

    logic                           sel[0:NumofSlave];
    assign sel_o[0:NumofSlave-1] =  sel[0:NumofSlave-1];

    // Default Slave
    logic   [DWidth-1:0]            rdatad;
    logic                           respd;
    logic                           readyoutd;

    DEFAULT_SLAVE #(.DWidth(DWidth)) DEFAULT_SLAVE(
        .clk_i                      (clk_i),
        .rst_ni                     (rst_ni),
        .sel_i                      (sel[NumofSlave]),
        .trans_i                    (trans_i),
        .ready_i                    (ready_o),
        .rdata_o                    (rdatad),
        .resp_o                     (respd),
        .ready_o                    (readyoutd)
    );

    INTERCONNECT #(.DWidth(DWidth), .NumofSlave(NumofSlave)) INTERCONNECT(
        .clk_i                      (clk_i),
        .rst_ni                     (rst_ni),
        .addr_i                     (addr_i),
        .rdata_i                    ({rdata_i[0:NumofSlave-1], rdatad}),
        .resp_i                     ({resp_i[0:NumofSlave-1], respd}),
        .readyout_i                 ({readyout_i[0:NumofSlave-1], readyoutd}),
        .sel_o                      (sel),
        .rdata_o                    (rdata_o),
        .resp_o                     (resp_o),
        .ready_o                    (ready_o)
    );

endmodule