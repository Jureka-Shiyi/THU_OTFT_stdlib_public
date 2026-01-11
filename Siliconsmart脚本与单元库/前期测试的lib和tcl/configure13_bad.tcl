# OTFT Standard Cell Library
# 12-track standard cell
# NAND, NOR, INV; driving capability 1x, 2x, 4x, 8x
# 2025-12


#################################
# OPERATING CONDITIONS DEFINITION
#################################
#
# define operating conditions of PVT(device process, working voltage, temperature)
#
    create_operating_condition OTFT_stdlib

    # spice models(spectre)
    set_opc_process OTFT_stdlib {
        {.lib "/data/zhengyj/cadence/PDK_OTFT_251202/THU_OTFT.l" ptft_mac}
    }

    add_opc_supplies OTFT_stdlib VDD 40.0
    add_opc_grounds OTFT_stdlib VSS 0.0
    set_opc_temperature OTFT_stdlib 25

    set default_operating_conditions OTFT_stdlib
#

#################################
# GLOBAL CONFIGURATION PARAMETERS
#################################
define_parameters default {
    set_parameter pmos_model_names ptft

    # List of operating conditions as defined by create_operation_condition
    set active_pvts { OTFT_stdlib }

    # If using IBIS, one operating condition must be specified in ibis_typ_pvt
    # set ibis_typ_pvt OTFT_stdlib
    
    # HSPICE
    set simulator hspice
    set simulator_cmd {hspice <input_deck> -o <listing_file>}
    
    # SPECTRE
    # set simulator spectre6
    # set simulator_cmd {spectre <input_deck> -format psfbin -raw <listing_file> >&/dev/null}
    # set simulator_cmd {spectremdl -tab -batch <mdl_file> -design <input_deck> <listing_file> >&/dev/null}
   

    # Default simulator options for Finesim, Hspice, Spectre, Msim, and Eldo
    set simulator_options {
	    "common,hspice: probe=1 runlvl=5 numdgt=7 measdgt=7 acct=1 nopage"	
	    # "common,spectre6: compression=yes step=10ps maxstep=1ns relref=allglobal"
	    # "common,spectre6: method=trap lteratio=4 gmin=1e-18 autostop=0 save=none"
    }

# Constraint settings:
    # independent/dependent/dependent-setup/dependent-hold
    set constraint_mode independent
	
    set smc_constraint_style relative-degradation
    set smc_degrade 0.2 
    set path_constraint_mode off 
	
    # Simulation resolution
    set time_res_high 1e-9
    set time_res_low 1e-9
    
    set nochange_variance [expr $time_res_high * 4.0]
    set nochange_threshold 0.2

    # Controls which supplies are measured for power consumption
    set power_meas_supplies { VDD }

    # list of ground supplies used (required for Functional Recognition)
    set power_meas_grounds { VSS }

	set power_stabilization_threshold 0.15
	set power_stabilization_threshold_absolute 1.5e-11 
	
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

    # LOAD SHARE PARAMETERS
    #  job_scheduler: 'lsf' (Platform), 'grid' (SunGrid), or 'standalone' (local machine)
    set job_scheduler standalone
    set run_list_maxsize 1
    set normal_queue "lsf_queue_name"
    set scheduler_poll_time 10

    set internal_power_calculation include_switching
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
    set prop_delay_current 0.1 
    
    set driver_rise_time 1e-9
    set driver_fall_time 1e-9

    # Number of slew and load indices
    # (when importing with -use_default_slews -use_default_loads)
    set numsteps_slew 7
    set numsteps_load 7
    set constraint_numsteps_slew 3

    # Operating load ranges
    set smallest_load 1e-15
    set largest_load 1e-8
    set explicit_points_load {0.01e-15 0.1e-15 0.5e-15 1.0e-15 2.0e-15 3.0e-15 5.0e-15}

    # Operating slew ranges
    set smallest_slew 1e-9
    set largest_slew 1e-3
    set default_slew 1e-9
    set explicit_points_slew {1e-9 2e-9 3e-9 4e-9 5e-9 7e-9 10e-9}

    set max_tout 1e-7

    # Automatically determine largest_load based on max_tout; off or on
    set autorange_load off

    # Noise of points in for noise height
    set numsteps_height 8

    # Input noise width.
    set numsteps_width 5

    # driver model: pwl, emulated, active, active-waveform, custom
    set driver_mode pwl

    # driver cell name (relevant only when driver_mode is "active")
    set driver pwl
}


#####################################
# LIBERTY MODEL GENERATION PARAMETERS
#####################################
define_parameters liberty_model {
    # Add Liberty header attributes here for use with "model -create_new_model"
    set delay_model "table_lookup"
    set default_fanout_load 1.0
    set default_inout_pin_cap 9999
    set default_input_pin_cap 9999
    set default_output_pin_cap 0.0
    set default_cell_leakage_power 0.0
    set default_leakage_power_density  0.0
    
    set slew_lower_threshold_pct_rise 10.0
    set slew_lower_threshold_pct_fall 10.0
    set slew_upper_threshold_pct_rise 90.0
    set slew_upper_threshold_pct_fall 90.0
    
    set input_threshold_pct_fall 50.0
    set input_threshold_pct_rise 50.0 
    set output_threshold_pct_fall 50.0 
    set output_threshold_pct_rise 50.0
    
    # set slew_derate_from_library 0.5
}


#######################
# VALIDATION PARAMETERS
#######################
