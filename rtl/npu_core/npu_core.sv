////////////////////////////////////////////////////////////////////////////////
// AS501
// Lab 7
// CPU Top Module
////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024 by Smart Energy-Efficient Design Lab. (SEED), KAIST
// All rights reserved.
//
//                            Written by Hyungjoon Bae (jo_on@kaist.ac.kr)
//                            Supervised by Wanyeong Jung (wanyeong@kaist.ac.kr)
////////////////////////////////////////////////////////////////////////////////

module NPU_CORE #(
    parameter DWidth     = 32
)(
    // Basic signals
    input   logic                   clk_i,
    input   logic                   rst_ni,
    // Memory interface
    input   logic                   mem_ready_i,
    input   logic   [DWidth-1:0]    mem_rdata_i,
    input   logic                   mem_resp_i,
    output  logic   [DWidth-1:0]    mem_addr_o,
    output  logic                   mem_trans_o,
    output  logic                   mem_write_o,
    output  logic   [DWidth-1:0]    mem_wdata_o
);

    // Instruction interface
    logic                           imem_ready;
    logic   [DWidth-1:0]            imem_rdata;
    logic   [DWidth-1:0]            imem_addr;
    logic                           imem_req;
    // Data interface
    logic                           dmem_ready;
    logic   [DWidth-1:0]            dmem_rdata;
    logic   [DWidth-1:0]            dmem_wdata;
    logic   [DWidth-1:0]            dmem_addr;
    logic                           dmem_req;
    logic                           dmem_write;

    CORE_IF #(.DWidth(DWidth)) CORE_IF(
        .clk_i                      (clk_i),
        .rst_ni                     (rst_ni),
        .imem_ready_o               (imem_ready),
        .imem_rdata_o               (imem_rdata),
        .imem_addr_i                (imem_addr),
        .imem_req_i                 (imem_req),
        .dmem_ready_o               (dmem_ready),
        .dmem_rdata_o               (dmem_rdata),
        .dmem_wdata_i               (dmem_wdata),
        .dmem_addr_i                (dmem_addr),
        .dmem_req_i                 (dmem_req),
        .dmem_write_i               (dmem_write),
        .mem_ready_i                (mem_ready_i),
        .mem_rdata_i                (mem_rdata_i),
        .mem_resp_i                 (mem_resp_i),
        .mem_addr_o                 (mem_addr_o),
        .mem_trans_o                (mem_trans_o),
        .mem_write_o                (mem_write_o),
        .mem_wdata_o                (mem_wdata_o)
    );

    logic                           icache_read;
    logic   [DWidth-1:0]            icache_addr;
    logic   [DWidth-1:0]            icache_rdata;
    logic                           icache_hit;

    INSTR_CACHE #(.DWidth(DWidth)) ICACHE(
        .clk_i                      (clk_i),
        .rst_ni                     (rst_ni),
        .read_i                     (icache_read),
        .addr_i                     (icache_addr),
        .imem_rdata_i               (imem_rdata),
        .imem_ready_i               (imem_ready),
        .imem_addr_o                (imem_addr),
        .imem_req_o                 (imem_req),
        .instr_o                    (icache_rdata),
        .hit_o                      (icache_hit)
    );

    SCALAR_CORE #(.DWidth(DWidth)) SCORE(
        .clk_i                      (clk_i),
        .rst_ni                     (rst_ni),
        .imem_ready_i               (icache_hit),
        .imem_rdata_i               (icache_rdata),
        .imem_addr_o                (icache_addr),
        .imem_req_o                 (icache_read),
        .dmem_ready_i               (dmem_ready),
        .dmem_rdata_i               (dmem_rdata),
        .dmem_wdata_o               (dmem_wdata),
        .dmem_addr_o                (dmem_addr),
        .dmem_req_o                 (dmem_req),
        .dmem_write_o               (dmem_write)
    );

endmodule