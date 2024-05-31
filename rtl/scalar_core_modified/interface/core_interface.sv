////////////////////////////////////////////////////////////////////////////////
// AS501
// Lab 7
// Core Interface
////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024 by Smart Energy-Efficient Design Lab. (SEED), KAIST
// All rights reserved.
//
//                            Written by Hyungjoon Bae (jo_on@kaist.ac.kr)
//                            Supervised by Wanyeong Jung (wanyeong@kaist.ac.kr)
////////////////////////////////////////////////////////////////////////////////

module CORE_IF #(
    parameter DWidth = 32
)(
    // Basic signals
    input   logic                   clk_i,
    input   logic                   rst_ni,
    // From/To core and icache
    output  logic                   imem_ready_o,
    output  logic   [DWidth-1:0]    imem_rdata_o,
    input   logic   [DWidth-1:0]    imem_addr_i,
    input   logic                   imem_req_i,
    output  logic                   dmem_ready_o,
    output  logic   [DWidth-1:0]    dmem_rdata_o,
    input   logic   [DWidth-1:0]    dmem_wdata_i,
    input   logic   [DWidth-1:0]    dmem_addr_i,
    input   logic                   dmem_req_i,
    input   logic                   dmem_write_i,
    // To memory
    input   logic                   mem_ready_i,
    input   logic   [DWidth-1:0]    mem_rdata_i,
    input   logic                   mem_resp_i,
    output  logic   [DWidth-1:0]    mem_addr_o,
    output  logic                   mem_trans_o,
    output  logic                   mem_write_o,
    output  logic   [DWidth-1:0]    mem_wdata_o
);
    import pkg_bool::*;
    import pkg_resp::*;
    import pkg_trans::*;

////////////////////////////////////////////////////////////////////////////////
// Latched address
    logic   [DWidth-1:0]            latched_addr;

    D_FF #(.DWidth(DWidth), .RValue('0)) FF_ADDR(
        .clk_i                      (clk_i),
        .rst_ni                     (rst_ni),
        .write_en_i                 (dmem_req_i || imem_req_i),
        .write_data_i               (mem_addr_o),
        .read_data_o                (latched_addr)
    );

////////////////////////////////////////////////////////////////////////////////
// Latched instruction
    logic   [DWidth-1:0]            latched_irdata;

    D_FF #(.DWidth(DWidth), .RValue('0)) FF_IRDATA(
        .clk_i                      (clk_i),
        .rst_ni                     (rst_ni),
        .write_en_i                 (imem_ready_o),
        .write_data_i               (mem_rdata_i),
        .read_data_o                (latched_irdata)
    );

////////////////////////////////////////////////////////////////////////////////
// Latched rdata
    logic   [DWidth-1:0]            latched_drdata;

    D_FF #(.DWidth(DWidth), .RValue('0)) FF_DRDATA(
        .clk_i                      (clk_i),
        .rst_ni                     (rst_ni),
        .write_en_i                 (dmem_ready_o),
        .write_data_i               (mem_rdata_i),
        .read_data_o                (latched_drdata)
    );

////////////////////////////////////////////////////////////////////////////////
// Mealy machine
    // FSM states
    typedef enum logic [1:0] { // 2-bit enumerated type
        StAddr, StDdata, StIdata
    } core_if_state_e;

    core_if_state_e                 core_if_state_d, core_if_state_q;

    // Combinational logic for next state & logic for outputs
    always_comb begin
        unique case (core_if_state_q)
            // Address phase
            StAddr: begin
                // If memory response is success, go to Ddata or Idata
                // else stay in address phase
                core_if_state_d = ({mem_resp_i, mem_ready_i} inside {SUCCESS}) ? (dmem_req_i ? StDdata : (imem_req_i ? StIdata : StAddr)) : StAddr;
                mem_addr_o      = dmem_req_i ? dmem_addr_i : imem_req_i ? imem_addr_i : latched_addr;
                mem_trans_o     = core_if_state_d inside {StDdata, StIdata} ? NONSEQ : IDLE;
                mem_write_o     = core_if_state_d inside {StDdata} ? dmem_write_i : FALSE;
                mem_wdata_o     = dmem_wdata_i;
                imem_ready_o    = FALSE;
                imem_rdata_o    = latched_irdata;
                dmem_ready_o    = FALSE;
                dmem_rdata_o    = latched_drdata;
            end
            // Data phase
            StDdata: begin
                // (memory == SUCCESS) && (next request == data), stay in Ddata
                // (memory == SUCCESS) && (next request == instruction), go to Idata
                // (memory == SUCCESS) && (next request == null), go to address
                // (memory != SUCCESS), stay in Ddata
                core_if_state_d = ({mem_resp_i, mem_ready_i} inside {SUCCESS}) ? (dmem_req_i ? StDdata : (imem_req_i ? StIdata : StAddr)) : StDdata;
                mem_addr_o      = dmem_req_i ? dmem_addr_i : imem_req_i ? imem_addr_i : latched_addr;
                mem_trans_o     = core_if_state_d inside {StDdata, StIdata} ? NONSEQ : IDLE;
                mem_write_o     = core_if_state_d inside {StDdata} ? dmem_write_i : FALSE;
                mem_wdata_o     = dmem_wdata_i;
                imem_ready_o    = FALSE;
                imem_rdata_o    = latched_irdata;
                dmem_ready_o    = {mem_resp_i, mem_ready_i} inside {SUCCESS};
                dmem_rdata_o    = mem_rdata_i;
            end
            StIdata: begin
                // (memory == SUCCESS) && (next request == data), go to Ddata
                // (memory == SUCCESS) && (next request == instruction), stay in Idata
                // (memory == SUCCESS) && (next request == null), go to address
                // (memory != SUCCESS), stay in Idata
                core_if_state_d = ({mem_resp_i, mem_ready_i} inside {SUCCESS}) ? (dmem_req_i ? StDdata : (imem_req_i ? StIdata : StAddr)) : StIdata;
                mem_addr_o      = dmem_req_i ? dmem_addr_i : imem_req_i ? imem_addr_i : latched_addr;
                mem_trans_o     = core_if_state_d inside {StDdata, StIdata} ? NONSEQ : IDLE;
                mem_write_o     = core_if_state_d inside {StDdata} ? dmem_write_i : FALSE;
                mem_wdata_o     = dmem_wdata_i;
                imem_ready_o    = {mem_resp_i, mem_ready_i} inside {SUCCESS};
                imem_rdata_o    = mem_rdata_i;
                dmem_ready_o    = FALSE;
                dmem_rdata_o    = latched_drdata;
            end
            default: begin
                core_if_state_d = StAddr;
                mem_addr_o      = '0;
                mem_trans_o     = IDLE;
                mem_write_o     = FALSE;
                mem_wdata_o     = '0;
                imem_ready_o    = FALSE;
                imem_rdata_o    = '0;
                dmem_ready_o    = FALSE;
                dmem_rdata_o    = '0;
            end
        endcase
    end

    // FSM register
    D_FF #(.DWidth(2), .RValue(StAddr)) FF_CORE_IF_STATE(
        .clk_i                      (clk_i),
        .rst_ni                     (rst_ni),
        .write_en_i                 (1'b1),
        .write_data_i               (core_if_state_d[1:0]),
        .read_data_o                (core_if_state_q[1:0])
    );

endmodule