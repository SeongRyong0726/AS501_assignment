// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
// Date        : Thu Nov  9 19:16:32 2023
// Host        : DESKTOP-OJLJP2J running 64-bit major release  (build 9200)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               C:/Users/SROH/Desktop/SP_BRAM/project_1/project_1.sim/sim_1/synth/timing/xsim/tb_bram_combine_time_synth.v
// Design      : design_1_wrapper
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

(* HW_HANDOFF = "design_1.hwdef" *) 
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

  wire [5:0]DEBUG_state;
  wire [31:0]addr;
  wire [31:0]axi_bram_ctrl_0_bram_douta;
  wire clk;
  wire [31:0]data_in;
  wire [31:0]fsm_copy_0_addr_sp_bram;
  wire [31:0]fsm_copy_0_data_in_sp_bram;
  wire fsm_copy_0_enable_sp_bram;
  wire [3:0]fsm_copy_0_w_enable_sp_bram;
  wire [3:0]web;
  wire NLW_axi_bram_ctrl_0_bram_rsta_busy_UNCONNECTED;
  wire NLW_axi_bram_ctrl_0_bram_rstb_busy_UNCONNECTED;
  wire [31:0]NLW_axi_bram_ctrl_0_bram_doutb_UNCONNECTED;

  (* IMPORTED_FROM = "c:/Users/SROH/Desktop/SP_BRAM/project_1/project_1.gen/sources_1/bd/design_1/ip/design_1_axi_bram_ctrl_0_bram_0/design_1_axi_bram_ctrl_0_bram_0.dcp" *) 
  (* IMPORTED_TYPE = "CHECKPOINT" *) 
  (* IS_IMPORTED *) 
  (* X_CORE_INFO = "blk_mem_gen_v8_4_6,Vivado 2023.1" *) 
  design_1_axi_bram_ctrl_0_bram_0 axi_bram_ctrl_0_bram
       (.addra(fsm_copy_0_addr_sp_bram),
        .addrb(addr),
        .clka(clk),
        .clkb(clk),
        .dina(fsm_copy_0_data_in_sp_bram),
        .dinb(data_in),
        .douta(axi_bram_ctrl_0_bram_douta),
        .doutb(NLW_axi_bram_ctrl_0_bram_doutb_UNCONNECTED[31:0]),
        .ena(fsm_copy_0_enable_sp_bram),
        .enb(fsm_copy_0_enable_sp_bram),
        .rsta(1'b0),
        .rsta_busy(NLW_axi_bram_ctrl_0_bram_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_axi_bram_ctrl_0_bram_rstb_busy_UNCONNECTED),
        .wea(fsm_copy_0_w_enable_sp_bram),
        .web(web));
  (* IMPORTED_FROM = "c:/Users/SROH/Desktop/SP_BRAM/project_1/project_1.gen/sources_1/bd/design_1/ip/design_1_fsm_copy_0_0/design_1_fsm_copy_0_0.dcp" *) 
  (* IMPORTED_TYPE = "CHECKPOINT" *) 
  (* IS_IMPORTED *) 
  (* X_CORE_INFO = "fsm_copy,Vivado 2023.1" *) 
  design_1_fsm_copy_0_0 fsm_copy_0
       (.DEBUG_state(DEBUG_state),
        .addr_sp_bram(fsm_copy_0_addr_sp_bram),
        .clk(clk),
        .data_in_sp_bram(fsm_copy_0_data_in_sp_bram),
        .data_out_sp_bram(axi_bram_ctrl_0_bram_douta),
        .enable_sp_bram(fsm_copy_0_enable_sp_bram),
        .w_enable_sp_bram(fsm_copy_0_w_enable_sp_bram));
endmodule

(* CHECK_LICENSE_TYPE = "design_1_axi_bram_ctrl_0_bram_0,blk_mem_gen_v8_4_6,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* X_CORE_INFO = "blk_mem_gen_v8_4_6,Vivado 2023.1" *) 
module design_1_axi_bram_ctrl_0_bram_0
   (clka,
    rsta,
    ena,
    wea,
    addra,
    dina,
    douta,
    clkb,
    rstb,
    enb,
    web,
    addrb,
    dinb,
    doutb,
    rsta_busy,
    rstb_busy);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE BRAM_CTRL, READ_WRITE_MODE READ_WRITE, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA RST" *) input rsta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [3:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [31:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE BRAM_CTRL, READ_WRITE_MODE READ_WRITE, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB RST" *) input rstb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB WE" *) input [3:0]web;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [31:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DIN" *) input [31:0]dinb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [31:0]doutb;
  output rsta_busy;
  output rstb_busy;

  wire [31:0]addra;
  wire [31:0]addrb;
  wire clka;
  wire clkb;
  wire [31:0]dina;
  wire [31:0]dinb;
  wire [31:0]douta;
  wire [31:0]doutb;
  wire ena;
  wire enb;
  wire rsta;
  wire rsta_busy;
  wire rstb;
  wire rstb_busy;
  wire [3:0]wea;
  wire [3:0]web;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [31:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "32" *) 
  (* C_ADDRB_WIDTH = "32" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "8" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "2" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "1" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "1" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     10.7492 mW" *) 
  (* C_FAMILY = "zynq" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "1" *) 
  (* C_HAS_RSTB = "1" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "NONE" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "2" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "2048" *) 
  (* C_READ_DEPTH_B = "2048" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "1" *) 
  (* C_USE_BYTE_WEA = "1" *) 
  (* C_USE_BYTE_WEB = "1" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "4" *) 
  (* C_WEB_WIDTH = "4" *) 
  (* C_WRITE_DEPTH_A = "2048" *) 
  (* C_WRITE_DEPTH_B = "2048" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* DowngradeIPIdentifiedWarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  design_1_axi_bram_ctrl_0_bram_0_blk_mem_gen_v8_4_6 U0
       (.addra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,addra[12:2],1'b0,1'b0}),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,addrb[12:2],1'b0,1'b0}),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb(dinb),
        .douta(douta),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(enb),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[31:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(rsta),
        .rsta_busy(rsta_busy),
        .rstb(rstb),
        .rstb_busy(rstb_busy),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[31:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(web));
endmodule

(* CHECK_LICENSE_TYPE = "design_1_fsm_copy_0_0,fsm_copy,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "fsm_copy,Vivado 2023.1" *) 
module design_1_fsm_copy_0_0
   (clk,
    addr_sp_bram,
    enable_sp_bram,
    data_out_sp_bram,
    w_enable_sp_bram,
    data_in_sp_bram,
    DEBUG_state);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *) input clk;
  output [31:0]addr_sp_bram;
  output enable_sp_bram;
  input [31:0]data_out_sp_bram;
  output [3:0]w_enable_sp_bram;
  output [31:0]data_in_sp_bram;
  output [5:0]DEBUG_state;

  wire \<const0> ;
  wire \<const1> ;
  wire [0:0]\^DEBUG_state ;
  wire clk;
  wire [31:0]data_out_sp_bram;

  assign DEBUG_state[5] = \<const0> ;
  assign DEBUG_state[4] = \<const0> ;
  assign DEBUG_state[3] = \<const0> ;
  assign DEBUG_state[2] = \<const0> ;
  assign DEBUG_state[1] = \<const0> ;
  assign DEBUG_state[0] = \^DEBUG_state [0];
  assign addr_sp_bram[31] = \<const0> ;
  assign addr_sp_bram[30] = \<const0> ;
  assign addr_sp_bram[29] = \<const0> ;
  assign addr_sp_bram[28] = \<const0> ;
  assign addr_sp_bram[27] = \<const0> ;
  assign addr_sp_bram[26] = \<const0> ;
  assign addr_sp_bram[25] = \<const0> ;
  assign addr_sp_bram[24] = \<const0> ;
  assign addr_sp_bram[23] = \<const0> ;
  assign addr_sp_bram[22] = \<const0> ;
  assign addr_sp_bram[21] = \<const0> ;
  assign addr_sp_bram[20] = \<const0> ;
  assign addr_sp_bram[19] = \<const0> ;
  assign addr_sp_bram[18] = \<const0> ;
  assign addr_sp_bram[17] = \<const0> ;
  assign addr_sp_bram[16] = \<const0> ;
  assign addr_sp_bram[15] = \<const0> ;
  assign addr_sp_bram[14] = \<const0> ;
  assign addr_sp_bram[13] = \<const0> ;
  assign addr_sp_bram[12] = \<const0> ;
  assign addr_sp_bram[11] = \<const0> ;
  assign addr_sp_bram[10] = \<const0> ;
  assign addr_sp_bram[9] = \<const0> ;
  assign addr_sp_bram[8] = \<const0> ;
  assign addr_sp_bram[7] = \<const0> ;
  assign addr_sp_bram[6] = \<const0> ;
  assign addr_sp_bram[5] = \<const0> ;
  assign addr_sp_bram[4] = \<const0> ;
  assign addr_sp_bram[3] = \<const0> ;
  assign addr_sp_bram[2] = \<const0> ;
  assign addr_sp_bram[1] = \<const0> ;
  assign addr_sp_bram[0] = \<const0> ;
  assign data_in_sp_bram[31] = \<const0> ;
  assign data_in_sp_bram[30] = \<const0> ;
  assign data_in_sp_bram[29] = \<const0> ;
  assign data_in_sp_bram[28] = \<const0> ;
  assign data_in_sp_bram[27] = \<const0> ;
  assign data_in_sp_bram[26] = \<const0> ;
  assign data_in_sp_bram[25] = \<const0> ;
  assign data_in_sp_bram[24] = \<const0> ;
  assign data_in_sp_bram[23] = \<const0> ;
  assign data_in_sp_bram[22] = \<const0> ;
  assign data_in_sp_bram[21] = \<const0> ;
  assign data_in_sp_bram[20] = \<const0> ;
  assign data_in_sp_bram[19] = \<const0> ;
  assign data_in_sp_bram[18] = \<const0> ;
  assign data_in_sp_bram[17] = \<const0> ;
  assign data_in_sp_bram[16] = \<const0> ;
  assign data_in_sp_bram[15] = \<const0> ;
  assign data_in_sp_bram[14] = \<const0> ;
  assign data_in_sp_bram[13] = \<const0> ;
  assign data_in_sp_bram[12] = \<const0> ;
  assign data_in_sp_bram[11] = \<const0> ;
  assign data_in_sp_bram[10] = \<const0> ;
  assign data_in_sp_bram[9] = \<const0> ;
  assign data_in_sp_bram[8] = \<const0> ;
  assign data_in_sp_bram[7] = \<const0> ;
  assign data_in_sp_bram[6] = \<const0> ;
  assign data_in_sp_bram[5] = \<const0> ;
  assign data_in_sp_bram[4] = \<const0> ;
  assign data_in_sp_bram[3] = \<const0> ;
  assign data_in_sp_bram[2] = \<const0> ;
  assign data_in_sp_bram[1] = \<const0> ;
  assign data_in_sp_bram[0] = \<const0> ;
  assign enable_sp_bram = \<const1> ;
  assign w_enable_sp_bram[3] = \<const0> ;
  assign w_enable_sp_bram[2] = \<const0> ;
  assign w_enable_sp_bram[1] = \<const0> ;
  assign w_enable_sp_bram[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  design_1_fsm_copy_0_0_fsm_copy inst
       (.DEBUG_state(\^DEBUG_state ),
        .clk(clk),
        .data_out_sp_bram(data_out_sp_bram[0]));
endmodule

(* ORIG_REF_NAME = "fsm_copy" *) 
module design_1_fsm_copy_0_0_fsm_copy
   (DEBUG_state,
    data_out_sp_bram,
    clk);
  output [0:0]DEBUG_state;
  input [0:0]data_out_sp_bram;
  input clk;

  wire [0:0]DEBUG_state;
  wire clk;
  wire [0:0]data_out_sp_bram;
  wire start_i_1_n_0;
  wire start_reg_n_0;

  LUT3 #(
    .INIT(8'hEA)) 
    start_i_1
       (.I0(data_out_sp_bram),
        .I1(start_reg_n_0),
        .I2(DEBUG_state),
        .O(start_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    start_reg
       (.C(clk),
        .CE(1'b1),
        .D(start_i_1_n_0),
        .Q(start_reg_n_0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \state_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(start_reg_n_0),
        .Q(DEBUG_state),
        .R(1'b0));
endmodule

(* NotValidForBitStream *)
module design_1_wrapper
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

  wire [5:0]DEBUG_state;
  wire [5:0]DEBUG_state_OBUF;
  wire [31:0]addr;
  wire [31:0]addr_IBUF;
  wire clk;
  wire clk_IBUF;
  wire [31:0]data_in;
  wire [31:0]data_in_IBUF;
  wire [3:0]web;
  wire [3:0]web_IBUF;

initial begin
 $sdf_annotate("tb_bram_combine_time_synth.sdf",,,,"tool_control");
end
  OBUF \DEBUG_state_OBUF[0]_inst 
       (.I(DEBUG_state_OBUF[0]),
        .O(DEBUG_state[0]));
  OBUF \DEBUG_state_OBUF[1]_inst 
       (.I(DEBUG_state_OBUF[1]),
        .O(DEBUG_state[1]));
  OBUF \DEBUG_state_OBUF[2]_inst 
       (.I(DEBUG_state_OBUF[2]),
        .O(DEBUG_state[2]));
  OBUF \DEBUG_state_OBUF[3]_inst 
       (.I(DEBUG_state_OBUF[3]),
        .O(DEBUG_state[3]));
  OBUF \DEBUG_state_OBUF[4]_inst 
       (.I(DEBUG_state_OBUF[4]),
        .O(DEBUG_state[4]));
  OBUF \DEBUG_state_OBUF[5]_inst 
       (.I(DEBUG_state_OBUF[5]),
        .O(DEBUG_state[5]));
  IBUF \addr_IBUF[0]_inst 
       (.I(addr[0]),
        .O(addr_IBUF[0]));
  IBUF \addr_IBUF[10]_inst 
       (.I(addr[10]),
        .O(addr_IBUF[10]));
  IBUF \addr_IBUF[11]_inst 
       (.I(addr[11]),
        .O(addr_IBUF[11]));
  IBUF \addr_IBUF[12]_inst 
       (.I(addr[12]),
        .O(addr_IBUF[12]));
  IBUF \addr_IBUF[13]_inst 
       (.I(addr[13]),
        .O(addr_IBUF[13]));
  IBUF \addr_IBUF[14]_inst 
       (.I(addr[14]),
        .O(addr_IBUF[14]));
  IBUF \addr_IBUF[15]_inst 
       (.I(addr[15]),
        .O(addr_IBUF[15]));
  IBUF \addr_IBUF[16]_inst 
       (.I(addr[16]),
        .O(addr_IBUF[16]));
  IBUF \addr_IBUF[17]_inst 
       (.I(addr[17]),
        .O(addr_IBUF[17]));
  IBUF \addr_IBUF[18]_inst 
       (.I(addr[18]),
        .O(addr_IBUF[18]));
  IBUF \addr_IBUF[19]_inst 
       (.I(addr[19]),
        .O(addr_IBUF[19]));
  IBUF \addr_IBUF[1]_inst 
       (.I(addr[1]),
        .O(addr_IBUF[1]));
  IBUF \addr_IBUF[20]_inst 
       (.I(addr[20]),
        .O(addr_IBUF[20]));
  IBUF \addr_IBUF[21]_inst 
       (.I(addr[21]),
        .O(addr_IBUF[21]));
  IBUF \addr_IBUF[22]_inst 
       (.I(addr[22]),
        .O(addr_IBUF[22]));
  IBUF \addr_IBUF[23]_inst 
       (.I(addr[23]),
        .O(addr_IBUF[23]));
  IBUF \addr_IBUF[24]_inst 
       (.I(addr[24]),
        .O(addr_IBUF[24]));
  IBUF \addr_IBUF[25]_inst 
       (.I(addr[25]),
        .O(addr_IBUF[25]));
  IBUF \addr_IBUF[26]_inst 
       (.I(addr[26]),
        .O(addr_IBUF[26]));
  IBUF \addr_IBUF[27]_inst 
       (.I(addr[27]),
        .O(addr_IBUF[27]));
  IBUF \addr_IBUF[28]_inst 
       (.I(addr[28]),
        .O(addr_IBUF[28]));
  IBUF \addr_IBUF[29]_inst 
       (.I(addr[29]),
        .O(addr_IBUF[29]));
  IBUF \addr_IBUF[2]_inst 
       (.I(addr[2]),
        .O(addr_IBUF[2]));
  IBUF \addr_IBUF[30]_inst 
       (.I(addr[30]),
        .O(addr_IBUF[30]));
  IBUF \addr_IBUF[31]_inst 
       (.I(addr[31]),
        .O(addr_IBUF[31]));
  IBUF \addr_IBUF[3]_inst 
       (.I(addr[3]),
        .O(addr_IBUF[3]));
  IBUF \addr_IBUF[4]_inst 
       (.I(addr[4]),
        .O(addr_IBUF[4]));
  IBUF \addr_IBUF[5]_inst 
       (.I(addr[5]),
        .O(addr_IBUF[5]));
  IBUF \addr_IBUF[6]_inst 
       (.I(addr[6]),
        .O(addr_IBUF[6]));
  IBUF \addr_IBUF[7]_inst 
       (.I(addr[7]),
        .O(addr_IBUF[7]));
  IBUF \addr_IBUF[8]_inst 
       (.I(addr[8]),
        .O(addr_IBUF[8]));
  IBUF \addr_IBUF[9]_inst 
       (.I(addr[9]),
        .O(addr_IBUF[9]));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  IBUF \data_in_IBUF[0]_inst 
       (.I(data_in[0]),
        .O(data_in_IBUF[0]));
  IBUF \data_in_IBUF[10]_inst 
       (.I(data_in[10]),
        .O(data_in_IBUF[10]));
  IBUF \data_in_IBUF[11]_inst 
       (.I(data_in[11]),
        .O(data_in_IBUF[11]));
  IBUF \data_in_IBUF[12]_inst 
       (.I(data_in[12]),
        .O(data_in_IBUF[12]));
  IBUF \data_in_IBUF[13]_inst 
       (.I(data_in[13]),
        .O(data_in_IBUF[13]));
  IBUF \data_in_IBUF[14]_inst 
       (.I(data_in[14]),
        .O(data_in_IBUF[14]));
  IBUF \data_in_IBUF[15]_inst 
       (.I(data_in[15]),
        .O(data_in_IBUF[15]));
  IBUF \data_in_IBUF[16]_inst 
       (.I(data_in[16]),
        .O(data_in_IBUF[16]));
  IBUF \data_in_IBUF[17]_inst 
       (.I(data_in[17]),
        .O(data_in_IBUF[17]));
  IBUF \data_in_IBUF[18]_inst 
       (.I(data_in[18]),
        .O(data_in_IBUF[18]));
  IBUF \data_in_IBUF[19]_inst 
       (.I(data_in[19]),
        .O(data_in_IBUF[19]));
  IBUF \data_in_IBUF[1]_inst 
       (.I(data_in[1]),
        .O(data_in_IBUF[1]));
  IBUF \data_in_IBUF[20]_inst 
       (.I(data_in[20]),
        .O(data_in_IBUF[20]));
  IBUF \data_in_IBUF[21]_inst 
       (.I(data_in[21]),
        .O(data_in_IBUF[21]));
  IBUF \data_in_IBUF[22]_inst 
       (.I(data_in[22]),
        .O(data_in_IBUF[22]));
  IBUF \data_in_IBUF[23]_inst 
       (.I(data_in[23]),
        .O(data_in_IBUF[23]));
  IBUF \data_in_IBUF[24]_inst 
       (.I(data_in[24]),
        .O(data_in_IBUF[24]));
  IBUF \data_in_IBUF[25]_inst 
       (.I(data_in[25]),
        .O(data_in_IBUF[25]));
  IBUF \data_in_IBUF[26]_inst 
       (.I(data_in[26]),
        .O(data_in_IBUF[26]));
  IBUF \data_in_IBUF[27]_inst 
       (.I(data_in[27]),
        .O(data_in_IBUF[27]));
  IBUF \data_in_IBUF[28]_inst 
       (.I(data_in[28]),
        .O(data_in_IBUF[28]));
  IBUF \data_in_IBUF[29]_inst 
       (.I(data_in[29]),
        .O(data_in_IBUF[29]));
  IBUF \data_in_IBUF[2]_inst 
       (.I(data_in[2]),
        .O(data_in_IBUF[2]));
  IBUF \data_in_IBUF[30]_inst 
       (.I(data_in[30]),
        .O(data_in_IBUF[30]));
  IBUF \data_in_IBUF[31]_inst 
       (.I(data_in[31]),
        .O(data_in_IBUF[31]));
  IBUF \data_in_IBUF[3]_inst 
       (.I(data_in[3]),
        .O(data_in_IBUF[3]));
  IBUF \data_in_IBUF[4]_inst 
       (.I(data_in[4]),
        .O(data_in_IBUF[4]));
  IBUF \data_in_IBUF[5]_inst 
       (.I(data_in[5]),
        .O(data_in_IBUF[5]));
  IBUF \data_in_IBUF[6]_inst 
       (.I(data_in[6]),
        .O(data_in_IBUF[6]));
  IBUF \data_in_IBUF[7]_inst 
       (.I(data_in[7]),
        .O(data_in_IBUF[7]));
  IBUF \data_in_IBUF[8]_inst 
       (.I(data_in[8]),
        .O(data_in_IBUF[8]));
  IBUF \data_in_IBUF[9]_inst 
       (.I(data_in[9]),
        .O(data_in_IBUF[9]));
  (* HW_HANDOFF = "design_1.hwdef" *) 
  design_1 design_1_i
       (.DEBUG_state(DEBUG_state_OBUF),
        .addr(addr_IBUF),
        .clk(clk_IBUF),
        .data_in(data_in_IBUF),
        .web(web_IBUF));
  IBUF \web_IBUF[0]_inst 
       (.I(web[0]),
        .O(web_IBUF[0]));
  IBUF \web_IBUF[1]_inst 
       (.I(web[1]),
        .O(web_IBUF[1]));
  IBUF \web_IBUF[2]_inst 
       (.I(web[2]),
        .O(web_IBUF[2]));
  IBUF \web_IBUF[3]_inst 
       (.I(web[3]),
        .O(web_IBUF[3]));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2023.1"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
aMT3usC6uizzcwnzOCX4OsS16Ob+YxFcsGovFpFklbnaIaD1S0lVdxenTwHPp6ByIEi+ehwr6Rgg
z/3AlTheI5NFTM8ihiMA18/wmUxI7EbaftJACA1LykUKCuj5myy0T+DACuv3sGYIZS38TZTZnnBC
FGAlvTZmRWs+JzneH3o=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lR9ZerhYSAb39nzEkeYvhnwEs5t9y/+yTDf8KuoUtR1BGeHZq8pA/YxtjzQLtaOW1R1IQUb0FtSI
e3CYAb7WHYbIjcpw3vKHvW1SqcGn9CMGa556CYKmD2oF12Kow8xRaFvMSBUVxX7HsHxNWnRd+PU1
+C0YayU2KFIY/7Yl6cZ5luAzhw/6SW3PFYUIyyqWy5MCIXweHOwQR2IpQEdlDur5nluN7i7BeB+i
fxwwHh8TU/g7T4mhZFkiTuBKdLAtQOjxWxzqTMxgcuAjlTylY16FgMFOASdvvSbqBZJjbxMdVloU
rYjS8O/8rWktv8GXcaIdBJ2BRj01q7jsChsbwA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
Qvl63GHz9mq2xOB7elt/vAQ7URLGdD1Lkcz7f3Wtw31dwjjjbP62Ny/Jr6OmBIheWlgejx38qxAT
TrHiiEyjKmGcnPn1Tn2n+cH4RAxCbOFnCI9n6+YsYMTe9JkplGhGGr39SkFgJz0I2IKpPsuqTjCj
rhf49TAryNMQeRpREJA=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
MA+9Ro+dh339m0iZrkKbqTKN8gQ5xkxN/SPCfhkOn+5jjgCTS5IOKLHil+HsZDjX333ebxnornwG
MOBxyEdFfLM8SA+bs2r41J/j0af2VVMmCM3hOh8JmZxB4X9Jg/glegNCbvwzqxMbOQNEy+zt7j5t
TFVD82RtPFmYVVYZZyll/WvAA+0aVpyjzLCIM1GznFky0RWLv65Wp4MJJnNRRrtG3muMznVO/u2s
tACsJ9jzv9M0IlMYjYH9BixhG6cZX02I4LEXXaPkhdOINlMMhsbArXtc9NphzmS4bY1/1yF1D6YD
EKLyS2Sr3HDl0O/lefN+jvfG8iKuVl55PNNrVQ==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
wpMTg7STjFkUDhOqdNPa0FHXTnHQgKmhvqDv+rRVBvMiQ8O7u8oj7ibITq3o+jugJsMJ60B410gQ
JFTcqCJKYmYJvqi8rPLLOYDmFG6ZLP/Ixr3n62IyIaCeDltBahi3yV009QN0X+iuzuFCL+Y7g9ff
IvAgyBly+Z3Itv2H9EJMZPMl17Sa7IkgjmWqzVXIKNMKn0iDVYsQw6ZgzQDYQ8N8IvTIEggU3/lh
6Nf0hV0ev3qOv/2P+4w0U766Ux3yLuzPJSI7bKm3/ip9NjhOytxOiKKqVXhKG8dzbbuS5u3EE/eq
q6YxkL7gpvNltVqqBnJB6vHSyWrD6+MqsCtR9A==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2022_10", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Q7Q4SSp70lxFryaopuic9VVP/Ire0pSsPEIMYdURBAczC7ShkuYeV02U7L3BlAiyBE4vBKcwYSQd
cWiaj8sVP7q4kxoRHKxLV1R5PIO6l4DsLWE2E+1MLyUPME0w5KTular/oX8EPCJ5n/8VCtW7x4Vf
dpeyki1/IAPJkAyi3zVZKHzgKhEwnZaZZtZYuMWoPZMt4V38sAcE42Raf+7yfFWG5HO74JY6iEnW
gJeRk58K+avB/XLF2/j2RQZfjTYizrprT2tUMBK6e7DRWZZtk8AOcsMhUikev44IFGNbNXjP8BXC
0J3y3P7pCFT6l+saU83nRwi/H25fSA34diJtNw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
a/8ooC+s+6nfvfa1+oBhsvYWLJjFgp83DI1kNyOi5Am+ugPbGRmgGZudfyo6yw6Yd5gGbLm5aToQ
5G4cGF5HaXD5TU6A0ZZFMTIbzFLE76JMjjIxX8JcaJIZpSmrXqlru8l5gDINUEAmwUY3mRQnjcGJ
0Z+kMRH8iAEF+gEviPiFZSBbJeOPqivIS217kimQJX3BeNbNPQTP+GUidcRywpGMh5avxtA0kDRO
F9SoCSyTm9hr2v9hsK1IUAYQLb7n2/R+z5YNKNzt1oN4qgJH1wZfdI8if2K8+ohyOdnxrrgJOWdj
cOqr7cGqEOYfBMTIQeHVZzb7NGWVN+9B8XSUaQ==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
FLPvOUNRWNW2GU+FEGmt2XWthOT5bY/31DRbol2cUmEGNF6b2XzpCosNKGx/o2n6sQvGP39KRFCs
nJu0ihe2dUGee9nEZZUcpwPjnEfXVI3yJaRVYy8iL+rm59lXq0jX4sjAPieDvv8shgAnoXLTZGlq
K+2c1JhaHt+nFi27TDrYar/+P8nP1MhocOS7BjzCvSs0foEXj92/qD+71Sm/LqGr8cjlH2qTJJ8B
ynxoH6iT+bksVA2VbtPT9o6h1kJ/zwP4wcsL9l+qSlJhd4GI11JPux26DlNyIi41WmufQcfiT0PB
r6O9+0E9lV9ODwKdjaxfZRK29rjKeq2yr0jWhMV38XKKqHAJli7MIypGRXcCo+u89H87KgYt+ebw
s3foIqCe0JKR57WzI8VD6XdNtOL8eBxK539oemx4vkE0cGYECZKYru6A2hPeZOYDD5eyWSUlQl1R
EciK49WM8HnssyRVcmE6di6bISMbVi0TZG/v98bz+9UZa8DtqMVYH0tz

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
fphquQOeFuqByo36Gh2C1zEC1J6u9swSMbMzsKldIvLm+SZ6/hr/N8KJ/G2vBABzX6UtbVuP1ZXx
AxdftP4Aqis1B3Bs6989aQG9eo0SOHA7r6aFLtFb3qoD5Pvqw4aVNU4z4EtTpFpn/jCWD21lKROf
q5X32HRfFq1jwqod+9vIbUNRRzz5y9VHvXfacZlxDazSPmcCF4hxB1KqWqT44KmYVkDedgkgnYgb
ZGidHnTb3W7C8tSqC9ac4kNJCL429QndtddweESJNlpX+65pt9Irok9pkOodwoj0QScswOIFjhBZ
/GrzZLQcFWiD3gXRU4DazzxQnGdRH4qEIRWziw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
1lUYYHPCt1BUJOvcBbgMU2GSQiqfxItz4ntieMaenjrtsE9SLwaU6xB0tBl8Atw5yP/RRNww1kX/
9uZbTz5He3r9mPVt+mGxB4N3f9BbCrQRb4USVPgKO/+vWUfMQERGklScy0+fz75WuxH74CjRUoDI
8iyssb2cUNnfDe13jIoI8gM1w4w/Pkxkmb6Mef53QMxacHAWEZeytcH3fuL/adO263D8P90U3XJv
vBXJmbjkRVi9qzjBzfMxuOy2KbZaZgR3BLzaffIfFnMwg/Rb8sGls5pQsZv5jL2wk3+Bj3OXBYdd
pDyjGoalJBzObKzd/t15kNHwY4FXYFcZLQPncw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
YRmSEzaa2WFVvMH1BwWc1TIUpVbzSEIP0VbI6n0sEgct/X4PiTfMQmK1jBVCaISIzwBxscKQwZOt
mb/nmINGg6I7ih39LSbBMtx6cdCUiyaLkPeRbqfyPpKhvnUIFmdKVvTd1dYzxeOeuDnhSVaBaAcN
3lngSg7lIbmhLIGjC29yQrBTiLArbVZi6IRGronMK51e3UrYa6GspsznhiuRcXjEb4bHKrJ2CM5Z
BUwA+E9949sQgyOagFZbLVle2ESbwBaoxcAPn2gxfRHlT0leqyLgUGDZLsfArzGzw9BTGzyEG2TR
XOrKFNYRfMXMrnGsBM7acIelY4LdAMgsKgDH/A==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 60048)
`pragma protect data_block
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
1b1MJz4iqO0W9oAq6YJkNvYm4qXasDMfBMKG
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
