// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
// Date        : Thu Nov  9 19:15:10 2023
// Host        : DESKTOP-OJLJP2J running 64-bit major release  (build 9200)
// Command     : write_verilog -mode funcsim -nolib -force -file
//               C:/Users/SROH/Desktop/SP_BRAM/project_1/project_1.sim/sim_1/synth/func/xsim/tb_bram_combine_func_synth.v
// Design      : design_1_wrapper
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

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
OxuZIePGPn1K/XMtUdWwz98A/8VUoyt0YuuK
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
