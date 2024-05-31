// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
// Date        : Thu Nov  9 19:09:14 2023
// Host        : DESKTOP-OJLJP2J running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/SROH/Desktop/SP_BRAM/project_1/project_1.gen/sources_1/bd/design_1/ip/design_1_fsm_copy_0_0/design_1_fsm_copy_0_0_sim_netlist.v
// Design      : design_1_fsm_copy_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_fsm_copy_0_0,fsm_copy,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "fsm_copy,Vivado 2023.1" *) 
(* NotValidForBitStream *)
module design_1_fsm_copy_0_0
   (clk,
    addr_sp_bram,
    enable_sp_bram,
    data_out_sp_bram,
    w_enable_sp_bram,
    data_in_sp_bram,
    DEBUG_state);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *) input clk;
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
  FDRE start_reg
       (.C(clk),
        .CE(1'b1),
        .D(start_i_1_n_0),
        .Q(start_reg_n_0),
        .R(1'b0));
  FDRE \state_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(start_reg_n_0),
        .Q(DEBUG_state),
        .R(1'b0));
endmodule
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
