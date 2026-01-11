#set driving
set cell_name $project_name
# unit:ns(dc_shell>report_lib <your_library_name>),20ms = 50Hz
set clk_period 2.0e7
set half_clk_period [expr {0.5*$clk_period}]
set min_clk_period [expr {0.1*$clk_period}]

set_dont_touch [get_ports CLK]
set_ideal_network [get_ports CLK]

set_driving_cell -lib_cell INVD1 -pin OUT [all_inputs]
#set_max_delay 2 -from [all_inputs]
#set_min_delay 1.5 -from [all_inputs]
#set_false_path -from [get_ports address*]
#...............define generated clock


create_clock -name "CLK" -period $clk_period -waveform "0 $half_clk_period" [get_ports CLK]
#set_min_delay -from reset_sync_reg/Q 0.1
#set_max_delay -from reset_sync_reg/Q 5

#.............delay and drive strength on input ports.............
set_input_delay -max $half_clk_period -clock CLK  [all_inputs]
set_input_delay -min $min_clk_period -clock CLK  [all_inputs]

set_output_delay -max $half_clk_period -clock CLK [all_outputs]
set_output_delay -min $min_clk_period -clock CLK [all_outputs]
  
#set_false_path -setup -from $all_input_but_clock
#set_false_path -setup -to [all_outputs]

#...............describe environment...............................
#set_operating_conditions -min best -max worst

set_operating_conditions $library_name -library $library_name
#set_wire_load_model -name  ZeroWireload

#................DRC max_capacitance.............................
set_load [load_of $library_name/INVD1/IN] [all_outputs]
remove_unconnected_ports [get_cells -hier *]  -blast_buses
check_timing > $work_path/$project_name/log/check_timing.log
check_design > "$work_path/$project_name/log/check_design.log"
set_max_area 0
#set_fix_hold [all_clocks]
set verilogout_show_unconnected_pins true

set verilogout_no_tri true 
set_fix_multiple_port_nets -all -buffer_constants
set_svf   ${cell_name}_testfile.svf

