////////////////////////////////////////////////////////////////////////////////
// AS501
// Lab 7
// Bus Interconnect
////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024 by Smart Energy-Efficient Design Lab. (SEED), KAIST
// All rights reserved.
//
//                            Written by Hyungjoon Bae (jo_on@kaist.ac.kr)
//                            Supervised by Wanyeong Jung (wanyeong@kaist.ac.kr)
////////////////////////////////////////////////////////////////////////////////
module INTERCONNECT #(
    parameter DWidth      = 32,
    parameter Slave0Start = '0,
    parameter Slave0End   = '0,
    parameter Slave1Start = '0,
    parameter Slave1End   = '0,
    parameter NumofSlave  = 2,
    localparam MuxWidth   = $clog2(NumofSlave+1)
)(
    // Basic signals
    input   logic                   clk_i,
    input   logic                   rst_ni,
    // Master to bus
    input   logic   [DWidth-1:0]    addr_i,
    // Slave to bus
    input   logic   [DWidth-1:0]    rdata_i[0:NumofSlave],
    input   logic                   resp_i[0:NumofSlave],
    input   logic                   readyout_i[0:NumofSlave],
    // Slave selection signals
    output  logic                   sel_o[0:NumofSlave],
    // Bus to Master
    output  logic   [DWidth-1:0]    rdata_o,
    output  logic                   resp_o,
    output  logic                   ready_o
);

    logic           [MuxWidth-1:0]  mux_sel;

    BUS_DECODER #(.DWidth(DWidth), .Slave0Start(Slave0Start),
                  .Slave0End(Slave0End), .Slave1Start(Slave1Start),
                  .Slave1End(Slave1End), .NumofSlave(NumofSlave)) DECODER(
        .clk_i                      (clk_i),
        .rst_ni                     (rst_ni),
        .addr_i                     (addr_i),
        .sel_o                      (sel_o[0:NumofSlave]),
        .mux_sel_o                  (mux_sel)
    );

    BUS_MUX #(.DWidth(DWidth), .NumofSlave(NumofSlave)) MUX(
        .rdata_i                    (rdata_i[0:NumofSlave]),
        .resp_i                     (resp_i[0:NumofSlave]),
        .readyout_i                 (readyout_i[0:NumofSlave]),
        .mux_sel_i                  (mux_sel),
        .rdata_o                    (rdata_o),
        .resp_o                     (resp_o),
        .ready_o                    (ready_o)
    );

endmodule