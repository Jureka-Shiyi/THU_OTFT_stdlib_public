set project_path "/data/zhengyj/OTFT_stdlib/OTFT_stdlib_DC/src"
set dc_path "/data/zhengyj/OTFT_stdlib/OTFT_stdlib_DC/dc"
append search_path "/data/zhengyj/OTFT_stdlib/OTFT_stdlib_DC/src" 

set output_dir "$dc_path/netlist"
if {![file exists "$output_dir"]} { file mkdir "$output_dir"}

set stdlib_path "/data/zhengyj/OTFT_stdlib/OTFT_stdlib_lib/"	
set target_library "$stdlib_path/OTFT_stdlib_12.db"
set link_library   "*"
set symbol_library "*"

set verilogout_no_tri true
set verilogout_show_unconnected_pins true
set hdlin_auto_save_templates true
set case_analysis_with_logic_constants true

