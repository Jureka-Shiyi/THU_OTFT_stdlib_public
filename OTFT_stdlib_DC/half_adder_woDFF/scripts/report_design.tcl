
set output_subdir $output_dir

if {$myargc>0} {
	set subdir_name $myargv
	set output_subdir "$output_dir"
	if {![file exists "$output_subdir"]} { file mkdir "$output_subdir"}
}

#Report Design

#set name rules for output, important when verilog is converted to spice
define_name_rules verilog -case_insensitive
change_names -hierarchy -rules verilog

#write data
write -h -format verilog -output "$output_subdir/$active_design.v" 
#write -pg -h -format verilog -output "$output_subdir/$active_design.v" 
write -format ddc -hierarchy -output "$output_subdir/$active_design.ddc" 
write_sdc "$output_subdir/$active_design.sdc" 
write_sdf "$output_subdir/$active_design.sdf"

#report
redirect -tee "$output_subdir/{$result_name}_area.txt" {report_area -nosplit -hierarchy}
redirect -tee "$output_subdir/{$result_name}_power.txt" {report_power -hier -hier_level 100 -analysis_effort high}
#redirect -append -tee "$output_subdir/Report_power_netcell.txt" {report_power -net -cell -analysis_effort high -sort_mode dynamic_power}

redirect -tee "$output_subdir/{$result_name}_clock.txt" {report_clock -nosplit}
redirect -tee "$output_subdir/{$result_name}_timing.txt" {report_timing -path full -delay max -nworst 1 -max_paths 3 -significant_digits 3 -sort_by group}
# redirect -tee "$output_subdir/{$result_name}_timing.txt" {report_timing -path full -delay min -nworst 1 -max_paths 3 -significant_digits 3 -sort_by group}
