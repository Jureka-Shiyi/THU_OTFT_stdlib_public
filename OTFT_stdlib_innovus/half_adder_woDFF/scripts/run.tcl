## VARIABLES/INPUTS
set designName full_adder
set syn_netlist "LTPS_TFT_stdlib_public/innovus/${designName}/netlist/${designName}.v"
set lef_file [glob LTPS_TFT_stdlib_public/innovus/rules/LTPS_TFT_stdlib.tlef LTPS_TFT_stdlib_public/innovus/rules/LTPS_TFT_stdlib.lef ]

set mmmc_file "LTPS_TFT_stdlib_public/innovus/${designName}/netlist/${designName}.view"
#set IO_file "netlist/${designName}.io"

## Loading design
set init_verilog $syn_netlist
set init_design_settop 1
set init_top_cell $designName
set init_lef_file $lef_file
set init_mmmc_file $mmmc_file
#set init_io_file $IO_file
set init_pwr_net VDD
set init_gnd_net VSS
setGenerateViaMode -auto true
init_design

#floorplan
set core_width 6000
set core_height 1000
set boundary_x 20
set boundary_y 20
floorPlan -site core -s $core_width $core_height $boundary_x $boundary_x $boundary_y $boundary_y

# add pin
source "LTPS_TFT_stdlib_public/innovus/${designName}/scripts/pin.tcl"

saveDesign "LTPS_TFT_stdlib_public/innovus/${designName}/saved/floorplan.enc"

setDesignMode -process 250
setPlaceMode -place_detail_legalization_inst_gap 2
globalNetConnect VDD -type pgpin -pin VDD -instanceBasename * -hierarchicalInstance {} -override -verbose
globalNetConnect VSS -type pgpin -pin VSS -instanceBasename * -hierarchicalInstance {} -override -verbose
globalNetConnect VDD -type tiehi -instanceBasename * -hierarchicalInstance {}
globalNetConnect VSS -type tielo -instanceBasename * -hierarchicalInstance {}

# add power stripe
setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer ITO -stacked_via_bottom_layer M1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }

addStripe -nets {VDD VSS} -layer M2 -direction horizontal -width 15 -spacing 57 -set_to_set_distance 144 -start_from bottom -start_offset -7.5 -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit ITO -padcore_ring_bottom_layer_limit M1 -block_ring_top_layer_limit ITO -block_ring_bottom_layer_limit M1 -use_wire_group 0 -snap_wire_center_to_grid None

addStripe -nets {VDD VSS} -layer ITO -direction vertical -width 60 -spacing 60 -set_to_set_distance 240 -start_from left -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit ITO -padcore_ring_bottom_layer_limit M1 -block_ring_top_layer_limit ITO -block_ring_bottom_layer_limit M1 -use_wire_group 0 -snap_wire_center_to_grid None

createPGPin VDD -net VDD -geom M2 25 15 35 25
createPGPin VSS -net VSS -geom M2 25 87 35 97

verifyConnectivity -noAntenna -noSoftPGConnect -noUnroutedNet -net VDD
verifyConnectivity -noAntenna -noSoftPGConnect -noUnroutedNet -net VSS
verify_PG_short -no_routing_blkg
verify_drc

saveDesign "LTPS_TFT_stdlib_public/innovus/${designName}/saved/pg.enc"

# PLACE
setMultiCpuUsage -localCpu 16 -cpuPerRemoteHost 1 -remoteHost 0 -keepLicense true
setDistributeHost -local
setRouteMode -earlyGlobalHonorMsvRouteConstraint false -earlyGlobalRoutePartitionPinGuide true

setEndCapMode -reset
setEndCapMode -leftEdge BOUNDARY_RIGHT -rightEdge BOUNDARY_LEFT -boundary_tap false

setNanoRouteMode -quiet -droutePostRouteSpreadWire 1
setNanoRouteMode -quiet -timingEngine {}
setNanoRouteMode -quiet -routeTopRoutingLayer 2
setNanoRouteMode -quiet -routeBottomRoutingLayer 1

setUsefulSkewMode -maxSkew false -noBoundary false -useCells {INVD16 INVD8 INVD4 INVD2 INVD1} -maxAllowedDelay 1

# Replace deprecated command
setRouteMode -earlyGlobalMaxRouteLayer 2

# Adjust place mode
setPlaceMode -congEffort auto -timingDriven 1 -clkGateAware 1 -powerDriven 0 -ignoreScan 1 -reorderScan 1 -ignoreSpare 0 -placeIOPins 0 -moduleAwareSpare 0 -preserveRouting 1 -swapEEQ 0

addEndCap -prefix EndCap
place_design


#eco
setMultiCpuUsage -localCpu 16 -cpuPerRemoteHost 1 -remoteHost 0 -keepLicense true
setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -preCTS

saveDesign "LTPS_TFT_stdlib_public/innovus/${designName}/saved/place.enc"


# CTS
setMultiCpuUsage -localCpu 16 -cpuPerRemoteHost 1 -remoteHost 0 -keepLicense true

setCTSMode -routeBottomPreferredLayer 1 \
           -routeTopPreferredLayer 2 \
           -routeLeafBottomPreferredLayer 1 \
           -routeLeafTopPreferredLayer 2

create_route_type -name leaf_rule -top_preferred_layer 2 -bottom_preferred_layer 1
create_route_type -name trunk_rule -top_preferred_layer 2 -bottom_preferred_layer 1

set_ccopt_property -net_type leaf -route_type leaf_rule
set_ccopt_property -net_type trunk -route_type trunk_rule
set_ccopt_property buffer_cells {BUFD2 BUFD4 BUFD8 BUFD16}
#set_ccopt_property buffer_cells {}
set_ccopt_property inverter_cells {INVD1 INVD2 INVD4 INVD8 INVD16}

set_ccopt_property -net_type trunk target_max_trans 600ns
set_ccopt_property -net_type leaf target_max_trans 600ns

create_ccopt_clock_tree_spec -file cts.spec
setOptMode -usefulSkewCCOpt extreme
source cts.spec
ccopt_design


#eco
setMultiCpuUsage -localCpu 16 -cpuPerRemoteHost 1 -remoteHost 0 -keepLicense true
setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -postCTS
setMultiCpuUsage -localCpu 16 -cpuPerRemoteHost 1 -remoteHost 0 -keepLicense true
optDesign -postCTS -hold

saveDesign "LTPS_TFT_stdlib_public/innovus/${designName}/saved/cts.enc"

#route
setNanoRouteMode -quiet -timingEngine {}
setNanoRouteMode -quiet -routeWithTimingDriven 1
setNanoRouteMode -quiet -routeWithLithoDriven 1
setNanoRouteMode -quiet -droutePostRouteLithoRepair 1
setNanoRouteMode -quiet -routeWithSiDriven 1
setNanoRouteMode -quiet -routeTopRoutingLayer 2
setNanoRouteMode -quiet -routeBottomRoutingLayer 1
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven true
setNanoRouteMode -quiet -routeWithSiDriven true

routeDesign -globalDetail -viaOpt -wireOpt

#eco
setAnalysisMode -analysisType onChipVariation
setMultiCpuUsage -localCpu 16 -cpuPerRemoteHost 1 -remoteHost 0 -keepLicense true
setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -postRoute
setMultiCpuUsage -localCpu 16 -cpuPerRemoteHost 1 -remoteHost 0 -keepLicense true
optDesign -postRoute -hold

setDelayCalMode -engine default -siAware true
optDesign -postRoute -hold

saveDesign "LTPS_TFT_stdlib_public/innovus/${designName}/saved/route.enc"

setMultiCpuUsage -localCpu 16 -cpuPerRemoteHost 1 -remoteHost 0 -keepLicense true
addFiller -cell FILL1 FILL2 FILL4 FILL8 FILL16 FILL32 FILL64 FILL128 -prefix FILLER -doDRC -fitGap

#setExtractRCMode -engine postRoute -coupled true -effortLevel signoff -lefTechFileMap LTPS_TFT_stdlib_public/innovus/rules/extract.layermap.log
#setExtractRCMode -engine postRoute -coupled true -effortLevel off -lefTechFileMap
#extractRC
#rcOut -rc_corner typical -spef "LTPS_TFT_stdlib_public/innovus/${designName}/output/typical.spef" 

saveNetlist -includePowerGround -excludeLeafCell "LTPS_TFT_stdlib_public/innovus/${designName}/output/full_adder.v"
streamOut "LTPS_TFT_stdlib_public/innovus/${designName}/output/full_adder.gds"
#streamOut "LTPS_TFT_stdlib_public/innovus/${designName}/output/full_adder.gds" -mapFile "LTPS_TFT_stdlib_public/innovus/${designName}/output/full_adder.map" -libName DesignLib -merge {"LTPS_TFT_stdlib_public/innovus/rules/LTPS_TFT_stdlib.gds"} -units 2000 -mode ALL
