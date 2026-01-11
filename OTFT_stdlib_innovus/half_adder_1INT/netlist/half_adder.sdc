###################################################################

# Created by write_sdc on Sat Dec 27 16:11:21 2025

###################################################################
set sdc_version 2.1

set_units -time ns -resistance 1.000000e+04kOhm -capacitance 1.000000e-04pF    \
-voltage V -current uA
set_operating_conditions OTFT_stdlib -library OTFT_stdlib
set_max_area 0
set_driving_cell -lib_cell INVD1 -pin OUT [get_ports CLK]
set_driving_cell -lib_cell INVD1 -pin OUT [get_ports reset]
set_driving_cell -lib_cell INVD1 -pin OUT [get_ports in1]
set_driving_cell -lib_cell INVD1 -pin OUT [get_ports in2]
set_load -pin_load 1.658 [get_ports sum]
set_load -pin_load 1.658 [get_ports cout]
create_clock [get_ports CLK]  -period 2.0e+07  -waveform {0 1.0e+07}
set_input_delay -clock CLK  -max 1.0e+07  [get_ports CLK]
set_input_delay -clock CLK  -min 2.0e+06  [get_ports CLK]
set_input_delay -clock CLK  -max 1.0e+07  [get_ports reset]
set_input_delay -clock CLK  -min 2.0e+06  [get_ports reset]
set_input_delay -clock CLK  -max 1.0e+07  [get_ports in1]
set_input_delay -clock CLK  -min 2.0e+06  [get_ports in1]
set_input_delay -clock CLK  -max 1.0e+07  [get_ports in2]
set_input_delay -clock CLK  -min 2.0e+06  [get_ports in2]
set_output_delay -clock CLK  -max 1.0e+07  [get_ports sum]
set_output_delay -clock CLK  -min 2.0e+06  [get_ports sum]
set_output_delay -clock CLK  -max 1.0e+07  [get_ports cout]
set_output_delay -clock CLK  -min 2.0e+06  [get_ports cout]
