## Read in design ##
set hdlin_auto_save_templates true
set verilog_top "$project_name"
read_verilog "$work_path/$project_name/src/$verilog_top.v"
set active_design $verilog_top
set result_name $verilog_top
current_design $active_design
link
current_design $active_design
uniquify
check_design > "$work_path/$project_name/log/check_design.log"
