set project_name "half_adder"
set lib_file_name "OTFT_stdlib_13"
set library_name "OTFT_stdlib"
set work_path "/data/zhengyj/OTFT_stdlib/OTFT_stdlib_DC"

set project_path "$work_path/$project_name/src"
set dc_path "$work_path/$project_name/dc"
lappend search_path "$work_path/$project_name/src" 

set output_dir "$dc_path/netlist"
if {![file exists "$output_dir"]} { file mkdir "$output_dir"}

set stdlib_path "/data/zhengyj/OTFT_stdlib/OTFT_stdlib_lib/$lib_file_name"	
set target_library "$stdlib_path/$lib_file_name.db"
set link_library   "*"
set symbol_library "*"

set verilogout_no_tri true
set verilogout_show_unconnected_pins true
set hdlin_auto_save_templates true
set case_analysis_with_logic_constants true

