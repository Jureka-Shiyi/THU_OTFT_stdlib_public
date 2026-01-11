## VARIABLES/INPUTS
set designName full_adder
set syn_netlist "./innovus/${designName}/netlist/${designName}.v"
set lef_file [glob ./LTPS_TFT_stdlib_lib/LTPS_TFT_stdlib.tlef ./LTPS_TFT_stdlib_lib/LTPS_TFT_stdlib.lef ]

set mmmc_file "./innovus/${designName}/netlist/${designName}.view"
#set IO_file "netlist/${designName}.io"

## Loading design
set init_verilog $syn_netlist
set init_design_settop 1
set init_top_cell $designName
set init_lef_file $lef_file
set init_mmmc_file $mmmc_file
#set init_io_file $IO_file
set init_pwr_net VDD
set init_gnd_net VSS
setGenerateViaMode -auto true
init_design

#floorplan
set core_width 6000
set core_height 1000
set boundary_x 20
set boundary_y 20
floorPlan -site core -s $core_width $core_height $boundary_x $boundary_x $boundary_y $boundary_y

# add pin
source "./innovus/${designName}/scripts/pin.tcl"

saveDesign "./innovus/${designName}/saved/floorplan.enc"

setDesignMode -process 250
setPlaceMode -place_detail_legalization_inst_gap 2
globalNetConnect VDD -type pgpin -pin VDD -instanceBasename * -hierarchicalInstance {} -override -verbose
globalNetConnect VSS -type pgpin -pin VSS -instanceBasename * -hierarchicalInstance {} -override -verbose
globalNetConnect VDD -type tiehi -instanceBasename * -hierarchicalInstance {}
globalNetConnect VSS -type tielo -instanceBasename * -hierarchicalInstance {}


verifyConnectivity -noAntenna -noSoftPGConnect -noUnroutedNet -net VDD
verifyConnectivity -noAntenna -noSoftPGConnect -noUnroutedNet -net VSS
verify_PG_short -no_routing_blkg
verify_drc
