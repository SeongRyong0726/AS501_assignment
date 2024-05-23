// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
// Date        : Thu Nov  9 19:09:26 2023
// Host        : DESKTOP-OJLJP2J running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_axi_bram_ctrl_0_bram_0_sim_netlist.v
// Design      : design_1_axi_bram_ctrl_0_bram_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_axi_bram_ctrl_0_bram_0,blk_mem_gen_v8_4_6,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_6,Vivado 2023.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
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
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_6 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 59856)
`pragma protect data_block
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
z5ik6gQj
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
