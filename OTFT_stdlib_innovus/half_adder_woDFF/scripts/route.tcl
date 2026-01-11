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
