#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Thu Feb  1 18:47:53 2018                
#                                                     
#######################################################

#@(#)CDS: Innovus v15.23-s045_1 (64bit) 04/22/2016 12:32 (Linux 2.6.18-194.el5)
#@(#)CDS: NanoRoute 15.23-s045_1 NR160414-1105/15_23-UB (database version 2.30, 317.6.1) {superthreading v1.26}
#@(#)CDS: AAE 15.23-s014 (64bit) 04/22/2016 (Linux 2.6.18-194.el5)
#@(#)CDS: CTE 15.23-s022_1 () Apr 22 2016 09:38:45 ( )
#@(#)CDS: SYNTECH 15.23-s008_1 () Apr 12 2016 21:52:59 ( )
#@(#)CDS: CPE v15.23-s045
#@(#)CDS: IQRC/TQRC 15.1.4-s213 (64bit) Tue Feb  9 17:31:28 PST 2016 (Linux 2.6.18-194.el5)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
getDrawView
loadWorkspace -name Physical
win
set init_pwr_net vdd
set init_gnd_net gnd
set init_verilog ../../desdir/netlist/aes_cipher_top.v
set init_design_netlisttype Verilog
set init_design_settop 1
set init_top_cell aes_cipher_top
set init_lef_file ../../libdir/lef/tcbn65gplus_8lmT2.lef
create_library_set -name WC_LIB -timing $worst_timing_lib
create_library_set -name BC_LIB -timing $best_timing_lib
create_rc_corner -name Cmax -cap_table $worst_captbl -T 125
create_rc_corner -name Cmin -cap_table $best_captbl -T -40
create_delay_corner -name WC -library_set WC_LIB -rc_corner Cmax
create_delay_corner -name BC -library_set BC_LIB -rc_corner Cmin
create_constraint_mode -name CON -sdc_file [list $sdc]
create_analysis_view -name WC_VIEW -delay_corner WC -constraint_mode CON
create_analysis_view -name BC_VIEW -delay_corner BC -constraint_mode CON
init_design -setup WC_VIEW -hold BC_VIEW
set_interactive_constraint_modes {CON}
setDesignMode -process 65
floorPlan -site core -r 1 0.50 10.0 10.0 10.0 10.0
createPlaceBlockage -box {10 90 40 170}
createPlaceBlockage -box {45 90 75 170}
createPlaceBlockage -box {185 90 215 170}
createPlaceBlockage -box {220 90 250 170}
zoomOut
zoomOut
zoomIn
zoomIn
zoomOut
zoomOut
zoomOut
zoomOut
zoomOut
zoomOut
zoomIn
zoomIn
zoomIn
zoomIn
zoomOut
setDrawView fplan
selectObject Module u0
gui_select -rect {-213.131 154.014 91.880 133.286}
selectObject Module u0
gui_select -rect {-242.743 151.053 66.216 145.131}
selectObject Module u0
uiSetTool move
setObjFPlanBox Module u0 75.2095 74.8615 187.8145 186.357
setObjFPlanBox Module u0 79.1485 77.761 191.7485 189.361
setObjFPlanBox Module u0 79.200 78.400 191.800 174.744
setObjFPlanBox Module u0 79.200 78.400 191.800 169.808
setObjFPlanBox Module u0 79.200 78.400 180.718 170.200
setObjFPlanBox Module u0 77.226 82.348 178.826 174.148
setObjFPlanBox Module u0 82.009 82.000 178.800 173.800
setObjFPlanBox Module u0 82.000 85.906 178.800 173.800
setObjFPlanBox Module u0 82.000 85.600 178.800 169.808
setObjFPlanBox Module u0 82.000 85.600 174.796 170.200
setObjFPlanBox Module u0 92.867 85.600 174.800 170.200
setObjFPlanBox Module u0 85.957 85.600 174.800 170.200
setObjFPlanBox Module u0 86.000 85.600 174.800 174.744
setObjFPlanBox Module u0 86.000 85.600 179.731 175.600
setObjFPlanBox Module u0 86.000 79.983 179.800 175.600
setObjFPlanBox Module u0 81.022 80.200 179.800 175.600
setObjFPlanBox Module u0 81.0 81.187 179.8 176.587
deselectAll
selectObject Module us00
setObjFPlanBox Module us00 14.0865 201.209 59.6145 246.2885
setObjFPlanBox Module us00 14.000 200.800 63.255 245.800
setObjFPlanBox Module us00 14.000 219.162 63.200 245.800
setObjFPlanBox Module us00 14.000 213.240 63.200 245.800
setObjFPlanBox Module us00 14.000 210.279 63.200 245.800
setObjFPlanBox Module us00 14.000 216.201 63.200 245.800
setObjFPlanBox Module us00 13.013 217.0 62.213 245.8
setObjFPlanBox Module us00 13.987 217.0 63.187 245.8
setObjFPlanBox Module us00 14.000 214.227 63.200 245.800
setObjFPlanBox Module us00 14.000 213.400 61.280 245.800
deselectAll
selectObject Module us01
setObjFPlanBox Module us01 64.55 201.2085 109.9585 246.1695
setObjFPlanBox Module us01 64.600 200.800 116.557 245.800
setObjFPlanBox Module us01 64.600 214.227 116.600 245.800
setObjFPlanBox Module us01 64.600 213.400 111.622 245.800
deselectAll
selectObject Module us02
setObjFPlanBox Module us02 149.442 202.1965 195.1775 247.4815
deselectAll
selectObject Module us03
setObjFPlanBox Module us03 203.0745 200.222 248.7465 245.444
setObjFPlanBox Module us03 203.000 214.227 248.600 245.800
deselectAll
selectObject Module us02
setObjFPlanBox Module us02 137.5545 202.6 183.3545 247.6
setObjFPlanBox Module us03 198.486 213.400 248.600 245.800
setObjFPlanBox Module us02 142.5355 199.639 188.3355 244.639
setObjFPlanBox Module us02 142.600 199.000 188.400 244.000
setObjFPlanBox Module us02 136.6775 199.9875 182.4775 244.9875
undo
setObjFPlanBox Module us02 136.6775 199.987 182.4775 244.987
setObjFPlanBox Module us02 135.6125 200.8 181.4125 245.8
setObjFPlanBox Module us02 135.600 200.800 190.589 245.800
setObjFPlanBox Module us02 135.600 212.252 190.600 245.800
setObjFPlanBox Module us02 135.600 215.214 190.600 245.800
setObjFPlanBox Module us02 146.170 215.200 190.600 245.800
zoomIn
panPage -1 0
panPage -1 0
panPage 1 0
panPage 1 0
panPage 1 0
panPage 1 0
panPage -1 0
panPage 0 1
panPage 0 1
setObjFPlanBox Module us02 146.200 215.200 190.600 245.800
setObjFPlanBox Module us02 146.200 215.200 193.517 245.800
setObjFPlanBox Module us02 146.200 214.227 193.600 245.800
zoomOut
panPage -1 0
deselectAll
selectObject Module us20
setObjFPlanBox Module us20 13.3675 163.4375 58.888 208.5095
setObjFPlanBox Module us20 13.400 180.666 59.000 208.000
setObjFPlanBox Module us20 13.400 181.000 62.662 208.000
setObjFPlanBox Module us20 13.4 182.974 62.6 209.974
setObjFPlanBox Module us20 13.400 181.653 62.600 209.800
fit
setObjFPlanBox Module us20 11.71 181.0 60.91 209.8
setObjFPlanBox Module us20 11.3775 181.0 60.5775 209.8
setObjFPlanBox Module us20 13.09 181.0 62.29 209.8
deselectAll
selectObject Module us00
setObjFPlanBox Module us00 8.507 209.1745 55.707 241.5745
undo
setObjFPlanBox Module us01 64.600 213.400 111.600 245.800
setObjFPlanBox Module us00 112.872 218.893 160.072 251.293
undo
setObjFPlanBox Module us00 14.000 215.529 61.200 245.800
deselectAll
selectObject Module us20
setObjFPlanBox Module us20 13.000 181.000 62.200 211.303
deselectAll
selectObject Module us01
setObjFPlanBox Module us01 65.8675 213.4 112.8675 245.8
setObjFPlanBox Module us00 14.000 215.200 62.816 245.800
setObjFPlanBox Module us01 65.800 215.106 112.800 245.800
setObjFPlanBox Module us01 65.800 215.200 115.633 245.800
fit
zoomOut
setObjFPlanBox Module us21 -45.743 50.910 0.000 96.202
deselectAll
selectObject Module us21
setObjFPlanBox Module us21 65.805 166.26 111.548 211.5525
zoomIn
setObjFPlanBox Module us21 65.800 182.148 111.600 211.600
setObjFPlanBox Module us21 65.800 182.800 116.055 211.600
setObjFPlanBox Module us21 65.800 181.726 116.000 211.600
fit
fit
zoomOut
deselectAll
selectObject Module us32
setObjFPlanBox Module us32 144.4985 160.984 191.2405 207.2655
zoomIn
setObjFPlanBox Module us32 145.6675 163.735 192.4675 210.535
setObjFPlanBox Module us32 145.600 163.000 193.800 209.800
setObjFPlanBox Module us32 145.600 182.148 193.800 209.800
setObjFPlanBox Module us32 145.6 184.49 193.8 211.49
setObjFPlanBox Module us32 145.600 182.571 193.800 211.600
setObjFPlanBox Module us32 145.6 181.955 193.8 210.755
setObjFPlanBox Module us32 145.6 181.5325 193.8 210.3325
setObjFPlanBox Module us02 146.200 216.373 193.600 245.800
setObjFPlanBox Module us32 145.600 181.000 193.800 212.148
setObjFPlanBox Module us02 143.942 217.000 193.600 245.800
setObjFPlanBox Module us32 143.942 181.000 193.800 211.600
setObjFPlanBox Module us02 144.000 215.951 193.600 245.800
deselectAll
selectObject Module us03
setObjFPlanBox Module us03 198.4 213.8225 248.6 246.2225
setObjFPlanBox Module us03 198.400 214.683 248.600 245.800
deselectAll
selectObject Module us33
setObjFPlanBox Module us33 197.578 165.632 243.377 210.98
setObjFPlanBox Module us33 197.600 164.800 249.151 209.800
setObjFPlanBox Module us33 197.600 180.036 249.200 209.800
setObjFPlanBox Module us33 198.0225 181.3125 249.6225 211.9125
setObjFPlanBox Module us33 198.000 180.458 249.600 211.600
fit
zoomOut
deselectAll
selectObject Module us10
setObjFPlanBox Module us10 -223.9055 132.035 -177.4445 178.0385
deselectAll
selectObject Module us22
setObjFPlanBox Module us22 13.9585 15.211 59.5425 60.346
deselectAll
selectObject Module us23
setObjFPlanBox Module us23 76.021 16.4785 122.4195 62.42
fit
deselectAll
selectObject Module us22
setObjFPlanBox Module us22 14.000 15.400 59.600 42.291
setObjFPlanBox Module us22 14.000 15.400 63.661 42.400
setObjFPlanBox Module us22 14.000 15.400 63.600 43.982
setObjFPlanBox Module us22 14.000 15.400 63.600 45.249
deselectAll
selectObject Module us23
setObjFPlanBox Module us23 69.2395 15.9325 115.6395 62.7325
setObjFPlanBox Module us23 66.6645 15.4 113.0645 62.2
setObjFPlanBox Module us23 66.600 15.400 113.000 45.672
setObjFPlanBox Module us23 68.713 16.245 115.113 46.845
undo
setObjFPlanBox Module us23 66.600 15.400 116.478 46.000
setObjFPlanBox Module us23 66.600 15.400 119.013 46.000
setObjFPlanBox Module us23 66.600 15.400 117.745 46.000
zoomOut
deselectAll
selectObject Module us30
setObjFPlanBox Module us30 -227.435 -54.5065 -181.438 -8.9625
deselectAll
selectObject Module us31
setObjFPlanBox Module us31 203.909 16.4785 249.708 61.8265
deselectAll
selectObject Module us30
setObjFPlanBox Module us30 143.9685 15.211 189.9655 60.755
zoomIn
deselectAll
selectObject Module us31
setObjFPlanBox Module us31 204.0 14.242 249.8 59.242
setObjFPlanBox Module us31 204.000 13.600 249.800 45.248
setObjFPlanBox Module us31 199.293 13.600 249.800 46.000
setObjFPlanBox Module us31 199.200 13.600 249.800 47.361
setObjFPlanBox Module us31 199.200 13.600 249.800 45.671
setObjFPlanBox Module us31 201.406 13.600 249.800 46.000
deselectAll
selectObject Module us30
setObjFPlanBox Module us30 153.296 13.2875 199.296 58.2875
setObjFPlanBox Module us30 153.200 13.600 199.200 45.671
setObjFPlanBox Module us30 149.858 13.600 199.200 46.000
zoomOut
deselectAll
selectObject Module us10
setObjFPlanBox Module us10 11.866 52.177 58.327 98.1805
setObjFPlanBox Module us11 -228.148 50.910 -182.286 96.320
deselectAll
selectObject Module us11
setObjFPlanBox Module us11 68.468 50.9095 114.3305 96.32
deselectAll
selectObject Module us12
setObjFPlanBox Module us12 149.8225 50.9095 195.038 95.6795
deselectAll
selectObject Module us13
setObjFPlanBox Module us13 200.1085 50.9095 245.915 96.265
zoomIn
setObjFPlanBox Module us10 11.800 51.400 58.200 79.895
setObjFPlanBox Module us11 68.400 51.400 114.200 79.895
deselectAll
selectObject Module us11
setObjFPlanBox Module us11 66.2875 50.1325 112.0875 78.9325
setObjFPlanBox Module us11 66.200 49.600 116.900 78.400
setObjFPlanBox Module us11 66.200 49.600 116.800 78.628
deselectAll
selectObject Module us10
setObjFPlanBox Module us10 13.9125 49.71 60.3125 78.51
setObjFPlanBox Module us10 14.000 49.600 64.084 78.400
deselectAll
selectObject Module us11
setObjFPlanBox Module us11 66.200 49.600 118.168 78.400
deselectAll
selectObject Module us10
setObjFPlanBox Module us10 14.000 49.600 64.000 79.050
setObjFPlanBox Module us10 14.000 49.600 64.000 79.895
deselectAll
selectObject Module us11
setObjFPlanBox Module us11 66.200 49.600 118.200 78.628
setObjFPlanBox Module us12 149.800 51.400 195.000 77.782
deselectAll
selectObject Module us12
setObjFPlanBox Module us12 150.2225 49.2875 195.4225 76.2875
setObjFPlanBox Module us12 150.200 49.600 195.400 78.206
deselectAll
selectObject Module us13
setObjFPlanBox Module us13 203.5805 48.442 249.3805 93.442
setObjFPlanBox Module us12 150.200 49.600 198.870 78.400
deselectAll
selectObject Module us12
setObjFPlanBox Module us12 150.2 49.1775 198.8 77.9775
setObjFPlanBox Module us12 150.2 48.3325 198.8 77.1325
setObjFPlanBox Module us12 149.7775 49.0675 198.3775 77.8675
setObjFPlanBox Module us13 203.600 47.800 249.400 78.628
setObjFPlanBox Module us13 201.828 47.800 249.400 78.400
deselectAll
selectObject Module us13
setObjFPlanBox Module us13 202.2225 49.0675 249.8225 79.6675
setObjFPlanBox Module us13 200.983 49.600 249.800 80.200
setObjFPlanBox Module us12 149.800 49.600 198.400 78.628
deselectAll
selectObject Module us12
setObjFPlanBox Module us12 150.2225 49.6 198.8225 78.4
setObjFPlanBox Module us12 150.200 49.600 198.800 79.050
setObjFPlanBox Module us12 150.200 49.600 198.800 78.206
setObjFPlanBox Module us12 150.200 49.600 198.800 78.628
setObjFPlanBox Module us12 149.435 49.600 198.800 78.400
setObjFPlanBox Module us12 149.4 51.29 198.8 80.09
undo
deselectAll
selectObject Module us30
setObjFPlanBox Module us30 148.11 13.6 197.51 46.0
setObjFPlanBox Module us30 148.200 13.600 197.600 44.403
deselectAll
selectObject Module us12
setObjFPlanBox Module us12 148.1325 47.0645 197.5325 75.8645
setObjFPlanBox Module us12 148.200 47.800 197.600 77.360
setObjFPlanBox Module us12 148.200 47.800 197.600 79.050
deselectAll
selectObject Module us31
setObjFPlanBox Module us31 201.4 12.755 249.8 45.155
deselectAll
selectObject Module us13
setObjFPlanBox Module us13 201.0 48.3325 249.8 78.9325
setObjFPlanBox Module us31 201.400 13.600 249.800 46.000
deselectAll
selectObject Module us31
setObjFPlanBox Module us31 201.4 12.755 249.8 45.155
setObjFPlanBox Module us31 201.4 11.4875 249.8 43.8875
setObjFPlanBox Module us31 200.138 11.800 249.800 44.200
setObjFPlanBox Module us31 201.89 11.8 251.49 44.2
setObjFPlanBox Module us31 201.800 14.404 251.400 44.200
setPlaceMode -timingDriven true -reorderScan false -congEffort medium -modulePlan false
setOptMode -effort high -powerEffort high -leakageToDynamicRatio 0.5 -fixFanoutLoad true -restruct true -verbose true
place_opt_design
saveDesign placement.enc
report_timing -max_paths 5 > ${design}.post_route.timing.rpt
report_power -outfile aes_cipher_top.post_route.power.rpt
summaryReport -nohtml -outfile aes_cipher_top.post_route.summary.rpt
set_ccopt_property -update_io_latency false
create_ccopt_clock_tree_spec -file ../../desdir/constraints/aes_cipher_top.ccopt
ccopt_design
set_propagated_clock [all_clocks]
optDesign -postCTS -hold
saveDesign cts.enc
setDrawView ameba
setDrawView ameba
setDrawView place
setDrawView fplan
