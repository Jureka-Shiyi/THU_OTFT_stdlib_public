
set script_dir [file dirname [info script]]
cd $script_dir
# script_dir = "/data/zhengyj/OTFT_stdlib/OTFT_stdlib_innovus/half_adder/scripts"
source "$script_dir/01_floorplan.tcl"
source "$script_dir/02_pg_stripe.tcl"
source "$script_dir/03_place.tcl"
source "$script_dir/04_cts.tcl"
source "$script_dir/05_route.tcl"
saveDesign "${saved_dir}/route.enc"
setMultiCpuUsage -localCpu 16 -cpuPerRemoteHost 1 -remoteHost 0 -keepLicense true
addFiller -cell FILL1 FILL2 FILL4 FILL8 FILL16 FILL32 FILL64 FILL128 -prefix FILLER -doDRC -fitGap
source "${scripts_dir}/output.tcl"

puts "===> innovus flow finished successfully"