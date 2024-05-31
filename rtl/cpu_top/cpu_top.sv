////////////////////////////////////////////////////////////////////////////////
// AS501
// Final Project
// CPU Top Module
////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024 by Smart Energy-Efficient Design Lab. (SEED), KAIST
// All rights reserved.
//
//                            Written by Hyungjoon Bae (jo_on@kaist.ac.kr)
//                            Supervised by Wanyeong Jung (wanyeong@kaist.ac.kr)
////////////////////////////////////////////////////////////////////////////////

module CPU_TOP #(
    parameter DWidth = 32
)(
    // Basic signals
    input   logic                   clk_i,
    input   logic                   rst_ni,
    // Instruction interface
    input   logic                   imem_ready_i,
    input   logic   [DWidth-1:0]    imem_rdata_i,
    output  logic   [DWidth-1:0]    imem_addr_o,
    output  logic                   imem_req_o,
    // Data interface
    input   logic                   dmem_ready_i,
    input   logic   [DWidth-1:0]    dmem_rdata_i,
    output  logic   [DWidth-1:0]    dmem_wdata_o,
    output  logic   [DWidth-1:0]    dmem_addr_o,
    output  logic                   dmem_req_o,
    output  logic                   dmem_write_o
);
    localparam NumofSlave   = 2;
    
    logic                           icache_read;
    logic   [DWidth-1:0]            icache_addr;
    logic   [DWidth-1:0]            icache_rdata;
    logic                           icache_hit;

    logic   [DWidth-1:0]            rdata;
    logic                           cen;
    logic                           wen;
    logic   [DWidth-1:0]            addr;
    logic   [DWidth-1:0]            wdata;

    MEMORY_IF #(.DWidth(DWidth)) MEMORY_IF(
        .clk_i                      (clk_i),
        .rst_ni                     (rst_ni),
        .sel_i                      (sel_i),
        .trans_i                    (trans_i),
        .ready_i                    (ready_i),
        .write_i                    (write_i),
        .addr_i                     (addr_i),
        .wdata_i                    (wdata_i),
        .rdata_i                    (rdata),
        .cen_o                      (cen),
        .wen_o                      (wen),
        .addr_o                     (addr),
        .wdata_o                    (wdata),
        .rdata_o                    (rdata_o),
        .resp_o                     (resp_o),
        .ready_o                    (ready_o)
    );

    INSTR_CACHE #(.DWidth(DWidth)) ICACHE(
        .clk_i                      (clk_i),
        .rst_ni                     (rst_ni),
        .read_i                     (icache_read),
        .addr_i                     (icache_addr),
        .imem_rdata_i               (imem_rdata_i),
        .imem_ready_i               (imem_ready_i),
        .imem_addr_o                (imem_addr_o),
        .imem_req_o                 (imem_req_o),
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
        .dmem_ready_i               (dmem_ready_i),
        .dmem_rdata_i               (dmem_rdata_i),
        .dmem_wdata_o               (dmem_wdata_o),
        .dmem_addr_o                (dmem_addr_o),
        .dmem_req_o                 (dmem_req_o),
        .dmem_write_o               (dmem_write_o)
    );

    logic   [DWidth-1:0]    s2b_rdata   [0:NumofSlave-1];
    logic                   s2b_resp    [0:NumofSlave-1];
    logic                   s2b_ready   [0:NumofSlave-1];

    assign  s2b_rdata[0]    =   dmem_rdata_i;
    assign  s2b_resp[0]     =   1'b0;
    assign  s2b_ready[0]    =   dmem_ready_i;

    NPU_CORE #(.DWidth(DWidth)) SCORE(
        .clk_i                      (clk),
        .rst_ni                     (rst_n),
        .sel_i                      (b2s_sel[1]),
        .trans_i                    (m2s_trans),
        .ready_i                    (b2m_ready),
        .write_i                    (m2s_write),
        .addr_i                     (m2s_addr),
        .wdata_i                    (m2s_wdata),
        .ready_o                    (s2b_ready[1]),
        .resp_o                     (s2b_resp[1]),
        .rdata_o                    (s2b_rdata[1])
    );

    BUS_TOP #(.DWidth(DWidth), .Slave0Start(ImemStart),
              .Slave0End(MemDepth), .Slave1Start(ActStart),
              .Slave1End(ActEnd), .NumofSlave(NumofSlave)) BUS(
        .clk_i                      (clk),
        .rst_ni                     (rst_n),
        .addr_i                     (m2s_addr),
        .trans_i                    (m2s_trans),
        .rdata_i                    (s2b_rdata),
        .resp_i                     (s2b_resp),
        .readyout_i                 (s2b_ready),
        .sel_o                      (b2s_sel),
        .rdata_o                    (b2m_rdata),
        .resp_o                     (b2m_resp),
        .ready_o                    (b2m_ready)
    );
endmodule