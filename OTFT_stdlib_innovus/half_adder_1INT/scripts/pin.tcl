setPinAssignMode -pinEditInBatch true

# top-side input pins
set in1_x  [expr 600.0  * $core_width  / 6000.0]
set in1_y  [expr 2200.0 * $core_height / 2200.0]

set in2_x  [expr 850.0  * $core_width  / 6000.0]
set in2_y  [expr 2200.0 * $core_height / 2200.0]

# set cin_x  [expr 1100.0 * $core_width  / 6000.0]
# set cin_y  [expr 2200.0 * $core_height / 2200.0]

# top-side output pins
set sum_x  [expr 1600.0 * $core_width  / 6000.0]
set sum_y  [expr 2200.0 * $core_height / 2200.0]

set cout_x [expr 2100.0 * $core_width  / 6000.0]
set cout_y [expr 2200.0 * $core_height / 2200.0]

# left-side reset pin
set reset_x [expr 0.0    * $core_width  / 6000.0]
set reset_y [expr 500.0  * $core_height / 2200.0]

# bottom-side clock pin
set clk_x   [expr 1450.0 * $core_width  / 6000.0]
set clk_y   [expr 0.0    * $core_height / 2200.0]

editPin -pin in1   -assign [list $in1_x   $in1_y]   -layer M1 -snap USERGRID
editPin -pin in2   -assign [list $in2_x   $in2_y]   -layer M1 -snap USERGRID
# editPin -pin cin   -assign [list $cin_x   $cin_y]   -layer M1 -snap USERGRID

editPin -pin sum   -assign [list $sum_x   $sum_y]   -layer M1 -snap USERGRID
editPin -pin cout  -assign [list $cout_x  $cout_y]  -layer M1 -snap USERGRID

editPin -pin reset -assign [list $reset_x $reset_y] -layer M1 -snap USERGRID
editPin -pin CLK   -assign [list $clk_x   $clk_y]   -layer M1 -snap USERGRID

setPinAssignMode -pinEditInBatch false

