// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
// Date        : Thu Nov  9 19:09:14 2023
// Host        : DESKTOP-OJLJP2J running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/SROH/Desktop/SP_BRAM/project_1/project_1.gen/sources_1/bd/design_1/ip/design_1_fsm_copy_0_0/design_1_fsm_copy_0_0_stub.v
// Design      : design_1_fsm_copy_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "fsm_copy,Vivado 2023.1" *)
module design_1_fsm_copy_0_0(clk, addr_sp_bram, enable_sp_bram, 
  data_out_sp_bram, w_enable_sp_bram, data_in_sp_bram, DEBUG_state)
/* synthesis syn_black_box black_box_pad_pin="addr_sp_bram[31:0],enable_sp_bram,data_out_sp_bram[31:0],w_enable_sp_bram[3:0],data_in_sp_bram[31:0],DEBUG_state[5:0]" */
/* synthesis syn_force_seq_prim="clk" */;
  input clk /* synthesis syn_isclock = 1 */;
  output [31:0]addr_sp_bram;
  output enable_sp_bram;
  input [31:0]data_out_sp_bram;
  output [3:0]w_enable_sp_bram;
  output [31:0]data_in_sp_bram;
  output [5:0]DEBUG_state;
endmodule
