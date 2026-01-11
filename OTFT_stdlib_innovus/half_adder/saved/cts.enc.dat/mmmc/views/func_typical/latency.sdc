set_clock_latency -source -early -max -rise  -2372.58 [get_ports {CLK}] -clock CLK 
set_clock_latency -source -early -max -fall  -12723 [get_ports {CLK}] -clock CLK 
set_clock_latency -source -late -max -rise  -2372.58 [get_ports {CLK}] -clock CLK 
set_clock_latency -source -late -max -fall  -12723 [get_ports {CLK}] -clock CLK 
