-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
-- Date        : Thu Nov  9 19:09:14 2023
-- Host        : DESKTOP-OJLJP2J running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Users/SROH/Desktop/SP_BRAM/project_1/project_1.gen/sources_1/bd/design_1/ip/design_1_fsm_copy_0_0/design_1_fsm_copy_0_0_sim_netlist.vhdl
-- Design      : design_1_fsm_copy_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_fsm_copy_0_0_fsm_copy is
  port (
    DEBUG_state : out STD_LOGIC_VECTOR ( 0 to 0 );
    data_out_sp_bram : in STD_LOGIC_VECTOR ( 0 to 0 );
    clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_fsm_copy_0_0_fsm_copy : entity is "fsm_copy";
end design_1_fsm_copy_0_0_fsm_copy;

architecture STRUCTURE of design_1_fsm_copy_0_0_fsm_copy is
  signal \^debug_state\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal start_i_1_n_0 : STD_LOGIC;
  signal start_reg_n_0 : STD_LOGIC;
begin
  DEBUG_state(0) <= \^debug_state\(0);
start_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EA"
    )
        port map (
      I0 => data_out_sp_bram(0),
      I1 => start_reg_n_0,
      I2 => \^debug_state\(0),
      O => start_i_1_n_0
    );
start_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => start_i_1_n_0,
      Q => start_reg_n_0,
      R => '0'
    );
\state_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => start_reg_n_0,
      Q => \^debug_state\(0),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_fsm_copy_0_0 is
  port (
    clk : in STD_LOGIC;
    addr_sp_bram : out STD_LOGIC_VECTOR ( 31 downto 0 );
    enable_sp_bram : out STD_LOGIC;
    data_out_sp_bram : in STD_LOGIC_VECTOR ( 31 downto 0 );
    w_enable_sp_bram : out STD_LOGIC_VECTOR ( 3 downto 0 );
    data_in_sp_bram : out STD_LOGIC_VECTOR ( 31 downto 0 );
    DEBUG_state : out STD_LOGIC_VECTOR ( 5 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_fsm_copy_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_fsm_copy_0_0 : entity is "design_1_fsm_copy_0_0,fsm_copy,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_1_fsm_copy_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_1_fsm_copy_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_1_fsm_copy_0_0 : entity is "fsm_copy,Vivado 2023.1";
end design_1_fsm_copy_0_0;

architecture STRUCTURE of design_1_fsm_copy_0_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \^debug_state\ : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0";
begin
  DEBUG_state(5) <= \<const0>\;
  DEBUG_state(4) <= \<const0>\;
  DEBUG_state(3) <= \<const0>\;
  DEBUG_state(2) <= \<const0>\;
  DEBUG_state(1) <= \<const0>\;
  DEBUG_state(0) <= \^debug_state\(0);
  addr_sp_bram(31) <= \<const0>\;
  addr_sp_bram(30) <= \<const0>\;
  addr_sp_bram(29) <= \<const0>\;
  addr_sp_bram(28) <= \<const0>\;
  addr_sp_bram(27) <= \<const0>\;
  addr_sp_bram(26) <= \<const0>\;
  addr_sp_bram(25) <= \<const0>\;
  addr_sp_bram(24) <= \<const0>\;
  addr_sp_bram(23) <= \<const0>\;
  addr_sp_bram(22) <= \<const0>\;
  addr_sp_bram(21) <= \<const0>\;
  addr_sp_bram(20) <= \<const0>\;
  addr_sp_bram(19) <= \<const0>\;
  addr_sp_bram(18) <= \<const0>\;
  addr_sp_bram(17) <= \<const0>\;
  addr_sp_bram(16) <= \<const0>\;
  addr_sp_bram(15) <= \<const0>\;
  addr_sp_bram(14) <= \<const0>\;
  addr_sp_bram(13) <= \<const0>\;
  addr_sp_bram(12) <= \<const0>\;
  addr_sp_bram(11) <= \<const0>\;
  addr_sp_bram(10) <= \<const0>\;
  addr_sp_bram(9) <= \<const0>\;
  addr_sp_bram(8) <= \<const0>\;
  addr_sp_bram(7) <= \<const0>\;
  addr_sp_bram(6) <= \<const0>\;
  addr_sp_bram(5) <= \<const0>\;
  addr_sp_bram(4) <= \<const0>\;
  addr_sp_bram(3) <= \<const0>\;
  addr_sp_bram(2) <= \<const0>\;
  addr_sp_bram(1) <= \<const0>\;
  addr_sp_bram(0) <= \<const0>\;
  data_in_sp_bram(31) <= \<const0>\;
  data_in_sp_bram(30) <= \<const0>\;
  data_in_sp_bram(29) <= \<const0>\;
  data_in_sp_bram(28) <= \<const0>\;
  data_in_sp_bram(27) <= \<const0>\;
  data_in_sp_bram(26) <= \<const0>\;
  data_in_sp_bram(25) <= \<const0>\;
  data_in_sp_bram(24) <= \<const0>\;
  data_in_sp_bram(23) <= \<const0>\;
  data_in_sp_bram(22) <= \<const0>\;
  data_in_sp_bram(21) <= \<const0>\;
  data_in_sp_bram(20) <= \<const0>\;
  data_in_sp_bram(19) <= \<const0>\;
  data_in_sp_bram(18) <= \<const0>\;
  data_in_sp_bram(17) <= \<const0>\;
  data_in_sp_bram(16) <= \<const0>\;
  data_in_sp_bram(15) <= \<const0>\;
  data_in_sp_bram(14) <= \<const0>\;
  data_in_sp_bram(13) <= \<const0>\;
  data_in_sp_bram(12) <= \<const0>\;
  data_in_sp_bram(11) <= \<const0>\;
  data_in_sp_bram(10) <= \<const0>\;
  data_in_sp_bram(9) <= \<const0>\;
  data_in_sp_bram(8) <= \<const0>\;
  data_in_sp_bram(7) <= \<const0>\;
  data_in_sp_bram(6) <= \<const0>\;
  data_in_sp_bram(5) <= \<const0>\;
  data_in_sp_bram(4) <= \<const0>\;
  data_in_sp_bram(3) <= \<const0>\;
  data_in_sp_bram(2) <= \<const0>\;
  data_in_sp_bram(1) <= \<const0>\;
  data_in_sp_bram(0) <= \<const0>\;
  enable_sp_bram <= \<const1>\;
  w_enable_sp_bram(3) <= \<const0>\;
  w_enable_sp_bram(2) <= \<const0>\;
  w_enable_sp_bram(1) <= \<const0>\;
  w_enable_sp_bram(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
     port map (
      P => \<const1>\
    );
inst: entity work.design_1_fsm_copy_0_0_fsm_copy
     port map (
      DEBUG_state(0) => \^debug_state\(0),
      clk => clk,
      data_out_sp_bram(0) => data_out_sp_bram(0)
    );
end STRUCTURE;
