////////////////////////////////////////////////////////////////////////////////
// AS501
// Lab 7
// Bus Multiplexer
////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024 by Smart Energy-Efficient Design Lab. (SEED), KAIST
// All rights reserved.
//
//                            Written by Hyungjoon Bae (jo_on@kaist.ac.kr)
//                            Supervised by Wanyeong Jung (wanyeong@kaist.ac.kr)
////////////////////////////////////////////////////////////////////////////////

module BUS_MUX #(
    parameter DWidth     = 32,
    parameter NumofSlave = 1,
    localparam MuxWidth  = $clog2(NumofSlave+1)
)(
    // From slave
    input   logic   [DWidth-1:0]    rdata_i[0:NumofSlave],
    input   logic                   resp_i[0:NumofSlave],
    input   logic                   readyout_i[0:NumofSlave],
    // From decoder
    input   logic   [MuxWidth-1:0]  mux_sel_i,
    // To master
    output  logic   [DWidth-1:0]    rdata_o,
    output  logic                   resp_o,
    output  logic                   ready_o
);

    assign rdata_o = rdata_i[mux_sel_i];
    assign resp_o  = resp_i[mux_sel_i];
    assign ready_o = readyout_i[mux_sel_i];

endmodule