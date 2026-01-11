# 04_cts.tcl CTS
setMultiCpuUsage -localCpu 16 -cpuPerRemoteHost 1 -remoteHost 0 -keepLicense true
# set top_layer "M2"
# set bot_layer "M1"
# # 检查变量是否生效
# puts "Targeting Layers: Top=$top_layer, Bottom=$bot_layer"

setCTSMode -routeBottomPreferredLayer 1 \
           -routeTopPreferredLayer 2 \
           -routeLeafBottomPreferredLayer 1 \
           -routeLeafTopPreferredLayer 2

# delete_ccopt_clock_tree_spec
# catch {delete_route_type -name leaf_rule}
# catch {delete_route_type -name trunk_rule}
# 创建规则
# create_route_type -name leaf_rule \
#     -top_preferred_layer $top_layer \
#     -bottom_preferred_layer $bot_layer

create_route_type -name leaf_rule -top_preferred_layer M2 -bottom_preferred_layer M1

# 对于 Trunk（主干），建议强制在 M2 走线，因为 M1 被电源轨占用了
# create_route_type -name trunk_rule \
#     -top_preferred_layer $top_layer \
#     -bottom_preferred_layer $top_layer

create_route_type -name trunk_rule -top_preferred_layer M2 -bottom_preferred_layer M1

# 定义一个辅助函数，只有在不存在时才创建规则(防止 IMPCCOPT-4254 报错) 
# if {[dbGet -p head.routeTypes.name leaf_rule] == "0"} {
#     create_route_type -name leaf_rule -top_preferred_layer 2 -bottom_preferred_layer 1
#     puts "Creating leaf_rule..."
# } else {
#     puts "leaf_rule already exists, skipping creation."
# }

# create_route_type -name leaf_rule -top_preferred_layer 2 -bottom_preferred_layer 1
# create_route_type -name trunk_rule -top_preferred_layer 2 -bottom_preferred_layer 1

# if {[dbGet -p head.routeTypes.name trunk_rule] == "0"} {
#     create_route_type -name trunk_rule \
#         -top_preferred_layer 2 \
#         -bottom_preferred_layer 2 \
#         -preferred_routing_layer_effort high
#     puts "Creating trunk_rule..."
# } else {
#     puts "trunk_rule already exists, skipping creation."
# }

# setCTSMode is obsolete
# setCTSMode -routeBottomPreferredLayer 1 \
#            -routeTopPreferredLayer 2 \
#            -routeLeafBottomPreferredLayer 1 \
#            -routeLeafTopPreferredLayer 2

set_ccopt_property -net_type leaf -route_type leaf_rule
set_ccopt_property -net_type trunk -route_type trunk_rule

# --- 1. 定义可用单元库 ---
# set my_cts_cells {BUFD2 BUFD4 BUFD8 INVD1 INVD2 INVD4 INVD8}
# set_dont_use [get_lib_cells $my_cts_cells] false

# --- 2. 显式指定 CCOpt 使用的 Buffer 和 Inverter ---
set_ccopt_property buffer_cells {BUFD2 BUFD4 BUFD8}
set_ccopt_property inverter_cells {INVD1 INVD2 INVD4 INVD8}

set_ccopt_property -net_type trunk target_max_trans 1000000ns    ;# 周期的 10%~20%
set_ccopt_property -net_type leaf target_max_trans 1000000ns     ;# 周期的 10%~20%
set_ccopt_property target_skew 100000ns

# --- 4. 生成 Spec (核心修复点) ---
# 先尝试删除旧的 spec，防止 IMPCCOPT-2048
catch {delete_ccopt_clock_tree_spec}

create_ccopt_clock_tree_spec -file cts.spec
setOptMode -usefulSkewCCOpt extreme
source cts.spec
# 执行 CCOpt（Clock Tree Optimization），自动插入 buffers/inverters 并优化 skew/delay。 
ccopt_design    

# 检查时钟树质量
# report_ccopt_clock_tree_summary
# report_ccopt_skew_groups

# --- 6. Post-CTS 优化 ---
# set_db opt_mode_fix_cap true
# set_db opt_mode_fix_tran true
# set_db opt_mode_fix_fanout_load true

# --- 7. Post-CTS 优化与保存 ---
setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -postCTS
optDesign -postCTS -hold

saveDesign "${saved_dir}/cts.enc"
