#source ./scripts/power_domain.upf
#set_ungroup [get_designs L1_accs] false
#set_ungroup [get_designs L1_cores] false
compile_ultra
#compile_ultra -area_high_effort_script 
#compile
set myargc 1
set myargv 01_original
source -echo $work_path/$project_name/scripts/report_design.tcl
