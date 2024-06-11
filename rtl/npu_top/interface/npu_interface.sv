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

module NPU_IF #(
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
    // From NPU
    input   logic   [DWidth-1:0]    rdata_i,
    // To NPU
    output  logic                   wen_o,
    output  logic                   cen_o,
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
    import pkg_memorymap::*;

    localparam TypeAddr   = 'h0;
    localparam InputAddr  = 'h4;
    localparam OutputAddr = 'h8;
    
    localparam NPUAddr  = 1;

////////////////////////////////////////////////////////////////////////////////
// Latched data
    logic                           wen_latch;
    logic   [DWidth-1:0]            latched_output;

    D_FF #(.DWidth(DWidth), .RValue('0)) FF_ACT_LATCHED(
        .clk_i                      (clk_i),
        .rst_ni                     (rst_ni),
        .write_en_i                 (wen_latch),
        .write_data_i               (rdata_o),
        .read_data_o                (latched_output)
    );
    logic [DWidth-1 : 0] rdata_i_reg;

    always @(posedge clk_i) begin
        if(!rst_ni) begin
            rdata_i_reg = 0;
        end
        else begin
            rdata_i_reg <= rdata_i;
        end
    end
////////////////////////////////////////////////////////////////////////////////
// Mealy machine
    // FSM states
    typedef enum logic [1:0] { // 2-bit enumerated type
        StIdle, StRead, StWrite
    } act_state_e;

    act_state_e                     act_state_d, act_state_q;

    always_comb begin
        unique case (act_state_q)
            StIdle: begin
                act_state_d       = (({sel_i, ready_i} == 2'b11) && (trans_i inside {NONSEQ})) ? (write_i) ? StWrite : StRead : StIdle;
                {resp_o, ready_o} = SUCCESS;
                wen_latch         = FALSE;
                wen_o             = act_state_d inside {StWrite} && (addr_i[28] == NPUAddr);
                cen_o             = ((act_state_d inside {StWrite}) || (act_state_d inside {StRead})) && (addr_i[28] == NPUAddr);
                rdata_o           = latched_output;
            end
            StRead: begin
                act_state_d       = (({sel_i, ready_i} == 2'b11) && (trans_i inside {NONSEQ})) ? (write_i) ? StWrite : StRead : StIdle;
                {resp_o, ready_o} = SUCCESS;
                wen_latch         = TRUE;
                wen_o             = act_state_d inside {StWrite} && (addr_i[28] == NPUAddr);
                cen_o             = ((act_state_d inside {StWrite}) || (act_state_d inside {StRead})) && (addr_i[28] == NPUAddr);
                rdata_o           = rdata_i;
            end
            StWrite: begin
                act_state_d       = (({sel_i, ready_i} == 2'b11) && (trans_i inside {NONSEQ})) ? (write_i) ? StWrite : StRead : StIdle;
                {resp_o, ready_o} = SUCCESS;
                wen_latch         = FALSE;
                wen_o             = act_state_d inside {StWrite} && (addr_i[28] == NPUAddr);
                cen_o             = ((act_state_d inside {StWrite}) || (act_state_d inside {StRead})) && (addr_i[28] == NPUAddr);
                rdata_o           = latched_output;
            end
            default: begin
                act_state_d       = StIdle;
                {resp_o, ready_o} = PENDING;
                wen_latch         = FALSE;
                wen_o       = FALSE;
                cen_o             = FALSE;
                rdata_o           = '0;
            end
        endcase
    end

    assign  addr_o  = addr_i;
    assign  wdata_o = wdata_i;

    // FSM register
    D_FF #(.DWidth(2), .RValue(StIdle)) FF_ACT_STATE (
        .clk_i                      (clk_i),
        .rst_ni                     (rst_ni),
        .write_en_i                 (1'b1),
        .write_data_i               (act_state_d[1:0]),
        .read_data_o                (act_state_q[1:0])
    );

endmodule