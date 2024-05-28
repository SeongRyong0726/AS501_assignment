// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
// Date        : Thu Nov  9 19:09:26 2023
// Host        : DESKTOP-OJLJP2J running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/SROH/Desktop/SP_BRAM/project_1/project_1.gen/sources_1/bd/design_1/ip/design_1_axi_bram_ctrl_0_bram_0/design_1_axi_bram_ctrl_0_bram_0_sim_netlist.v
// Design      : design_1_axi_bram_ctrl_0_bram_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_axi_bram_ctrl_0_bram_0,blk_mem_gen_v8_4_6,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_6,Vivado 2023.1" *) 
(* NotValidForBitStream *)
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
  (* downgradeipidentifiedwarnings = "yes" *) 
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 60000)
`pragma protect data_block
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
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
