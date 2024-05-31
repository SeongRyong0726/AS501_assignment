////////////////////////////////////////////////////////////////////////////////
// AS501
// Lab 7
// Bus Decoder
////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024 by Smart Energy-Efficient Design Lab. (SEED), KAIST
// All rights reserved.
//
//                            Written by Hyungjoon Bae (jo_on@kaist.ac.kr)
//                            Supervised by Wanyeong Jung (wanyeong@kaist.ac.kr)
////////////////////////////////////////////////////////////////////////////////

module BUS_DECODER #(
    parameter DWidth      = 32,
    parameter NumofSlave  = 2,
    localparam MuxWidth   = $clog2(NumofSlave+1)
)(
    // Basic signals
    input   logic                   clk_i,
    input   logic                   rst_ni,
    // From master
    input   logic   [DWidth-1:0]    addr_i,
    // To master
    output  logic                   sel_o[0:NumofSlave],
    output  logic   [MuxWidth-1:0]  mux_sel_o
);
    import pkg_memorymap::*;

    always_comb begin
        if (addr_i >= Slave0_Start && addr_i < Slave0_End) begin
            mux_sel_o = 'd0;
        end else if (addr_i >= Slave1_Start && addr_i < Slave1_End) begin
            mux_sel_o = 'd1;
        end else begin
            mux_sel_o = $pow(2, MuxWidth) - 'd1;
        end

        for (int i = 0; i <= NumofSlave; ++i) begin
            if (i == mux_sel_o) begin
                sel_o[i] = 1'b1;
            end else begin
                sel_o[i] = 1'b0;
            end
        end
    end

endmodule