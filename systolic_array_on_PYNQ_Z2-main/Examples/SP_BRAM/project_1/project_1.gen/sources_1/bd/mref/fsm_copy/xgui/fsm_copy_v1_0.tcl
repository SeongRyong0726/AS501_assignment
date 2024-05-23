# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "ACT_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ARRAY_M" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ARRAY_N" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DEPTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "NUM_VAR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "OUT_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "PE_OUT_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "RAM_SIZE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "WGT_WIDTH" -parent ${Page_0}


}

proc update_PARAM_VALUE.ACT_WIDTH { PARAM_VALUE.ACT_WIDTH } {
	# Procedure called to update ACT_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ACT_WIDTH { PARAM_VALUE.ACT_WIDTH } {
	# Procedure called to validate ACT_WIDTH
	return true
}

proc update_PARAM_VALUE.ADDR_WIDTH { PARAM_VALUE.ADDR_WIDTH } {
	# Procedure called to update ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ADDR_WIDTH { PARAM_VALUE.ADDR_WIDTH } {
	# Procedure called to validate ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.ARRAY_M { PARAM_VALUE.ARRAY_M } {
	# Procedure called to update ARRAY_M when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ARRAY_M { PARAM_VALUE.ARRAY_M } {
	# Procedure called to validate ARRAY_M
	return true
}

proc update_PARAM_VALUE.ARRAY_N { PARAM_VALUE.ARRAY_N } {
	# Procedure called to update ARRAY_N when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ARRAY_N { PARAM_VALUE.ARRAY_N } {
	# Procedure called to validate ARRAY_N
	return true
}

proc update_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to update DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to validate DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.DEPTH { PARAM_VALUE.DEPTH } {
	# Procedure called to update DEPTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DEPTH { PARAM_VALUE.DEPTH } {
	# Procedure called to validate DEPTH
	return true
}

proc update_PARAM_VALUE.NUM_VAR { PARAM_VALUE.NUM_VAR } {
	# Procedure called to update NUM_VAR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.NUM_VAR { PARAM_VALUE.NUM_VAR } {
	# Procedure called to validate NUM_VAR
	return true
}

proc update_PARAM_VALUE.OUT_WIDTH { PARAM_VALUE.OUT_WIDTH } {
	# Procedure called to update OUT_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OUT_WIDTH { PARAM_VALUE.OUT_WIDTH } {
	# Procedure called to validate OUT_WIDTH
	return true
}

proc update_PARAM_VALUE.PE_OUT_WIDTH { PARAM_VALUE.PE_OUT_WIDTH } {
	# Procedure called to update PE_OUT_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PE_OUT_WIDTH { PARAM_VALUE.PE_OUT_WIDTH } {
	# Procedure called to validate PE_OUT_WIDTH
	return true
}

proc update_PARAM_VALUE.RAM_SIZE { PARAM_VALUE.RAM_SIZE } {
	# Procedure called to update RAM_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.RAM_SIZE { PARAM_VALUE.RAM_SIZE } {
	# Procedure called to validate RAM_SIZE
	return true
}

proc update_PARAM_VALUE.WGT_WIDTH { PARAM_VALUE.WGT_WIDTH } {
	# Procedure called to update WGT_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WGT_WIDTH { PARAM_VALUE.WGT_WIDTH } {
	# Procedure called to validate WGT_WIDTH
	return true
}


proc update_MODELPARAM_VALUE.NUM_VAR { MODELPARAM_VALUE.NUM_VAR PARAM_VALUE.NUM_VAR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.NUM_VAR}] ${MODELPARAM_VALUE.NUM_VAR}
}

proc update_MODELPARAM_VALUE.ARRAY_N { MODELPARAM_VALUE.ARRAY_N PARAM_VALUE.ARRAY_N } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ARRAY_N}] ${MODELPARAM_VALUE.ARRAY_N}
}

proc update_MODELPARAM_VALUE.ARRAY_M { MODELPARAM_VALUE.ARRAY_M PARAM_VALUE.ARRAY_M } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ARRAY_M}] ${MODELPARAM_VALUE.ARRAY_M}
}

proc update_MODELPARAM_VALUE.ACT_WIDTH { MODELPARAM_VALUE.ACT_WIDTH PARAM_VALUE.ACT_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ACT_WIDTH}] ${MODELPARAM_VALUE.ACT_WIDTH}
}

proc update_MODELPARAM_VALUE.WGT_WIDTH { MODELPARAM_VALUE.WGT_WIDTH PARAM_VALUE.WGT_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WGT_WIDTH}] ${MODELPARAM_VALUE.WGT_WIDTH}
}

proc update_MODELPARAM_VALUE.PE_OUT_WIDTH { MODELPARAM_VALUE.PE_OUT_WIDTH PARAM_VALUE.PE_OUT_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PE_OUT_WIDTH}] ${MODELPARAM_VALUE.PE_OUT_WIDTH}
}

proc update_MODELPARAM_VALUE.RAM_SIZE { MODELPARAM_VALUE.RAM_SIZE PARAM_VALUE.RAM_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.RAM_SIZE}] ${MODELPARAM_VALUE.RAM_SIZE}
}

proc update_MODELPARAM_VALUE.ADDR_WIDTH { MODELPARAM_VALUE.ADDR_WIDTH PARAM_VALUE.ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ADDR_WIDTH}] ${MODELPARAM_VALUE.ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.DEPTH { MODELPARAM_VALUE.DEPTH PARAM_VALUE.DEPTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DEPTH}] ${MODELPARAM_VALUE.DEPTH}
}

proc update_MODELPARAM_VALUE.DATA_WIDTH { MODELPARAM_VALUE.DATA_WIDTH PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATA_WIDTH}] ${MODELPARAM_VALUE.DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.OUT_WIDTH { MODELPARAM_VALUE.OUT_WIDTH PARAM_VALUE.OUT_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OUT_WIDTH}] ${MODELPARAM_VALUE.OUT_WIDTH}
}

