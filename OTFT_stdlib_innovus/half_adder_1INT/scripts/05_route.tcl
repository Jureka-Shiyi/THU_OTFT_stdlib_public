# =========================
# NanoRoute 设置
# =========================
# 05_route 不启用 timing engine，减少日志输出
setNanoRouteMode -quiet -timingEngine {}

# 开启 timing-driven 布线，考虑信号延迟
setNanoRouteMode -quiet -routeWithTimingDriven 1

# 开启 lithography 驱动布线，优化光刻可制造性
setNanoRouteMode -quiet -routeWithLithoDriven 1

# 微布线完成后进行 litho 修复
setNanoRouteMode -quiet -droutePostRouteLithoRepair 1

# 开启 SI 驱动布线，考虑串扰等信号完整性影响
setNanoRouteMode -quiet -routeWithSiDriven 1

# 设置最高布线层为 M2
setNanoRouteMode -quiet -routeTopRoutingLayer 2

# 设置最低布线层为 M1
setNanoRouteMode -quiet -routeBottomRoutingLayer 1

# 设置微布线结束迭代次数为默认
setNanoRouteMode -quiet -drouteEndIteration default

# 增加详细布线的迭代次数，OTFT 容易有 DRC 冲突
# setNanoRouteMode -quiet -drouteEndIteration 20

# # 再次确认 timing-driven 布线开启
# setNanoRouteMode -quiet -routeWithTimingDriven true

# 优化 Pin Access：强制通过 Via 连接 M1 的引脚到 M2 -routeWithViasOnlyForStandardCellPin不合法
# setNanoRouteMode -quiet -routeWithViasOnlyForStandardCellPin true
# 允许在违反某些次要 NDR 规则的情况下尽量布通
# setNanoRouteMode -quiet -drouteAutoStop false

# 再次确认 SI-aware 布线开启
setNanoRouteMode -quiet -routeWithSiDriven true

# =========================
# 执行布线
# =========================
# 执行全局+详细布线，并优化 via 与线形
routeDesign -globalDetail -viaOpt -wireOpt

# =========================
# Post-Route ECO / 优化
# =========================
# 设置分析模式为 OCV，考虑芯片内工艺变化
setAnalysisMode -analysisType onChipVariation

# 设置 CPU 并行，提高优化速度
setMultiCpuUsage -localCpu 16 -cpuPerRemoteHost 1 -remoteHost 0 -keepLicense true

# 修正电容、晶体管参数、扇出负载
setOptMode -fixCap true -fixTran true -fixFanoutLoad true

# 执行 post-route 优化，调整 timing / fanout / drive
optDesign -postRoute

# 再次设置 CPU 并行，用于 hold 优化
setMultiCpuUsage -localCpu 16 -cpuPerRemoteHost 1 -remoteHost 0 -keepLicense true

# 针对 hold timing 执行 post-route 优化
optDesign -postRoute -hold

# 设置延迟计算模式，开启 SI-aware
setDelayCalMode -engine default -siAware true

# 再次针对 hold timing 执行优化，确保时序可行
optDesign -postRoute -hold


