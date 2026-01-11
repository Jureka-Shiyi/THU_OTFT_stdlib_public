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

saveDesign "./innovus/${designName}/saved/cts.enc"
