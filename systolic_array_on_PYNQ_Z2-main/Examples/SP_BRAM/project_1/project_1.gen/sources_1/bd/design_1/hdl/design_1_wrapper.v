//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
//Date        : Thu Nov  9 19:08:37 2023
//Host        : DESKTOP-OJLJP2J running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

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
  wire [31:0]addr;
  wire clk;
  wire [31:0]data_in;
  wire [3:0]web;

  design_1 design_1_i
       (.DEBUG_state(DEBUG_state),
        .addr(addr),
        .clk(clk),
        .data_in(data_in),
        .web(web));
endmodule
