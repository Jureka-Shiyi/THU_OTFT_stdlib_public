# ============================================================
# OTFT Standard Cell Library - Optimized for Slow Devices (1kHz)
# 2025-12
# ============================================================

#################################
# OPERATING CONDITIONS DEFINITION
#################################
create_operating_condition OTFT_stdlib

set_opc_process OTFT_stdlib {
    {.lib "/data/zhengyj/cadence/PDK_OTFT_251202/THU_OTFT.l" ptft_mac}
}

add_opc_supplies OTFT_stdlib VDD 40.0
add_opc_grounds OTFT_stdlib VSS 0.0
set_opc_temperature OTFT_stdlib 25
set default_operating_conditions OTFT_stdlib

#################################
# GLOBAL CONFIGURATION PARAMETERS
#################################
define_parameters default {
    set_parameter pmos_model_names ptft
    set active_pvts { OTFT_stdlib }
    

    set simulator hspice
    set simulator_cmd {hspice <input_deck> -o <listing_file>}
    
    set simulator_options {
        "common,hspice: probe=1 runlvl=5 numdgt=7 measdgt=7 acct=1 nopage"    
    }

    set constraint_mode independent
    set smc_constraint_style relative-degradation
    set smc_degrade 0.2 
    set path_constraint_mode off 


    set time_res_high 1e-7
    set time_res_low 1e-7
    set nochange_variance [expr $time_res_high * 100.0]
    set nochange_threshold 0.1

    set sim_time_limit 1e-2;          
    set simulation_window 5;          

    set power_meas_supplies { VDD }
    set power_meas_grounds { VSS }
    set power_stabilization_threshold 0.15
    set power_stabilization_threshold_absolute 1e-6 
    
    set model_negative_constraints true 
    set model_negative_delays true 
    set model_significant_digits 4

    set liberty_cap_unit "1pf"
    set Liberty_time_unit "1ns"
    set liberty_increasing_delay_with_load off 
	set liberty_increasing_delay_with_slew off 
	set liberty_flavor "2010.03"
	set liberty_max_capacitance 0 
	set liberty_max_transition 0
    set liberty_leakage_power_unit "1mW"
    set model_mpw_attribute false
    # specifies which multi-rail format to be used in Liberty model; none, v1, or v2.
    set liberty_multi_rail_format none
    set run_list_maxsize 1  
    set internal_power_calculation include_switching
    set job_scheduler standalone

    set sim_time_limit 5.0e-3; 
}


############################
# DEFAULT PINTYPE PARAMETERS
############################
pintype default {
    set logic_high_name VDD
    set logic_high_threshold 0.7
    set logic_low_name VSS
    set logic_low_threshold 0.3
    set prop_delay_level 0.5

    set driver_rise_time 1e-6;
    set driver_fall_time 1e-6; 
    set numsteps_slew 7
    set numsteps_load 7

    set smallest_load 1e-15
    set largest_load 50e-12;   
    set explicit_points_load {1.0e-13 1.0e-12 5.0e-12 1.0e-11 2.0e-11 3.0e-11 5.0e-11}

    set smallest_slew 1e-6;    
    set largest_slew 1e-3;     
    set default_slew 1e-4;     
    set explicit_points_slew {1e-6 1e-5 5e-5 1e-4 3e-4 6e-4 1e-3}

    set max_tout 1e-3;         
    set autorange_load off
}

#####################################
# LIBERTY MODEL GENERATION PARAMETERS
#####################################
define_parameters liberty_model {
    set delay_model "table_lookup"
    set slew_lower_threshold_pct_rise 10.0
    set slew_lower_threshold_pct_fall 10.0
    set slew_upper_threshold_pct_rise 90.0
    set slew_upper_threshold_pct_fall 90.0
    set input_threshold_pct_fall 50.0
    set input_threshold_pct_rise 50.0 
    set output_threshold_pct_fall 50.0 
    set output_threshold_pct_rise 50.0
}