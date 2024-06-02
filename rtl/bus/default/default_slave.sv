////////////////////////////////////////////////////////////////////////////////
// AS501
// Lab 7
// Default Slave
////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024 by Smart Energy-Efficient Design Lab. (SEED), KAIST
// All rights reserved.
//
//                            Written by Hyungjoon Bae (jo_on@kaist.ac.kr)
//                            Supervised by Wanyeong Jung (wanyeong@kaist.ac.kr)
////////////////////////////////////////////////////////////////////////////////

module DEFAULT_SLAVE #(
    parameter DWidth = 32
)(
    // Basic signals
    input   logic                   clk_i,
    input   logic                   rst_ni,
    // From master
    input   logic                   sel_i,
    input   logic                   trans_i,
    input   logic                   ready_i,
    // To master
    output  logic   [DWidth-1:0]    rdata_o,
    output  logic                   resp_o,
    output  logic                   ready_o
);
    import pkg_trans::*;
    import pkg_resp::*;

    assign  rdata_o = '0;

////////////////////////////////////////////////////////////////////////////////
// Mealy machine
    // FSM states
    typedef enum logic { // 1-bit enumerated type
        StIdle, StError
    } default_state_e;

    default_state_e                 default_state_d, default_state_q;

    // Combinational logic for next state & logic for outputs
    always_comb begin
        unique case (default_state_q)
            // Address phase
            StIdle: begin
                default_state_d   = (({sel_i, ready_i} == 2'b11) && (trans_i inside {NONSEQ})) ? StError : StIdle;
                {resp_o, ready_o} = default_state_d inside {StIdle} ? SUCCESS : ERROR_1;
            end
            // StError
            default: begin
                default_state_d   = StIdle;
                {resp_o, ready_o} = ERROR_2;
            end
        endcase
    end

    // FSM register
    D_FF #(.DWidth(1), .RValue(StIdle)) FF_DEFAULT_STATE(
        .clk_i                      (clk_i),
        .rst_ni                     (rst_ni),
        .write_en_i                 (1'b1),
        .write_data_i               (default_state_d[0]),
        .read_data_o                (default_state_q[0])
    );

endmodule