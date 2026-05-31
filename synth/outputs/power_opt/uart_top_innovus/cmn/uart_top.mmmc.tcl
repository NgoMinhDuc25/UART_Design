#################################################################################
#
# Created by Genus(TM) Synthesis Solution 23.10-p004_1 on Wed May 13 16:15:25 +07 2026
#
#################################################################################

## library_sets
create_library_set -name ls_of_ld_slow \
    -timing { /home/ngominhduc/Documents/VKU_Project/UART_Design/sky130_scl_9T_0.1.2/sky130_scl_9T_LP/lib/sky130_ss_1.62_125_nldm.lib }
create_library_set -name ls_of_ld_fast \
    -timing { /home/ngominhduc/Documents/VKU_Project/UART_Design/sky130_scl_9T_0.1.2/sky130_scl_9T_LP/lib/sky130_ff_1.98_0_nldm.lib }
create_library_set -name ls_of_ld_typ \
    -timing { /home/ngominhduc/Documents/VKU_Project/UART_Design/sky130_scl_9T_0.1.2/sky130_scl_9T_LP/lib/sky130_tt_1.8_25_nldm.lib }

## rc_corner
create_rc_corner -name default_emulate_rc_corner \
    -T 125.0 \
    -qx_tech_file /home/ngominhduc/Documents/VKU_Project/UART_Design/sky130_scl_9T_0.1.2/sky130_scl_9T/pgv/tech_pgv/techonly.cl/qrcTechFile_RCgen \
    -preRoute_res 1.0 \
    -preRoute_cap 1.0 \
    -preRoute_clkres 0.0 \
    -preRoute_clkcap 0.0 \
    -postRoute_res {1.0 1.0 1.0} \
    -postRoute_cap {1.0 1.0 1.0} \
    -postRoute_xcap {1.0 1.0 1.0} \
    -postRoute_clkres {1.0 1.0 1.0} \
    -postRoute_clkcap {1.0 1.0 1.0} \
    -postRoute_clkxcap {1.0 1.0 1.0}

## delay_corner
create_delay_corner -name default_emulate_delay_corner \
    -early_library_set { ls_of_ld_slow } \
    -late_library_set { ls_of_ld_slow } \
    -early_rc_corner default_emulate_rc_corner \
    -late_rc_corner default_emulate_rc_corner

## constraint_mode
create_constraint_mode -name default_emulate_constraint_mode \
    -sdc_files { ./outputs/power_opt/uart_top_innovus/cmn/uart_top.mmmc/modes/default_emulate_constraint_mode/default_emulate_constraint_mode.sdc.gz }

## analysis_view
create_analysis_view -name default_emulate_view \
    -constraint_mode default_emulate_constraint_mode \
    -delay_corner default_emulate_delay_corner

## set_analysis_view
set_analysis_view -setup { default_emulate_view } \
                  -hold { default_emulate_view }
