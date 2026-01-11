setPinAssignMode -pinEditInBatch true

editPin -pin in1 -assign [list 600 $core_height] -layer M1 -snap USERGRID
editPin -pin in2 -assign [list 850 $core_height] -layer M1 -snap USERGRID
editPin -pin cin -assign [list 1100 $core_height] -layer M1 -snap USERGRID

editPin -pin sum -assign [list 1600 $core_height] -layer M1 -snap USERGRID
editPin -pin cout -assign [list 2100 $core_height] -layer M1 -snap USERGRID

editPin -pin reset -assign [list  0 500] -layer M1 -snap USERGRID
editPin -pin CLK -assign [list  1450 0] -layer M1 -snap USERGRID

setPinAssignMode -pinEditInBatch false



