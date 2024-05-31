transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vmap -link {C:/Users/SROH/Desktop/SP_BRAM/project_1/project_1.cache/compile_simlib/riviera}
vlib riviera/xpm
vlib riviera/xil_defaultlib
vlib riviera/blk_mem_gen_v8_4_6
vlib riviera/xlconstant_v1_1_7

vlog -work xpm  -incr -l xpm -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l xlconstant_v1_1_7 \
"C:/Xilinx/Vivado/2023.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  -incr \
"C:/Xilinx/Vivado/2023.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -incr -v2k5 -l xpm -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l xlconstant_v1_1_7 \
"../../../bd/design_1/ip/design_1_fsm_copy_0_0/sim/design_1_fsm_copy_0_0.v" \

vlog -work blk_mem_gen_v8_4_6  -incr -v2k5 -l xpm -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l xlconstant_v1_1_7 \
"../../../../project_1.gen/sources_1/bd/design_1/ipshared/bb55/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -incr -v2k5 -l xpm -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l xlconstant_v1_1_7 \
"../../../bd/design_1/ip/design_1_axi_bram_ctrl_0_bram_0/sim/design_1_axi_bram_ctrl_0_bram_0.v" \

vlog -work xlconstant_v1_1_7  -incr -v2k5 -l xpm -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l xlconstant_v1_1_7 \
"../../../../project_1.gen/sources_1/bd/design_1/ipshared/b0f2/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -v2k5 -l xpm -l xil_defaultlib -l blk_mem_gen_v8_4_6 -l xlconstant_v1_1_7 \
"../../../bd/design_1/ip/design_1_xlconstant_0_0/sim/design_1_xlconstant_0_0.v" \
"../../../bd/design_1/sim/design_1.v" \

vlog -work xil_defaultlib \
"glbl.v"

