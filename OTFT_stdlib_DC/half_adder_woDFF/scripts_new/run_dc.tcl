# run_dc.tcl
# Top-level script for Design Compiler flow
# [info script] → Returns the full path of the current script 
# `file dirname <path>` → Extract the directory part of the path
set script_dir [file dirname [info script]]
cd $script_dir

puts "===> Step 1: setup"
source $script_dir/01_setup.tcl

puts "===> Step 2: read design"
source $script_dir/02_read.tcl

puts "===> Step 3: apply constraints"
source $script_dir/03_constraints.tcl

puts "===> Step 4: compile design"
source $script_dir/04_compile_design.tcl

puts "===> DC flow finished successfully"
