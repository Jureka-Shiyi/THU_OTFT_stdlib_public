#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Sat Dec 27 16:30:19 2025                
#                                                     
#######################################################

#@(#)CDS: Innovus v19.13-s080_1 (64bit) 01/24/2020 18:10 (Linux 2.6.32-431.11.2.el6.x86_64)
#@(#)CDS: NanoRoute 19.13-s080_1 NR200109-1001/19_13-UB (database version 18.20, 500.7.1) {superthreading v1.52}
#@(#)CDS: AAE 19.13-s032 (64bit) 01/24/2020 (Linux 2.6.32-431.11.2.el6.x86_64)
#@(#)CDS: CTE 19.13-s027_1 () Jan  7 2020 13:13:42 ( )
#@(#)CDS: SYNTECH 19.13-s013_1 () Dec 11 2019 02:45:06 ( )
#@(#)CDS: CPE v19.13-s058
#@(#)CDS: IQuantus/TQuantus 19.1.3-s155 (64bit) Sun Nov 3 18:26:52 PST 2019 (Linux 2.6.32-431.11.2.el6.x86_64)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
getVersion
define_proc_arguments ViaFillQor -info {This procedure extracts Viafill details from innovus db} -define_args {
        {-window "window coordinates" "" list optional}
        {-window_size "window size in microns" "" string optional}
    
    }
define_proc_arguments ProcessFills -info {This procedure processes Fill types} -define_args {
    {-fillInfo "Design Fill data" "" list required}
				{-csvName "File path for Fill Data csv file" "Path of CSV file" string required}
				{-selectFill "type of fill to be selected in session" "list of BRIDGE/EXTENSION/STAMP/FLOATING" list required}
    {-output_data "Boolean Flag to output Fill Data for further processing" "" string required}
}
define_proc_arguments FillQor -info {This procedure extracts fill details from innovus db} -define_args {
    {-layers "Fills Cleanup on which all layers" "list of Metal/Routing layers" list optional}
				{-selectFill "type of fill to be selected in session" "list of BRIDGE/EXTENSION/STAMP/FLOATING" list optional}
				{-outData "Boolean Flag to output Fill Data for further processing" "" boolean optional}
    {-outDataFile "File path for Fill Data csv file" "Path of CSV file" string optional}
}
define_proc_arguments ProcessFills_fast -info {This procedure processes Fill types} -define_args {
    {-fillInfo "Design Fill data" "" list required}
				{-csvName "File path for Fill Data csv file" "Path of CSV file" string required}
				{-selectFill "type of fill to be selected in session" "list of BRIDGE/EXTENSION/STAMP/FLOATING" list required}
    {-output_data "Boolean Flag to output Fill Data for further processing" "" string required}
}
define_proc_arguments FillQor_fast -info {This procedure extracts fill details from innovus db} -define_args {
    {-layers "Fills Cleanup on which all layers" "list of Metal/Routing layers" list optional}
				{-selectFill "type of fill to be selected in session" "list of BRIDGE/EXTENSION/STAMP/FLOATING" list optional}
				{-outData "Boolean Flag to output Fill Data for further processing" "" boolean optional}
    {-outDataFile "File path for Fill Data csv file" "Path of CSV file" string optional}
}
define_proc_arguments ProcessFills_fast_stampOnly -info {This procedure processes Fill types} -define_args {
    {-fillInfo "Design Fill data" "" list required}
	
}
define_proc_arguments FillQor_fast_stampOnly -info {This procedure extracts fill details from innovus db} -define_args {
    {-layers "Fills Cleanup on which all layers" "list of Metal/Routing layers" list optional}
}
win
set init_verilog /data/zhengyj/OTFT_stdlib/OTFT_stdlib_innovus/half_adder/netlist/half_adder.v
set init_design_settop 1
set init_top_cell half_adder
set init_lef_file {/data/zhengyj/OTFT_stdlib/OTFT_stdlib_lib/OTFT_stdlib_16/OTFT_stdlib_16.tlef /data/zhengyj/OTFT_stdlib/OTFT_stdlib_lib/OTFT_stdlib_16/OTFT_stdlib_16.lef}
set init_mmmc_file /data/zhengyj/OTFT_stdlib/OTFT_stdlib_innovus/half_adder/netlist/half_adder.view
set init_pwr_net VDD
set init_gnd_net VSS
setGenerateViaMode -auto true
init_design
setDesignMode -process 250
setPlaceMode -place_detail_legalization_inst_gap 2
globalNetConnect VDD -type pgpin -pin VDD -instanceBasename * -hierarchicalInstance {} -override -verbose
globalNetConnect VSS -type pgpin -pin VSS -instanceBasename * -hierarchicalInstance {} -override -verbose
globalNetConnect VDD -type tiehi -instanceBasename * -hierarchicalInstance {}
globalNetConnect VSS -type tielo -instanceBasename * -hierarchicalInstance {}
floorPlan -site CoreSite -s 13500 8100 180 180 180 180
setPinAssignMode -pinEditInBatch true
editPin -pin in1 -assign {1350.0 8100.0} -layer M1 -snap USERGRID
editPin -pin in2 -assign {1912.5 8100.0} -layer M1 -snap USERGRID
editPin -pin sum -assign {3600.0 8100.0} -layer M1 -snap USERGRID
editPin -pin cout -assign {4725.0 8100.0} -layer M1 -snap USERGRID
editPin -pin reset -assign {0.0 1840.90909091} -layer M1 -snap USERGRID
editPin -pin CLK -assign {3262.5 0.0} -layer M1 -snap USERGRID
setPinAssignMode -pinEditInBatch false
saveDesign /data/zhengyj/OTFT_stdlib/OTFT_stdlib_innovus/half_adder/saved/floorplan.enc
setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer M2 -stacked_via_bottom_layer M1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog {
    padcore_ring
    block_ring
  } -skip_via_on_pin {
    standardcell
  } -skip_via_on_wire_shape {
    noshape
  }
addStripe -nets { VDD VSS } -layer M1 -direction horizontal -width 30 -spacing 870 -set_to_set_distance 1800 -start_from bottom -start_offset 165 -switch_layer_over_obs false -max_same_layer_jog_length 3 -padcore_ring_top_layer_limit M2 -padcore_ring_bottom_layer_limit M1 -block_ring_top_layer_limit M2 -block_ring_bottom_layer_limit M1 -use_wire_group 0 -snap_wire_center_to_grid None
addStripe -nets { VDD VSS } -layer M2 -direction vertical -width 60 -spacing 200 -set_to_set_distance 3000 -start_from left -start_offset 300 -switch_layer_over_obs false -max_same_layer_jog_length 3 -padcore_ring_top_layer_limit M2 -padcore_ring_bottom_layer_limit M1 -block_ring_top_layer_limit M2 -block_ring_bottom_layer_limit M1 -use_wire_group 0 -snap_wire_center_to_grid None
sroute -connect { corePin } -layerChangeRange { M1 M2 } -blockPinTarget { nearestTarget } -allowJogging false -crossoverViaLayerRange { M1 M2 }
createPGPin VDD -net VDD -geom M2 180 500 280 600
createPGPin VSS -net VSS -geom M2 180 200 280 300
verifyConnectivity -noAntenna -noSoftPGConnect -noUnroutedNet -net VDD
verifyConnectivity -noAntenna -noSoftPGConnect -noUnroutedNet -net VSS
verify_PG_short -no_routing_blkg
verify_drc
saveDesign /data/zhengyj/OTFT_stdlib/OTFT_stdlib_innovus/half_adder/saved/pg.enc
setMultiCpuUsage -localCpu 16 -cpuPerRemoteHost 1 -remoteHost 0 -keepLicense true
setDistributeHost -local
setRouteMode -earlyGlobalHonorMsvRouteConstraint false -earlyGlobalRoutePartitionPinGuide true
setEndCapMode -reset
setEndCapMode -leftEdge BOUNDARY_RIGHT -rightEdge BOUNDARY_LEFT -boundary_tap false
setNanoRouteMode -quiet -droutePostRouteSpreadWire 1
setNanoRouteMode -quiet -timingEngine {}
setNanoRouteMode -quiet -routeTopRoutingLayer 2
setNanoRouteMode -quiet -routeBottomRoutingLayer 1
setUsefulSkewMode -maxSkew false -noBoundary false -useCells {INVD8 INVD4 INVD2 INVD1} -maxAllowedDelay 1
setRouteMode -earlyGlobalMaxRouteLayer 2
setPlaceMode -fp false -timingDriven 0 -congEffort medium -ignoreScan 1 -placeIOPins 0 -place_detail_legalization_inst_gap 2
checkDesign -all
addEndCap -prefix EndCap
place_design -noPrePlaceOpt
checkPlace
refinePlace
setMultiCpuUsage -localCpu 16 -cpuPerRemoteHost 1 -remoteHost 0 -keepLicense true
setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -preCTS
saveDesign /data/zhengyj/OTFT_stdlib/OTFT_stdlib_innovus/half_adder/saved/place.enc
fit
zoomBox -693.00000 -2821.03000 44729.43000 21221.50000
fit
zoomBox -1364.86000 356.83000 13579.32000 8266.93000
zoomBox 421.54000 3151.86000 6057.75000 6135.16000
zoomBox 86.82000 2860.77000 6717.67000 6370.54000
zoomBox -332.87000 2523.39000 7468.13000 6652.53000
zoomBox -232.27000 2879.57000 6398.58000 6389.34000
zoomBox -12.29000 3658.39000 4059.89000 5813.83000
zoomBox 254.80000 4349.58000 2061.66000 5305.97000
zoomBox 141.81000 4259.72000 2267.54000 5384.89000
zoomBox -15.21000 4162.31000 2485.65000 5486.04000
zoomBox -190.75000 4044.07000 2751.44000 5601.40000
zoomBox -640.21000 3741.32000 3432.02000 5896.79000
zoomBox -935.40000 3540.05000 3855.46000 6075.90000
setLayerPreference M1 -isVisible 0
setLayerPreference M1 -isVisible 1
setLayerPreference M1 -isVisible 0
setLayerPreference M1 -isVisible 1
zoomBox -2050.82000 3393.03000 4580.16000 6902.87000
zoomBox -2681.89000 3169.97000 5119.26000 7299.19000
zoomBox -1903.98000 3270.06000 4727.00000 6779.90000
zoomBox 203.10000 3531.55000 3664.51000 5363.71000
zoomBox -176.99000 3459.67000 3895.26000 5615.15000
zoomBox -1150.22000 3275.62000 4486.13000 6258.99000
zoomBox -1673.67000 3013.89000 4957.33000 6523.74000
zoomBox -3014.01000 2343.72000 6163.85000 7201.65000
zoomBox -1643.83000 3272.66000 4987.19000 6782.52000
zoomBox -653.87000 3943.82000 4137.05000 6479.70000
zoomBox -1092.94000 3698.22000 4543.44000 6681.61000
zoomBox -2216.25000 3073.11000 5584.97000 7202.37000
zoomBox -2935.98000 2744.32000 6241.93000 7602.28000
zoomBox -3782.73000 2357.52000 7014.83000 8072.77000
zoomBox -4778.90000 1902.46000 7924.12000 8626.29000
zoomBox -5889.53000 1117.91000 9055.20000 9028.30000
zoomBox -3212.73000 1296.40000 5965.21000 6154.37000
zoomBox -808.58000 1620.25000 3263.74000 3775.77000
zoomBox -33.71000 1758.11000 2467.23000 3081.88000
zoomBox 151.66000 1791.33000 2277.46000 2916.54000
zoomBox 556.98000 1863.98000 1862.50000 2555.00000
zoomBox 871.01000 1930.43000 1552.52000 2291.16000
uiSetTool ruler
uiSetTool ruler
zoomBox 621.97000 1896.37000 1731.72000 2483.77000
zoomBox 351.27000 1826.03000 2158.32000 2782.52000
zoomBox -95.41000 1679.23000 2847.08000 3236.72000
uiSetTool ruler
uiSetTool ruler
uiSetTool ruler
zoomBox -308.48000 1651.27000 3153.27000 3483.61000
zoomBox -559.15000 1618.38000 3513.49000 3774.07000
zoomBox -838.46000 1476.69000 3952.89000 4012.80000
zoomBox -1167.06000 1310.01000 4469.83000 4293.67000
zoomBox -2602.01000 275.31000 6576.74000 5133.71000
fit
zoomBox 502.83000 64.82000 15447.01000 7974.92000
zoomBox 4219.48000 831.92000 15016.64000 6546.96000
zoomBox 11833.43000 2507.45000 13959.16000 3632.62000
zoomBox 12058.14000 2571.97000 13865.01000 3528.36000
zoomBox 12249.14000 2626.81000 13784.98000 3439.74000
fit
zoomBox -1046.07000 406.29000 11656.50000 7129.88000
zoomBox -1191.10000 80.21000 13753.10000 7990.32000
fit
fit
fit
fit
zoomBox -227.00000 706.85000 1315.10000 -247.42000
uiSetTool ruler
zoomBox -119.04000 -53.19000 988.14000 532.85000
zoomBox -13.78000 32.58000 786.16000 456.00000
zoomBox 29.51000 65.09000 709.47000 425.00000
zoomBox 97.59000 116.21000 588.87000 376.25000
uiSetTool ruler
zoomBox 64.53000 106.57000 642.51000 412.50000
zoomBox 108.80000 146.81000 600.08000 406.85000
zoomBox 146.43000 181.02000 564.02000 402.05000
zoomBox 114.85000 147.16000 606.13000 407.20000
uiSetTool ruler
zoomBox 211.81000 155.15000 566.76000 343.03000
zoomBox 309.22000 163.17000 527.22000 278.56000
zoomBox 249.66000 158.26000 551.41000 317.98000
zoomBox 211.79000 155.14000 566.79000 343.04000
zoomBox 114.80000 147.14000 606.16000 407.22000
zoomBox 346.43000 302.24000 503.96000 385.62000
fit
zoomBox -372.05000 1470.26000 1223.49000 -239.78000
zoomBox -934.19000 -169.71000 1811.92000 1283.83000
zoomBox -1167.13000 -229.26000 2063.59000 1480.79000
zoomBox -942.61000 -169.72000 1803.51000 1283.83000
zoomBox -751.77000 -119.10000 1582.44000 1116.42000
zoomBox -451.66000 -39.50000 1234.80000 853.16000
zoomBox 82.91000 448.94000 518.62000 -44.63000
zoomBox -206.28000 -66.14000 890.76000 514.53000
uiSetTool ruler
zoomBox -277.57000 -95.07000 1013.07000 588.08000
zoomBox -201.16000 -64.39000 895.89000 516.29000
uiSetTool ruler
uiSetTool ruler
uiSetTool ruler
uiSetTool ruler
zoomBox -438.43000 -108.16000 1080.00000 695.56000
fit
fit
zoomBox -950.91000 455.02000 11751.66000 7178.61000
zoomBox 214.69000 1210.60000 6845.52000 4720.36000
zoomBox 709.09000 1498.35000 4781.25000 3653.78000
fit
zoomBox -775.13000 209.11000 14169.05000 8119.21000
zoomBox 2903.21000 2376.62000 8539.42000 5359.92000
fit
