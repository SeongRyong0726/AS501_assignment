+incdir+$SYNOPSYS/dw/sim_ver/

#==== Testbench & Tester ====#
./tb_rtl.v
./tester.v

#==== DUT RTL ====#
../../rtl/v3_1/include/inc_npu_all.v

#==== Simulation Models ====#
# External SRAM & Gate Model
./ext_rtl/ext_top.v
./ext_rtl/ext_sram.v

# SRAM
./sram_include.v

# Standard Cells and I/O Cells

# Design_Ware
-v $SYNOPSYS/dw/sim_ver/DWsc_sync.v
-v $SYNOPSYS/dw/sim_ver/DW_asymfifo_s2_sf.v
-v $SYNOPSYS/dw/sim_ver/DW_asymfifoctl_s2_sf.v
-v $SYNOPSYS/dw/sim_ver/DW01_ash.v
-v $SYNOPSYS/dw/sim_ver/DW02_mult.v
-v $SYNOPSYS/dw/sim_ver/DW_exp2.v
-v $SYNOPSYS/dw/sim_ver/DW01_add.v
-v $SYNOPSYS/dw/sim_ver/DW_arb_rr.v
-v $SYNOPSYS/dw/sim_ver/DW_fifo_s1_sf.v
-v $SYNOPSYS/dw/sim_ver/DW_fifoctl_s1_sf.v
-v $SYNOPSYS/dw/sim_ver/DW_fifoctl_s1_df.v
-v $SYNOPSYS/dw/sim_ver/DW_ram_r_w_s_dff.v
-v $SYNOPSYS/dw/sim_ver/DW_ram_rw_s_dff.v
-v $SYNOPSYS/dw/sim_ver/DW_fifo_s2_sf.v
-v $SYNOPSYS/dw/sim_ver/DW_fifoctl_s2_sf.v
-v $SYNOPSYS/dw/sim_ver/DW_asymfifo_s1_df.v
-v $SYNOPSYS/dw/sim_ver/DW_asymfifoctl_s1_df.v
-v $SYNOPSYS/dw/sim_ver/DW_ram_2r_w_s_dff.v
-v $SYNOPSYS/dw/sim_ver/DW_fp_add.v
-v $SYNOPSYS/dw/sim_ver/DW_fp_sub.v
-v $SYNOPSYS/dw/sim_ver/DW_fp_div.v
-v $SYNOPSYS/dw/sim_ver/DW_fp_exp.v
-v $SYNOPSYS/dw/sim_ver/DW_fp_exp2.v
-v $SYNOPSYS/dw/sim_ver/DW_fp_addsub.v
-v $SYNOPSYS/dw/sim_ver/DW_fp_i2flt.v
-v $SYNOPSYS/dw/sim_ver/DW_fp_flt2i.v
-v $SYNOPSYS/dw/sim_ver/DW_fp_mult.v
-v $SYNOPSYS/dw/sim_ver/DW01_cmp2.v
-v $SYNOPSYS/dw/sim_ver/DW01_addsub.v
-v $SYNOPSYS/dw/sim_ver/DW02_sum.v
-v $SYNOPSYS/dw/sim_ver/DW01_prienc.v
-v $SYNOPSYS/dw/sim_ver/DW_minmax.v
-v $SYNOPSYS/dw/sim_ver/DW_rash.v
-v $SYNOPSYS/dw/sim_ver/DW_lzd.v
-v $SYNOPSYS/dw/sim_ver/DW_div.v
-v $SYNOPSYS/dw/sim_ver/DW01_sub.v
-v $SYNOPSYS/dw/sim_ver/DW_log2.v
-v $SYNOPSYS/dw/sim_ver/DW_fp_log2.v



