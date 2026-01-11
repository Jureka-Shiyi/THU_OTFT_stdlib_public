# 03_place PLACE & preCTS ECO
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

# Adjust place mode
# 如果层数很少（只有 M1/M2），必须关闭 timingDriven 或调低拥塞优化，因为工具可能觉得无法布通而拒绝放置
# 在层数极少的情况下，high 虽然能减少拥塞，但可能会导致工具因为找不到解而“发疯”拉开单元距离。对于半加器（Half Adder）这种极小规模的设计，medium 或 low 配合 Cell Halo 效果更好。
setPlaceMode -fp false \
             -timingDriven 0 \
             -congEffort medium \
             -ignoreScan 1 \
             -placeIOPins 0 \
             -place_detail_legalization_inst_gap 2 ;# 维持你之前的 Gap 要求

# 3. 增加 Placement Halo (重要预防措施)
# 既然你担心单元重叠和 Pin Access 困难，强制在每个单元周围留出空间
# 假设单元宽度 1000um，留出 20um 的空白区域
# addPlacementHalo -all_cells 20 20 20 20

# 建议在 place_design 之前加入
checkDesign -all

addEndCap -prefix EndCap
place_design -noPrePlaceOpt

# 检查是否存在严重的单元重叠或无法放置的情况
checkPlace
set unplaced_count [llength [dbGet [dbGet -p head.allCells.status unplaced].name]]
if {$unplaced_count > 0} {
    puts "Warning: $unplaced_count cells are still unplaced. Forcing placement..."
    refinePlace
}

#eco
setMultiCpuUsage -localCpu 16 -cpuPerRemoteHost 1 -remoteHost 0 -keepLicense true
setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -preCTS
# 7. 检查走线预估 (Early Global Route)
# 在 place 之后预览一下 M2 是否已经堵死
trialRoute

saveDesign "${saved_dir}/place.enc"
