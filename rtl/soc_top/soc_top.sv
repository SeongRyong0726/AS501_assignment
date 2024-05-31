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

module SOC_TOP #(
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
    
    logic                           b2m_ready;
    logic   [DWidth-1:0]            b2m_rdata;
    logic                           b2m_resp;
    logic   [DWidth-1:0]            m2s_addr;
    logic                           m2s_trans;
    logic                           m2s_write;
    logic   [DWidth-1:0]            m2s_wdata;

    logic   [DWidth-1:0]            s2b_rdata[0:NumofSlave-1];
    logic                           s2b_resp[0:NumofSlave-1];
    logic                           s2b_ready[0:NumofSlave-1];
    logic                           b2s_sel[0:NumofSlave-1];

    //  I/F Conversion b/w Ext. Mem (Slave 0) & AHB BUS-Lite
    assign  s2b_rdata[0]    =   dmem_rdata_i;
    assign  s2b_resp[0]     =   1'b0;
    assign  s2b_ready[0]    =   dmem_ready_i;

    assign  dmem_wdata_o    =   m2s_wdata;
    assign  dmem_addr_o     =   m2s_addr;
    assign  dmem_req_o      =   m2s_trans & b2s_sel[0];
    assign  dmem_write_o    =   m2s_write;

    // Master
    CPU_TOP #(.DWidth(DWidth)) DUT(
        .clk_i                      (clk),
        .rst_ni                     (rst_n),

        .imem_ready_i               (imem_ready_i),
        .imem_rdata_i               (imem_rdata_i),
        .imem_addr_o                (imem_addr_o),
        .imem_req_o                 (imem_req_o),

        .dmem_ready_i               (b2m_ready),
        .dmem_rdata_i               (b2m_rdata),
        .dmem_wdata_o               (m2s_wdata),
        .dmem_addr_o                (m2s_addr),
        .dmem_req_o                 (m2s_trans),
        .dmem_write_o               (m2s_write)
    );

    BUS_TOP #(.DWidth(DWidth), .NumofSlave(NumofSlave)) BUS(
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

    // Slave 1
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


endmodule