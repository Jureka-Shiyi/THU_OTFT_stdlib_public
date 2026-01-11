if { [catch {
set_location /data/zhengyj/OTFT_stdlib/my_library_LTPS
log_info "[clock format [clock seconds]]: Sourcing environment settings"
set t0 [clock seconds]
set sis_log_file "/var/tmp/sis.1040.W$::env(CDPL_WORKERID).[lindex [split [info hostname] '.'] 0].[pid].log"
if { [info exists ::env(SGE_TASK_ID)] } {
  if { $::env(SGE_TASK_ID) != "undefined" } {
    set sis_log_file "/var/tmp/sis.1040.W$::env(SGE_TASK_ID).[lindex [split [info hostname] '.'] 0].[pid].log"
  }
}
set_log_file $sis_log_file
set_log_level info
set_log_stdout_level info
set jobName [lindex $argv 0]

# Parameter block and pintype definitions.  The following definitions
# preserve any (pintype) parameters set outside of the configure.tcl file.
define_parameters default {
    set PLACEHOLDER X
}

define_parameters liberty_model {
    set default_cell_leakage_power 0.0
    set default_fanout_load 1.0
    set default_inout_pin_cap 9999
    set default_input_pin_cap 9999
    set default_leakage_power_density 0.0
    set default_output_pin_cap 0.0
    set delay_model table_lookup
    set input_threshold_pct_fall 50.0
    set input_threshold_pct_rise 50.0
    set output_threshold_pct_fall 50.0
    set output_threshold_pct_rise 50.0
    set slew_lower_threshold_pct_fall 10.0
    set slew_lower_threshold_pct_rise 10.0
    set slew_upper_threshold_pct_fall 90.0
    set slew_upper_threshold_pct_rise 90.0
}

# Liberty attributes set by user
# Liberty groups added by the user
# Liberty attributes cleared by user
# Liberty groups cleared by user

#Operating conditions

create_operating_condition LTPS_TFT_stdlib
add_opc_supplies LTPS_TFT_stdlib VDD 10.0
add_opc_grounds LTPS_TFT_stdlib VSS 0.0

## 
## User-specified characterization and modeling configuration options.
## 

create_parameter cdpl_log_subdir
set_config_opt -- cdpl_log_subdir pid57864

create_parameter combine_timing_and_power
set_config_opt -- combine_timing_and_power 1

create_parameter configure_arc_based
set_config_opt -cell AND2D1 -- configure_arc_based 0
set_config_opt -cell AND2D2 -- configure_arc_based 0
set_config_opt -cell AND2D4 -- configure_arc_based 0
set_config_opt -cell AND2D8 -- configure_arc_based 0
set_config_opt -cell NAND2D1 -- configure_arc_based 0
set_config_opt -cell NAND2D2 -- configure_arc_based 0
set_config_opt -cell NAND2D4 -- configure_arc_based 0
set_config_opt -cell NAND2D8 -- configure_arc_based 0
set_config_opt -cell NOR2D1 -- configure_arc_based 0
set_config_opt -cell NOR2D2 -- configure_arc_based 0
set_config_opt -cell NOR2D4 -- configure_arc_based 0
set_config_opt -cell NOR2D8 -- configure_arc_based 0
set_config_opt -cell OR2D1 -- configure_arc_based 0
set_config_opt -cell OR2D2 -- configure_arc_based 0
set_config_opt -cell OR2D4 -- configure_arc_based 0
set_config_opt -cell OR2D8 -- configure_arc_based 0
set_config_opt -cell XNOR2D1 -- configure_arc_based 0
set_config_opt -cell XNOR2D2 -- configure_arc_based 0
set_config_opt -cell XNOR2D4 -- configure_arc_based 0
set_config_opt -cell XNOR2D8 -- configure_arc_based 0
set_config_opt -cell XOR2D1 -- configure_arc_based 0
set_config_opt -cell XOR2D2 -- configure_arc_based 0
set_config_opt -cell XOR2D4 -- configure_arc_based 0
set_config_opt -cell XOR2D8 -- configure_arc_based 0
set_config_opt -cell BUFD16 -- configure_arc_based 0
set_config_opt -cell BUFD2 -- configure_arc_based 0
set_config_opt -cell BUFD4 -- configure_arc_based 0
set_config_opt -cell BUFD8 -- configure_arc_based 0
set_config_opt -cell INVD1 -- configure_arc_based 0
set_config_opt -cell INVD16 -- configure_arc_based 0
set_config_opt -cell INVD2 -- configure_arc_based 0
set_config_opt -cell INVD4 -- configure_arc_based 0
set_config_opt -cell INVD8 -- configure_arc_based 0

create_parameter configure_disable_asynch_pins_initialization
set_config_opt -- configure_disable_asynch_pins_initialization 0

create_parameter default_combine_timing_and_power
set_config_opt -- default_combine_timing_and_power 1

create_parameter import_sensitization_vector
set_config_opt -- import_sensitization_vector 0

create_parameter insert_liberty_default_ndw
set_config_opt -- insert_liberty_default_ndw 1

create_parameter is_char_mode
set_config_opt -- is_char_mode 1

create_parameter pureRecharFlow
set_config_opt -- pureRecharFlow 0

create_parameter rechar_mode
set_config_opt -- rechar_mode 0

create_parameter seed_simulator_version_info
set_config_opt -- seed_simulator_version_info V-2023.12-SP2-2

create_parameter simulator_version_info
set_config_opt -- simulator_version_info V-2023.12-SP2-2

create_parameter slew_derate_lower_threshold
set_config_opt -- slew_derate_lower_threshold 0.3

create_parameter slew_derate_upper_threshold
set_config_opt -- slew_derate_upper_threshold 0.7

create_parameter source_from_instance
set_config_opt -- source_from_instance {}

log_info "[clock format [clock seconds]]: Environment set up done ([expr [clock seconds] - $t0] seconds)"
} err ] } {

  # Connect back to the server to send err message.
  catch {if {[string length $err] > 0} {log_error $err}}
  if {[catch {
    startCdplWorker $err
  } err]} {exit 2}
  exit 0
}


# Connect back to the server to retrieve the jobs.
if {[catch {
  startCdplWorker "" 
  log_info "CDPL worker exited normally."
  reset_log_file
  if { [log_num_errors] > 0 } {
    if { [catch {exec mv -f $sis_log_file /data/zhengyj/OTFT_stdlib/my_library_LTPS/runtime/cdpl/pid57864} mv_err] } {
      log_warning $mv_err
    }
  } else {
    if { [catch {exec rm -f $sis_log_file} rm_err] } {
      log_warning $rm_err
    }
  }
} err]} {
  catch {if {[string length $err] > 0} {log_error $err}}
  exit 3
}
exit 0
