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

saveDesign "./innovus/${designName}/saved/place.enc"
