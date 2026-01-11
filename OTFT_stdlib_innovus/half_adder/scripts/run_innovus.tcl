# run_dc.tcl
# Top-level script for Design Compiler flow
# set script_dir /data/zhengyj/OTFT_stdlib/OTFT_stdlib_innovus/half_adder/scripts/ [info script]]
set script_dir [file dirname [info script]]
cd $script_dir

puts "===> Step 1: Floorplan"
source $script_dir/01_floorplan.tcl

puts "===> Step 2: Power Grid (PG) Stripes"
source $script_dir/02_pg_stripe.tcl

puts "===> Step 3: Placement"
source $script_dir/03_place.tcl

puts "===> Step 4: Clock Tree Synthesis (CTS)"
source $script_dir/04_cts.tcl

puts "===> Step 5: Routing"
source $script_dir/05_route.tcl

puts "===> Step 6: Save Post-Route Design"
if {![file exists $saved_dir]} { file mkdir $saved_dir }
saveDesign "${saved_dir}/route.enc"

puts "===> Step 7: Post-Route Optimization & Filling"
setMultiCpuUsage -localCpu 16 -cpuPerRemoteHost 1 -remoteHost 0 -keepLicense true
addFiller -cell FILL1 FILL2 FILL4 FILL8 FILL16 FILL32 FILL64 FILL128 -prefix FILLER -doDRC -fitGap

puts "===> Step 8: Final Outputs"
source $script_dir/output.tcl

puts "===> Innovus flow finished successfully"