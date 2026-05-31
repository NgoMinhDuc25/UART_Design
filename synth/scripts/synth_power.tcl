#### Template Script for RTL->Gate-Level Flow (generated from GENUS 16.13-s031_1) 

::legacy::set_attribute common_ui false     ;#run Genus in Legacy UI if Genus is invoked with Common UI
                                             #In this course we always use modern Genus mode (non-legacy)
                                             #Legacy mode = for old customer scripts.
                                             #Modern mode = for new flows and better optimization.
if {[file exists /proc/cpuinfo]} {
  sh grep "model name" /proc/cpuinfo
  sh grep "cpu MHz"    /proc/cpuinfo
}

puts "Hostname : [info hostname]"


##############################################################################
## Preset global variables and attributes
##############################################################################

setDesignMode -process 130
set DESIGN "uart_top"
set GEN_EFF medium
set MAP_OPT_EFF high

set post_fix "ppa_opt"
set _OUTPUTS_PATH "./outputs_${post_fix}"
set _REPORTS_PATH "./reports_${post_fix}"
set _LOG_PATH     "./logs_${post_fix}"

foreach dir {_OUTPUTS_PATH _REPORTS_PATH _LOG_PATH} {
    if {![file exists [set $dir]]} {
        file mkdir [set $dir]
        puts "Creating directory [set $dir]"
    }
}

set_attribute init_lib_search_path {. ../sky130_scl_9T_0.1.2/sky130_scl_9T/lib/ }
set_attribute script_search_path {. ./scripts/ } 
set_attribute init_hdl_search_path {. ../rtl/ } 

##set_attribute wireload_mode <value> 
set_attribute information_level 7 

set_attr auto_ungroup none 
#set_attr auto_ungroup both 

###############################################################
## Library setup
###############################################################


create_library_domain { slow }
create_library_domain { fast }
create_library_domain { typ }

# slow
set_attribute library {                   \
        ../sky130_scl_9T_0.1.2/sky130_scl_9T_LP/lib/sky130_ss_1.62_125_nldm.lib \
        ../sky130_scl_9T_0.1.2/sky130_scl_9T/lib/sky130_ss_1.62_125_nldm_dontFalse.lib \
        ../sky130_scl_9T_0.1.2/sky130_scl_9T_HS/lib/sky130_ss_1.62_125_nldm.lib \
	} [find /libraries -library_domain slow]

# typ
set_attribute library {                   \
        ../sky130_scl_9T_0.1.2/sky130_scl_9T_LP/lib/sky130_tt_1.8_25_nldm.lib \
        ../sky130_scl_9T_0.1.2/sky130_scl_9T/lib/sky130_tt_1.8_25_nldm_dontFalse.lib \
        ../sky130_scl_9T_0.1.2/sky130_scl_9T_HS/lib/sky130_tt_1.8_25_nldm.lib \
	} [find /libraries -library_domain typ]

# fast
set_attribute library {                   \
        ../sky130_scl_9T_0.1.2/sky130_scl_9T_LP/lib/sky130_ff_1.98_0_nldm.lib \
        ../sky130_scl_9T_0.1.2/sky130_scl_9T/lib/sky130_ff_1.98_0_nldm_dontFalse.lib \
        ../sky130_scl_9T_0.1.2/sky130_scl_9T_HS/lib/sky130_ff_1.98_0_nldm.lib \
        } [find /libraries -library_domain fast] 

set_attribute power_library [find /libraries -library_domain fast] [find /libraries -library_domain typ]
set_attribute default true [find /libraries -library_domain slow]

# LEF
set_attribute lef_library { 
        ../sky130_scl_9T_0.1.2/sky130_scl_9T_tech/lef/sky130_scl_9T.tlef \
        ../sky130_scl_9T_0.1.2/sky130_scl_9T_tech/lef/sky130_scl_9T_phyCells.lef \
        ../sky130_scl_9T_0.1.2/sky130_scl_9T_LP/lef/sky130_scl_9T_LP.lef \
        ../sky130_scl_9T_0.1.2/sky130_scl_9T/lef/sky130_scl_9T.lef \
        ../sky130_scl_9T_0.1.2/sky130_scl_9T_HS/lef/sky130_scl_9T_HS.lef \
}

set_attribute qrc_tech_file ../sky130_scl_9T_0.1.2/sky130_scl_9T/pgv/tech_pgv/techonly.cl/qrcTechFile_RCgen 
set_attribute hdl_array_naming_style %s\[%d\] 
set_attribute hdl_track_filename_row_col true
# For power optimization
set_attribute lp_insert_clock_gating true 
set_attribute lp_insert_discrete_clock_gating_logic true
set_attribute lp_clock_gating_prefix "pow_opt" 
set_attribute hdl_track_filename_row_col true
set_attribute design_power_effort high
####################################################################
## Load Design
## if you un-comment the UPSKILL = 1 then it will use hard macro
####################################################################

read_hdl bau_gen.sv
read_hdl {  FIFO.sv \
            rx.sv \
            uart_rx_module.sv \
            uart_tx_module.sv \
            FIFO_Memory.sv \
            FIFO_State.sv \
            FIFO_Write_Pointer.sv \
            tx.sv \
            uart_top.sv \
        }
elaborate $DESIGN
#set_dont_touch [get_cells -hier "*set_dont_touch_*"]

puts "Runtime & Memory after 'read_hdl'"
time_info Elaboration

####################################################################
## Constraints Setup
####################################################################

read_sdc ./constraint.sdc 

#set_attribute force_wireload <wireload name> "/designs/$DESIGN" 
report timing -lint

####################################################################################################
## Synthesizing to generic 
####################################################################################################
set_attribute syn_generic_effort $GEN_EFF 
syn_generic
puts "Runtime & Memory after 'syn_generic'"
time_info GENERIC
write_snapshot -outdir $_REPORTS_PATH -tag generic
report datapath > $_REPORTS_PATH/generic/${DESIGN}_datapath.rpt
report_summary -outdir $_REPORTS_PATH

####################################################################################################
## Synthesizing to gates
####################################################################################################

set_attribute syn_map_effort $MAP_OPT_EFF 
syn_map
puts "Runtime & Memory after 'syn_map'"
time_info MAPPED
write_snapshot -outdir $_REPORTS_PATH -tag map
report_summary -outdir $_REPORTS_PATH
report datapath > $_REPORTS_PATH/map/${DESIGN}_datapath.rpt

##Intermediate netlist for LEC verification..
set_attribute syn_opt_effort $MAP_OPT_EFF 
syn_opt
write_snapshot -outdir $_REPORTS_PATH -tag syn_opt
report_summary -outdir $_REPORTS_PATH

puts "Runtime & Memory after 'syn_opt'"
time_info OPT

write_snapshot -outdir $_REPORTS_PATH -tag final
report_summary -outdir $_REPORTS_PATH
report_timing   >      $_REPORTS_PATH/timing.rpt
write_hdl    > ${_OUTPUTS_PATH}/${DESIGN}.vg
write_sdc    > ${_OUTPUTS_PATH}/${DESIGN}.sdc

write_db -design $DESIGN -common ${_OUTPUTS_PATH}/${DESIGN}_innovus

puts "Final Runtime & Memory."
time_info FINAL
puts "============================"
puts "Synthesis Finished ........."
puts "============================"
exit
