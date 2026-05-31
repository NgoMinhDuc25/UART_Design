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

set _OUTPUTS_PATH ./outputs
set _REPORTS_PATH ./reports
set _LOG_PATH     ./logs

foreach dir {_OUTPUTS_PATH _REPORTS_PATH _LOG_PATH} {
    if {![file exists [set $dir]]} {
        file mkdir [set $dir]
        puts "Creating directory [set $dir]"
    }
}

set_attribute init_lib_search_path {. ../sky130_scl_9T_0.1.2/sky130_scl_9T/lib/ }
set_attribute script_search_path {. ./scripts/ } 
set_attribute init_hdl_search_path {. ../rtl/ } 

##Default undriven/unconnected setting is 'none'.  
##set_attribute hdl_unconnected_input_port_value 0 | 1 | x | none 
##set_attribute hdl_undriven_output_port_value   0 | 1 | x | none 
##set_attribute hdl_undriven_signal_value        0 | 1 | x | none 


##set_attribute wireload_mode <value> 
set_attribute information_level 7 

set_attr auto_ungroup none 
#set_attr auto_ungroup both 

###############################################################
## Library setup
###############################################################


create_library_domain { slow }

# slow
set_attribute library {                   \
        ../libraries/lib/max/slow.lib     \
        ../libraries/lib/max/pdkIO.lib    \
	} [find /libraries -library_domain slow]
# fast
set_attribute library {                   \
        ../libraries/lib/max/fast.lib     \
        ../libraries/lib/max/pdkIO.lib    \
        } [find /libraries -library_domain fast] 

set_attribute power_library [find /libraries -library_domain fast] [find /libraries -library_domain slow]
set_attribute default true [find /libraries -library_domain slow]

# LEF
set_attribute lef_library { 
        ../libraries/tech/lef/gsclib045_tech.lef
        ../libraries/tech/qrc/qx/gpdk045.tch
        ../libraries/lef/gsclib045.fixed.lef
	../libraries/lef/pdkIO.lef 
}

###set_attribute cap_table_file ../libraries/TECH/CAPTABLE/cln28hpl_1p10m+alrdl_5x2yu2yz_typical.capTbl 
#set_attribute qrc_tech_file ../libraries/tech/qrc/qx/gpdk045.tch 
set_attribute qrc_tech_file ../libraries/tech/qrc/qx/gpdk045.tch 


set_attribute hdl_array_naming_style %s\[%d\] 

set_attribute use_scan_seqs_for_non_dft false 

set_attribute lp_insert_clock_gating true 

####################################################################
## Load Design
## if you un-comment the UPSKILL = 1 then it will use hard macro
####################################################################

#set hdl_verilog_defines {UPSKILL = 1}
read_hdl "cpu_config.vh top.v io_wrapper.v  cpu.v alu.v datapath.v fsm.v ram.v synthesize_ram.v "
elaborate $DESIGN
#set_dont_touch [get_cells -hier "*set_dont_touch_*"]

puts "Runtime & Memory after 'read_hdl'"
time_info Elaboration

change_names -verilog -log_change ${_LOG_PATH}/change_names.log
change_names -net -inst -port_bus -subport_bus -subdesign -force -restricted {[ ]}   -replace_str "x" -log_change ${_LOG_PATH}/change_names.log -append_log
change_names -net -inst -port_bus -subport_bus -subdesign -force -restricted "\[ \]" -replace_str "x" -log_change ${_LOG_PATH}/change_names.log -append_log
change_names -net -inst -port_bus -subport_bus -subdesign -force -restricted "/"     -replace_str "x" -log_change ${_LOG_PATH}/change_names.log -append_log
change_names -net -inst -port_bus -subport_bus -subdesign -force -restricted "."     -replace_str "x" -log_change ${_LOG_PATH}/change_names.log -append_log
change_names -net -inst -port_bus -subport_bus -subdesign -force -last_restricted "_" -log_change ${_LOG_PATH}/change_names.log -append_log

check_design -unresolved

####################################################################
## Constraints Setup
####################################################################

read_sdc ../rtl/cpu_16bit/top.sdc
puts "The number of exceptions is [llength [find /designs/$DESIGN -exception *]]"



#set_attribute force_wireload <wireload name> "/designs/$DESIGN" 
report timing -lint

set_attribute ungroup_ok false [find / -subdesign *mul* ]
set_attribute ungroup_ok false [find / -subdesign *add* ]
set_attribute ungroup_ok false [find / -subdesign *div* ]
set_attribute ungroup_ok false [find / -subdesign *shift* ]

set_attribute boundary_opto false [find / -subdesign *mul* ]
set_attribute boundary_opto false [find / -subdesign *add* ]
set_attribute boundary_opto false [find / -subdesign *div* ]
set_attribute boundary_opto false [find / -subdesign *shift* ]

#edit_netlist ungroup [get_cells DP/MDR_reg]


#### To turn off sequential merging on the design 
#### uncomment & use the following attributes.
##set_attribute optimize_merge_flops false 
##set_attribute optimize_merge_latches false 
#### For a particular instance use attribute 'optimize_merge_seqs' to turn off sequential merging. 



####################################################################################################
## Synthesizing to generic 
####################################################################################################

set_attribute syn_generic_effort $GEN_EFF 
set_dont_touch [get_cells -hier "*set_dont_touch_*"]
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

#write_design -basename ${_OUTPUTS_PATH}/${DESIGN}_innovus -innovus
write_db -design $DESIGN -common ${_OUTPUTS_PATH}/${DESIGN}_innovus

puts "Final Runtime & Memory."
time_info FINAL
puts "============================"
puts "Synthesis Finished ........."
puts "============================"
exit
