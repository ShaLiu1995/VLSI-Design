set design jpeg_encoder

if {![file exists icc_report]} {
	exec mkdir icc_report
}
# read lib
set home "/home/linux/ieng6/ee260b/public/data/libraries"
set search_path ". $home"
set target_library "$home/db/tcbn65gpluswc.db"
set link_library "* $target_library"

if {[file exists "mwlib"]} {
	exec rm -r mwlib
}
create_mw_lib -tech "$home/techfiles/tsmcn65_8lmT2.tf" -bus_naming_style {[%d]} -mw_reference_library "$home/techfiles/tcbn65gplus" mwlib

open_mw_lib mwlib

# load design
import_designs "../../gate/$design\.v" -format verilog -top $design
read_sdc "../../gate/$design\.sdc"

# read techfiles
set_tlu_plus_files \
-max_tluplus "$home/techfiles/cln65g+_1p08m+alrdl_top2_cworst.tluplus" \
-min_tluplus "$home/techfiles/cln65g+_1p08m+alrdl_top2_cworst.tluplus" \
-tech2itf_map "$home/techfiles/star.map_8M"
check_tlu_plus_files

exec date > timer

# floorplan
create_floorplan \
-control_type "aspect_ratio" -core_aspect_ratio "1" \
-core_utilization "0.6" -row_core_ratio "1" \
-left_io2core "10" -bottom_io2core "10" -right_io2core "10" -top_io2core "10" \
-start_first_row

# placement 
create_fp_placement -effort high -timing_driven 
set_optimize_pre_cts_power_options -low_power_placement true
place_opt -effort high -congestion -power -area_recovery
# report design
report_power > ./icc_report/place_power.rpt
report_qor > ./icc_report/place_qor.rpt
report_design -physical > ./icc_report/place_phy.rpt
save_mw_cel -as $design\_placed

exec date >> timer

# CTS
set_route_mode_options -zroute true
set_si_options -route_xtalk_prevention true -delta_delay true
set_route_zrt_global_options -timing_driven true -crosstalk_driven true
set_route_zrt_track_options -timing_driven true -crosstalk_driven true
set_route_zrt_detail_options -timing_drive true
clock_opt -congestion -area_recovery -fix_hold_all_clocks -concurrent_clock_and_data -power

# report design
report_power > ./icc_report/CT_power.rpt
report_clock_tree > ./icc_report/CT.rpt
report_design -physical > ./icc_report/CT_phy.rpt
save_mw_cel -as $design\_CT

exec date >> timer

# route
route_opt -xtalk_reduction -power -area_recovery -effort high

# RC extraction
extract_rc -coupling_cap
write_parasitics -format SPEF -output  icc_$design\.spef
# DEF generation
write_def -version 5.7 -lef lef.ref -output icc_$design\.def

# report design
report_area >  ./icc_report/route_area.rpt
report_design -physical > ./icc_report/route_phy.rpt
report_qor  > ./icc_report/route_qor.rpt
report_power > ./icc_report/route_power.rpt
report_timing -nworst 1 -nosplit -nets > ./icc_report/route_timing.rpt

exec date >> timer

save_mw_cel -as $design\_routed
change_names -rules verilog -hierarchy
write_verilog icc_$design\_out.v
exit
