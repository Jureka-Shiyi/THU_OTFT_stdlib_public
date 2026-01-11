# 02_pg_stripe.tcl add power stripe  

setAddStripeMode \
  -ignore_block_check false \
  -break_at none \
  -route_over_rows_only false \
  -rows_without_stripes_only false \
  -extend_to_closest_target none \
  -stop_at_last_wire_for_area false \
  -partial_set_thru_domain false \
  -ignore_nondefault_domains false \
  -trim_antenna_back_to_shape none \
  -spacing_type edge_to_edge \
  -spacing_from_block 0 \
  -stripe_min_length stripe_width \
  -stacked_via_top_layer M2 \
  -stacked_via_bottom_layer M1 \
  -via_using_exact_crossover_size false \
  -split_vias false \
  -orthogonal_only true \
  -allow_jog {
    padcore_ring
    block_ring
  } \
  -skip_via_on_pin {
    standardcell
  } \
  -skip_via_on_wire_shape {
    noshape
  }

# ============================================================
# Horizontal stripes on M1
# ============================================================

addStripe \
  -nets { VSS VDD  } \
  -layer M1 \
  -direction horizontal \
  -width 30 \
  -spacing 870 \
  -set_to_set_distance 1800 \
  -start_from bottom \
  -start_offset -15 \
  -switch_layer_over_obs false \
  -max_same_layer_jog_length 3 \
  -padcore_ring_top_layer_limit M2 \
  -padcore_ring_bottom_layer_limit M1 \
  -block_ring_top_layer_limit M2 \
  -block_ring_bottom_layer_limit M1 \
  -use_wire_group 0 \
  -snap_wire_center_to_grid None

# ============================================================
# Vertical stripes on M2
# ============================================================

addStripe \
  -nets { VDD VSS } \
  -layer M2 \
  -direction vertical \
  -width 60 \
  -spacing 200 \
  -set_to_set_distance 3000 \
  -start_from left \
  -start_offset 300 \
  -switch_layer_over_obs false \
  -max_same_layer_jog_length 3 \
  -padcore_ring_top_layer_limit M2 \
  -padcore_ring_bottom_layer_limit M1 \
  -block_ring_top_layer_limit M2 \
  -block_ring_bottom_layer_limit M1 \
  -use_wire_group 0 \
  -snap_wire_center_to_grid None

# 针对 OTFT，确保 connect 选项包含 standardcell pins
sroute -connect { corePin } \
        -layerChangeRange { M1 M2 } \
        -blockPinTarget { nearestTarget } \
        -allowJogging false \
        -crossoverViaLayerRange { M1 M2 }

# 3. 创建足够大的外部接口 Pin (假设需要 100um 的 Pad)
createPGPin VDD -net VDD -geom M2 180 500 280 600
createPGPin VSS -net VSS -geom M2 180 200 280 300
# createPGPin -net VDD -layer M2 -fromStripe

verifyConnectivity -noAntenna -noSoftPGConnect -noUnroutedNet -net VDD
verifyConnectivity -noAntenna -noSoftPGConnect -noUnroutedNet -net VSS
verify_PG_short -no_routing_blkg
verify_drc

saveDesign "${saved_dir}/pg.enc"

# setAddStripeMode \                                  # 设置后续 addStripe 的全局行为模式
#   -ignore_block_check false \                       # 不忽略 block / macro 阻挡，避免硬穿
#   -break_at none \                                  # 不在中途自动断开 stripe
#   -route_over_rows_only false \                     # stripe 不仅限于 standard cell row 上
#   -rows_without_stripes_only false \                # 不要求只在无 stripe 的 row 上加
#   -extend_to_closest_target none \                  # 不自动延伸到最近的 PG 目标
#   -stop_at_last_wire_for_area false \               # 不因局部面积限制提前终止 stripe
#   -partial_set_thru_domain false \                  # 不跨电源域只铺部分 stripe
#   -ignore_nondefault_domains false \                # 不忽略非默认电源域
#   -trim_antenna_back_to_shape none \                # 不对天线相关 shape 做裁剪
#   -spacing_type edge_to_edge \                      # spacing 按线边到线边计算
#   -spacing_from_block 0 \                           # stripe 与 block 之间不额外留距
#   -stripe_min_length stripe_width \                 # stripe 最小长度等于其宽度
#   -stacked_via_top_layer ITO \                      # 堆叠 via 的最高金属层为 ITO
#   -stacked_via_bottom_layer M1 \                    # 堆叠 via 的最低金属层为 M1
#   -via_using_exact_crossover_size false \            # via 不强制使用精确 crossover 尺寸
#   -split_vias false \                               # 不拆分 via
#   -orthogonal_only true \                           # stripe 只允许正交方向（水平/垂直）
#   -allow_jog {                                      # 允许在特定结构处产生 jog
#     padcore_ring                                    # 允许在 pad/core ring 处 jog
#     block_ring                                      # 允许在 block ring 处 jog
#   } \
#   -skip_via_on_pin {                                # 在指定 pin 类型上跳过自动插 via
#     standardcell                                    # 不在 standard cell PG pin（Power / Ground pin） 上打 via
#   } \
#   -skip_via_on_wire_shape {                         # 在指定 wire shape 上跳过 via
#     noshape                                         # 避免在异常 shape 上强制插 via
#   }

# # ============================================================
# # Horizontal stripes on M2
# # ============================================================

# addStripe \                                         # 添加电源 stripe
#   -nets { VDD VSS } \                               # 同时为 VDD / VSS 铺设
#   -layer M2 \                                      # stripe 所在金属层为 M2
#   -direction horizontal \                           # stripe 方向为水平方向
#   -width 15 \                                      # 每根 stripe 的线宽
#   -spacing 57 \                                    # VDD 与 VSS 之间的间距（edge-to-edge）
#   -set_to_set_distance 144 \                        # 相邻一组 VDD/VSS 的中心距离
#   -start_from bottom \                              # 从 core 底部开始铺 stripe
#   -start_offset -7.5 \                              # 相对起始边界的偏移量（向外偏移）
#   -switch_layer_over_obs false \                    # 不在障碍物上自动换层
#   -max_same_layer_jog_length 2 \                    # 同层 jog 的最大长度
#   -padcore_ring_top_layer_limit ITO \               # pad/core ring 允许连接的最高层
#   -padcore_ring_bottom_layer_limit M1 \             # pad/core ring 允许连接的最低层
#   -block_ring_top_layer_limit ITO \                 # block ring 允许连接的最高层
#   -block_ring_bottom_layer_limit M1 \               # block ring 允许连接的最低层
#   -use_wire_group 0 \                               # 不使用 wire group
#   -snap_wire_center_to_grid None                    # stripe 中心不强制对齐网格

# # ============================================================
# # Vertical stripes on ITO
# # ============================================================

# addStripe \                                         # 添加第二组电源 stripe
#   -nets { VDD VSS } \                               # 仍然为 VDD / VSS
#   -layer ITO \                                     # stripe 所在金属层为 ITO（顶层）
#   -direction vertical \                             # stripe 方向为垂直方向
#   -width 60 \                                      # ITO 层 stripe 更宽，作为主干供电
#   -spacing 60 \                                    # VDD / VSS 间距
#   -set_to_set_distance 240 \                        # 相邻 stripe 组的间距
#   -start_from left \                                # 从 core 左侧开始铺
#   -switch_layer_over_obs false \                    # 不在障碍物上自动换层
#   -max_same_layer_jog_length 2 \                    # 同层 jog 最大长度
#   -padcore_ring_top_layer_limit ITO \               # pad/core ring 最高连接层
#   -padcore_ring_bottom_layer_limit M1 \             # pad/core ring 最低连接层
#   -block_ring_top_layer_limit ITO \                 # block ring 最高连接层
#   -block_ring_bottom_layer_limit M1 \               # block ring 最低连接层
#   -use_wire_group 0 \                               # 不使用 wire group
#   -snap_wire_center_to_grid None                    # 不强制对齐网格中心
