## Read in design ##
set hdlin_auto_save_templates true
set verilog_top "half_adder"
read_verilog { /data/zhengyj/OTFT_stdlib/OTFT_stdlib_DC/src/half_adder.v }
set active_design $verilog_top
set result_name $verilog_top
current_design $active_design
link
current_design $active_design
uniquify
check_design > log/check_design.log
