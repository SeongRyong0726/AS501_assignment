////////////////////////////////////////////////////////////////////////////////
// AS501
// Lab 7
// Memory Interface
////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024 by Smart Energy-Efficient Design Lab. (SEED), KAIST
// All rights reserved.
//
//                            Written by Hyungjoon Bae (jo_on@kaist.ac.kr)
//                            Supervised by Wanyeong Jung (wanyeong@kaist.ac.kr)
////////////////////////////////////////////////////////////////////////////////

module MEMORY_IF #(
    parameter DWidth       = 32
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
    // From memory
    input   logic   [DWidth-1:0]    rdata_i,
    // To memory
    output  logic                   cen_o,
    output  logic                   wen_o,
    output  logic   [DWidth-1:0]    addr_o,
    output  logic   [DWidth-1:0]    wdata_o,
    // To master
    output  logic   [DWidth-1:0]    rdata_o,
    output  logic                   resp_o,
    output  logic                   ready_o
);
    import pkg_bool::*;
    import pkg_resp::*;
    import pkg_trans::*;

////////////////////////////////////////////////////////////////////////////////
// Mealy machine
    // FSM states
    typedef enum logic [1:0] { // 2-bit enumerated type
        StIdle, StRead, StWrite
    } mem_state_e;

    mem_state_e                     mem_state_d, mem_state_q;

    always_comb begin
        unique case (mem_state_q)
            StIdle: begin
                mem_state_d       = (({sel_i, ready_i} == 2'b11) && (trans_i inside {NONSEQ})) ? (write_i) ? StWrite : StRead : StIdle;
                {resp_o, ready_o} = SUCCESS;
                cen_o             = mem_state_d inside {StWrite, StRead};
                wen_o             = mem_state_d inside {StWrite};
            end
            StRead: begin
                mem_state_d       = (({sel_i, ready_i} == 2'b11) && (trans_i inside {NONSEQ})) ? (write_i) ? StWrite : StRead : StIdle;
                {resp_o, ready_o} = SUCCESS;
                cen_o             = mem_state_d inside {StRead, StWrite};
                wen_o             = mem_state_d inside {StWrite};
            end
            StWrite: begin
                mem_state_d       = (({sel_i, ready_i} == 2'b11) && (trans_i inside {NONSEQ})) ? (write_i) ? StWrite : StRead : StIdle;
                {resp_o, ready_o} = SUCCESS;
                cen_o             = mem_state_d inside {StRead, StWrite};
                wen_o             = mem_state_d inside {StWrite};
            end
            default: begin
                mem_state_d       = StIdle;
                {resp_o, ready_o} = PENDING;
                cen_o             = FALSE;
                wen_o             = FALSE;
            end
        endcase
    end

    assign  rdata_o = rdata_i;
    assign  addr_o  = addr_i;
    assign  wdata_o = wdata_i;

    // FSM register
    D_FF #(.DWidth(2), .RValue(StIdle)) FF_MEM_STATE(
        .clk_i                      (clk_i),
        .rst_ni                     (rst_ni),
        .write_en_i                 (1'b1),
        .write_data_i               (mem_state_d[1:0]),
        .read_data_o                (mem_state_q[1:0])
    );

endmodule