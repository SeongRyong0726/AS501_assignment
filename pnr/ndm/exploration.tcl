set_app_options -name file.lef.allow_site_conflicts -value true
set_app_options -name file.lef.auto_rename_conflict_sites -value true
set_app_options -name lib.workspace.allow_commit_workspace_overwrite -value true
set_app_options -name lib.workspace.group_libs_create_slg -value false
set_app_options -name lib.workspace.allow_missing_related_pg_pins -value true
set_app_options -name lib.logic_model.auto_remove_incompatible_timing_designs -value true
set_app_options -name lib.workspace.remove_frame_bus_properties -value true
set_app_options -name lib.logic_model.require_same_opt_attrs -value false
set_app_options -name lib.logic_model.use_db_rail_names -value true
set_app_options -name lib.logic_model.auto_remove_timing_only_designs -value true
set_app_options -name lib.workspace.save_design_views -value false
set_app_options -name lib.workspace.save_layout_views -value false
set_app_options -name file.lef.non_real_cut_obs_mode -value true
set_app_options -as_user_default -name lib.physical_model.block_all -value false
set_app_options -as_user_default -name lib.physical_model.convert_metal_blockage_to_zero_spacing -value {{PO 0.122} {M1 0.05} {M2 0.056} {M3 0.056} {M4 0.056} {M5 0.056} {M6 0.056} {M7 0.056} {M8 0.056} {M9 0.16} {MRDL 2}}
set_app_options -as_user_default -name lib.physical_model.trim_metal_blockage_around_pin -value {{PO none} {M1 none} {M2 none} {M3 none} {M4 none} {M5 none} {M6 none} {M7 none} {M8 none} {M9 none} {MRDL none}}
set_app_options -name lib.workspace.group_libs_macro_grouping_strategy -value single_cell_per_lib
set_app_options -name lib.workspace.group_libs_naming_strategies -value common_prefix
set_app_options -name lib.workspace.group_libs_fix_cell_shadowing -value false
# workspace saed32hvt:
create_workspace -scale_factor 1000 -technology /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/TECH/saed32nm_1p9m_mw.tf saed32hvt
read_db /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/DBS/saed32hvt_ff1p16v125c.db
read_db /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/DBS/saed32hvt_ff1p16vn40c.db
read_db /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/DBS/saed32hvt_ss0p95vn40c.db
read_db /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/DBS/saed32hvt_ss0p95v125c.db
read_lef /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/LEF/saed32nm_hvt_1p9m.lef
check_workspace
commit_workspace -output ./saed32hvt.ndm
remove_workspace


# workspace saed32rvt:
create_workspace -scale_factor 1000 -technology /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/TECH/saed32nm_1p9m_mw.tf saed32rvt
read_db /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/DBS/saed32rvt_ff1p16vn40c.db
read_db /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/DBS/saed32rvt_ff1p16v125c.db
read_db /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/DBS/saed32rvt_ss0p95v125c.db
read_db /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/DBS/saed32rvt_ss0p95vn40c.db
read_lef /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/LEF/saed32nm_rvt_1p9m.lef
check_workspace
commit_workspace -output ./saed32rvt.ndm
remove_workspace


# workspace saed32sram:
create_workspace -scale_factor 1000 -technology /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/TECH/saed32nm_1p9m_mw.tf saed32sram
read_db /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/DBS/saed32sram_ff1p16v125c.db
read_db /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/DBS/saed32sram_ff1p16vn40c.db
read_db /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/DBS/saed32sram_ss0p95vn40c.db
read_db /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/DBS/saed32sram_ss0p95v125c.db
read_lef /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/LEF/saed32sram.lef
check_workspace
commit_workspace -output ./saed32sram.ndm
remove_workspace


# workspace saed32lvt:
create_workspace -scale_factor 1000 -technology /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/TECH/saed32nm_1p9m_mw.tf saed32lvt
read_db /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/DBS/saed32lvt_ff1p16vn40c.db
read_db /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/DBS/saed32lvt_ff1p16v125c.db
read_db /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/DBS/saed32lvt_ss0p95v125c.db
read_db /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/DBS/saed32lvt_ss0p95vn40c.db
read_lef /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/LEF/saed32nm_lvt_1p9m.lef
check_workspace
commit_workspace -output ./saed32lvt.ndm
remove_workspace


# workspace EXPLORE_physical_only:
create_workspace -flow physical_only -scale_factor 1000 -technology /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/TECH/saed32nm_1p9m_mw.tf EXPLORE_physical_only
set_app_options -name lib.workspace.include_design_filters -value { FOOT2X16_HVT FOOT2X16_LVT FOOT2X16_RVT FOOT2X2_HVT FOOT2X2_LVT FOOT2X2_RVT FOOT2X32_HVT FOOT2X32_LVT FOOT2X32_RVT FOOT2X4_HVT FOOT2X4_LVT FOOT2X4_RVT FOOT2X8_HVT FOOT2X8_LVT FOOT2X8_RVT FOOTX16_HVT FOOTX16_LVT FOOTX16_RVT FOOTX2_HVT FOOTX2_LVT FOOTX2_RVT FOOTX32_HVT FOOTX32_LVT FOOTX32_RVT FOOTX4_HVT FOOTX4_LVT FOOTX4_RVT FOOTX8_HVT FOOTX8_LVT FOOTX8_RVT HEAD2X16_HVT HEAD2X16_LVT HEAD2X16_RVT HEAD2X2_HVT HEAD2X2_LVT HEAD2X2_RVT HEAD2X32_HVT HEAD2X32_LVT HEAD2X32_RVT HEAD2X4_HVT HEAD2X4_LVT HEAD2X4_RVT HEAD2X8_HVT HEAD2X8_LVT HEAD2X8_RVT HEADX16_HVT HEADX16_LVT HEADX16_RVT HEADX2_HVT HEADX2_LVT HEADX2_RVT HEADX32_HVT HEADX32_LVT HEADX32_RVT HEADX4_HVT HEADX4_LVT HEADX4_RVT HEADX8_HVT HEADX8_LVT HEADX8_RVT LSDNENCLSSX1_HVT LSDNENCLSSX1_LVT LSDNENCLSSX1_RVT LSDNENCLSSX2_HVT LSDNENCLSSX2_LVT LSDNENCLSSX2_RVT LSDNENCLSSX4_HVT LSDNENCLSSX4_LVT LSDNENCLSSX4_RVT LSDNENCLSSX8_HVT LSDNENCLSSX8_LVT LSDNENCLSSX8_RVT LSDNENCLX1_HVT LSDNENCLX1_LVT LSDNENCLX1_RVT LSDNENCLX2_HVT LSDNENCLX2_LVT LSDNENCLX2_RVT LSDNENCLX4_HVT LSDNENCLX4_LVT LSDNENCLX4_RVT LSDNENCLX8_HVT LSDNENCLX8_LVT LSDNENCLX8_RVT LSDNENSSX1_HVT LSDNENSSX1_LVT LSDNENSSX1_RVT LSDNENSSX2_HVT LSDNENSSX2_LVT LSDNENSSX2_RVT LSDNENSSX4_HVT LSDNENSSX4_LVT LSDNENSSX4_RVT LSDNENSSX8_HVT LSDNENSSX8_LVT LSDNENSSX8_RVT LSDNENX1_HVT LSDNENX1_LVT LSDNENX1_RVT LSDNENX2_HVT LSDNENX2_LVT LSDNENX2_RVT LSDNENX4_HVT LSDNENX4_LVT LSDNENX4_RVT LSDNENX8_HVT LSDNENX8_LVT LSDNENX8_RVT LSDNSSX1_HVT LSDNSSX1_LVT LSDNSSX1_RVT LSDNSSX2_HVT LSDNSSX2_LVT LSDNSSX2_RVT LSDNSSX4_HVT LSDNSSX4_LVT LSDNSSX4_RVT LSDNSSX8_HVT LSDNSSX8_LVT LSDNSSX8_RVT LSDNX1_HVT LSDNX1_LVT LSDNX1_RVT LSDNX2_HVT LSDNX2_LVT LSDNX2_RVT LSDNX4_HVT LSDNX4_LVT LSDNX4_RVT LSDNX8_HVT LSDNX8_LVT LSDNX8_RVT LSUPENCLX1_HVT LSUPENCLX1_LVT LSUPENCLX1_RVT LSUPENCLX2_HVT LSUPENCLX2_LVT LSUPENCLX2_RVT LSUPENCLX4_HVT LSUPENCLX4_LVT LSUPENCLX4_RVT LSUPENCLX8_HVT LSUPENCLX8_LVT LSUPENCLX8_RVT LSUPENX1_HVT LSUPENX1_LVT LSUPENX1_RVT LSUPENX2_HVT LSUPENX2_LVT LSUPENX2_RVT LSUPENX4_HVT LSUPENX4_LVT LSUPENX4_RVT LSUPENX8_HVT LSUPENX8_LVT LSUPENX8_RVT LSUPX1_HVT LSUPX1_LVT LSUPX1_RVT LSUPX2_HVT LSUPX2_LVT LSUPX2_RVT LSUPX4_HVT LSUPX4_LVT LSUPX4_RVT LSUPX8_HVT LSUPX8_LVT LSUPX8_RVT}
read_lef /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/LEF/saed32nm_lvt_1p9m.lef
read_lef /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/LEF/saed32nm_rvt_1p9m.lef
read_lef /home/jihwancho/Synopsys_EDA_tool_lab/ASIC_Project/2_BACKEND/1_pnr/libdir/LEF/saed32nm_hvt_1p9m.lef
reset_app_options lib.workspace.include_design_filters
check_workspace
commit_workspace -output ./EXPLORE_physical_only.ndm
remove_workspace


