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

# set template_lib_path "/data/zhengyj/OTFT_stdlib/lib_template/OTFT_stdlib.lib"

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

    # 2kHz 周期为 0.5ms，建议仿真时长设为 2-3 个周期以确保捕捉到 Setup/Hold 窗口
    # set_config_opt sim_duration 2.5e-3
    # OTFT 的建立时间可能非常大，默认范围可能找不到解
    # set_config_opt bisect_range 1e-3

    set constraint_mode independent
	
    set smc_constraint_style relative-degradation
    set smc_degrade 0.2 
    set path_constraint_mode off 
	
    set time_res_high 1e-6
    set time_res_low 1e-6
    set nochange_variance [expr $time_res_high * 100.0]
    set nochange_threshold 0.2

    # set sim_time_limit 1e-2;          
    # set simulation_window 5;  

    set power_meas_supplies { VDD }
    set power_meas_grounds { VSS }
	set power_stabilization_threshold 0.15
	set power_stabilization_threshold_absolute 1.5e-6 
	
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
	
    set liberty_multi_rail_format none

    set job_scheduler standalone
    set run_list_maxsize 1
    set normal_queue "lsf_queue_name"
    set scheduler_poll_time 30

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
    
    set driver_rise_time 1e-6;
    set driver_fall_time 1e-6; 

    set numsteps_slew 7
    set numsteps_load 7
    set constraint_numsteps_slew 3

    set smallest_load 1e-13
    set largest_load 50e-12;   
    set explicit_points_load {1.0e-13 1.0e-12 5.0e-12 1.0e-11 2.0e-11 3.0e-11 5.0e-11}

    set smallest_slew 10e-12
    set largest_slew 2e-4
    set default_slew 50e-6
    set explicit_points_slew {1e-6 5e-6 10e-6 20e-6 50e-6 100e-6 150e-6}

    set max_tout 5e-4
    set autorange_load off

    set numsteps_height 8
    set numsteps_width 5

    set driver_mode pwl
    set driver pwl
    # 增加最大输出转变量限制，防止因为 OTFT 翻转太慢被工具误判为失败
    # set_config_opt max_transition 5e-4
}


define_parameters liberty_model {

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

}

