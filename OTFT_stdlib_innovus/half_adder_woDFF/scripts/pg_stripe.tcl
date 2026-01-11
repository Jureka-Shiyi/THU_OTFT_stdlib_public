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

saveDesign "./innovus/${designName}/saved/pg.enc"
