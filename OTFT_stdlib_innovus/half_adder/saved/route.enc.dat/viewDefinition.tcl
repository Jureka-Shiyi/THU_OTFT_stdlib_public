if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name tt\
   -timing\
    [list ${::IMEX::libVar}/mmmc/OTFT_stdlib_16.lib]
create_rc_corner -name typical\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0\
   -T 25
create_delay_corner -name typical\
   -library_set tt\
   -rc_corner typical
create_constraint_mode -name function\
   -sdc_files\
    [list ${::IMEX::dataVar}/mmmc/modes/function/function.sdc]
create_analysis_view -name func_typical -constraint_mode function -delay_corner typical -latency_file ${::IMEX::dataVar}/mmmc/views/func_typical/latency.sdc
set_analysis_view -setup [list func_typical] -hold [list func_typical]
