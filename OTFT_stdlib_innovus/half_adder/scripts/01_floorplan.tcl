## VARIABLES/INPUTS
set scripts_dir [file dirname [info script]]
# set scripts_dir "/data/zhengyj/OTFT_stdlib/OTFT_stdlib_innovus/half_adder/scripts"   
set work_dir [file dirname $scripts_dir]
set innovus_dir [file dirname $work_dir]
set saved_dir [file join $work_dir saved]      ;# e.g., .../half_adder/saved
set reports_dir [file join $work_dir reports]  ;# e.g., .../half_adder/reports
set netlist_dir [file join $work_dir netlist]  ;# e.g., .../half_adder/netlist
if {![file exists $saved_dir]} { exec mkdir -p $saved_dir }
if {![file exists $reports_dir]} { exec mkdir -p $reports_dir }
if {![file exists $netlist_dir]} { exec mkdir -p $netlist_dir }

set designName half_adder
set syn_netlist "${netlist_dir}/${designName}.v"
set lib_file_name "OTFT_stdlib_16"
set lef_file_path "/data/zhengyj/OTFT_stdlib/OTFT_stdlib_lib/${lib_file_name}"

set lef_file [list \
    [file join $lef_file_path ${lib_file_name}.tlef] \
    [file join $lef_file_path ${lib_file_name}.lef] \
]
set mmmc_file "${netlist_dir}/${designName}.view"

set init_verilog $syn_netlist
set init_design_settop 1
set init_top_cell $designName
set init_lef_file $lef_file
set init_mmmc_file $mmmc_file
set init_pwr_net VDD
set init_gnd_net VSS
setGenerateViaMode -auto true

init_design
# setDesignMode -process 250
setPlaceMode -place_detail_legalization_inst_gap 2
globalNetConnect VDD -type pgpin -pin VDD -instanceBasename * -hierarchicalInstance {} -override -verbose
globalNetConnect VSS -type pgpin -pin VSS -instanceBasename * -hierarchicalInstance {} -override -verbose
globalNetConnect VDD -type tiehi -instanceBasename * -hierarchicalInstance {}
globalNetConnect VSS -type tielo -instanceBasename * -hierarchicalInstance {}

# floorplan
set core_width  [expr 15 * 900] 
set core_height [expr 9 * 900]
set boundary_x 180
set boundary_y 180
floorPlan -site CoreSite -s $core_width $core_height $boundary_x $boundary_x $boundary_y $boundary_y

# add pin
if {[file exists "$scripts_dir/pin.tcl"]} {
    source "$scripts_dir/pin.tcl"
} else {
    puts "Warning: pin.tcl not found!"
}
saveDesign "${saved_dir}/floorplan.enc"


