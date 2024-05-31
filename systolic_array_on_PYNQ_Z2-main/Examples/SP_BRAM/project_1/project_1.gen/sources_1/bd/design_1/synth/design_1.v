//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
//Date        : Thu Nov  9 19:08:37 2023
//Host        : DESKTOP-OJLJP2J running 64-bit major release  (build 9200)
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=3,numReposBlks=3,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=1,numPkgbdBlks=0,bdsource=USER,da_bram_cntlr_cnt=2,da_clkrst_cnt=1,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (DEBUG_state,
    addr,
    clk,
    data_in,
    web);
  output [5:0]DEBUG_state;
  input [31:0]addr;
  input clk;
  input [31:0]data_in;
  input [3:0]web;

  wire [31:0]addr_1;
  wire [31:0]axi_bram_ctrl_0_bram_douta;
  wire clk_1;
  wire [31:0]data_in_1;
  wire [5:0]fsm_copy_0_DEBUG_state;
  wire [31:0]fsm_copy_0_addr_sp_bram;
  wire [31:0]fsm_copy_0_data_in_sp_bram;
  wire fsm_copy_0_enable_sp_bram;
  wire [3:0]fsm_copy_0_w_enable_sp_bram;
  wire [3:0]web_1;
  wire [0:0]xlconstant_0_dout;

  assign DEBUG_state[5:0] = fsm_copy_0_DEBUG_state;
  assign addr_1 = addr[31:0];
  assign clk_1 = clk;
  assign data_in_1 = data_in[31:0];
  assign web_1 = web[3:0];
  design_1_axi_bram_ctrl_0_bram_0 axi_bram_ctrl_0_bram
       (.addra(fsm_copy_0_addr_sp_bram),
        .addrb(addr_1),
        .clka(clk_1),
        .clkb(clk_1),
        .dina(fsm_copy_0_data_in_sp_bram),
        .dinb(data_in_1),
        .douta(axi_bram_ctrl_0_bram_douta),
        .ena(fsm_copy_0_enable_sp_bram),
        .enb(fsm_copy_0_enable_sp_bram),
        .rsta(xlconstant_0_dout),
        .rstb(xlconstant_0_dout),
        .wea(fsm_copy_0_w_enable_sp_bram),
        .web(web_1));
  design_1_fsm_copy_0_0 fsm_copy_0
       (.DEBUG_state(fsm_copy_0_DEBUG_state),
        .addr_sp_bram(fsm_copy_0_addr_sp_bram),
        .clk(clk_1),
        .data_in_sp_bram(fsm_copy_0_data_in_sp_bram),
        .data_out_sp_bram(axi_bram_ctrl_0_bram_douta),
        .enable_sp_bram(fsm_copy_0_enable_sp_bram),
        .w_enable_sp_bram(fsm_copy_0_w_enable_sp_bram));
  design_1_xlconstant_0_0 xlconstant_0
       (.dout(xlconstant_0_dout));
endmodule
