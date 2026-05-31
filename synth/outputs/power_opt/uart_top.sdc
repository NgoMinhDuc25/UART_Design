# ####################################################################

#  Created by Genus(TM) Synthesis Solution 23.10-p004_1 on Wed May 13 16:15:24 +07 2026

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design uart_top

create_clock -name "sys_clk" -period 83.33 -waveform {0.0 41.665} [get_ports clk]
group_path -name cg_enable_group_sys_clk -through [list \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST2/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST3/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST4/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST5/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST6/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST7/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST8/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST9/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST10/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST11/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST12/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST13/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST14/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST15/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST16/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST17/enable]  \
  [get_pins rx_inst/fifo_inst/write_pointer_inst/pow_opt_RC_CG_HIER_INST19/enable]  \
  [get_pins rx_inst/uart_rx_inst/pow_opt_RC_CG_HIER_INST20/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST2/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST3/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST4/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST5/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST6/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST7/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST8/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST9/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST10/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST11/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST12/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST13/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST14/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST15/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST16/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST17/enable]  \
  [get_pins tx_inst/fifo_inst/write_pointer_inst/pow_opt_RC_CG_HIER_INST19/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST2/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST3/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST4/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST5/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST6/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST7/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST8/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST9/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST10/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST11/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST12/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST13/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST14/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST15/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST16/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST17/enable]  \
  [get_pins rx_inst/fifo_inst/write_pointer_inst/pow_opt_RC_CG_HIER_INST19/enable]  \
  [get_pins rx_inst/uart_rx_inst/pow_opt_RC_CG_HIER_INST20/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST2/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST3/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST4/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST5/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST6/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST7/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST8/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST9/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST10/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST11/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST12/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST13/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST14/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST15/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST16/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST17/enable]  \
  [get_pins tx_inst/fifo_inst/write_pointer_inst/pow_opt_RC_CG_HIER_INST19/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST2/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST3/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST4/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST5/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST6/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST7/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST8/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST9/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST10/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST11/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST12/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST13/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST14/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST15/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST16/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST17/enable]  \
  [get_pins rx_inst/fifo_inst/write_pointer_inst/pow_opt_RC_CG_HIER_INST19/enable]  \
  [get_pins rx_inst/uart_rx_inst/pow_opt_RC_CG_HIER_INST20/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST2/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST3/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST4/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST5/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST6/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST7/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST8/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST9/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST10/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST11/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST12/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST13/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST14/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST15/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST16/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST17/enable]  \
  [get_pins tx_inst/fifo_inst/write_pointer_inst/pow_opt_RC_CG_HIER_INST19/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST2/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST3/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST4/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST5/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST6/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST7/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST8/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST9/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST10/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST11/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST12/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST13/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST14/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST15/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST16/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST17/enable]  \
  [get_pins rx_inst/fifo_inst/write_pointer_inst/pow_opt_RC_CG_HIER_INST19/enable]  \
  [get_pins rx_inst/uart_rx_inst/pow_opt_RC_CG_HIER_INST20/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST2/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST3/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST4/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST5/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST6/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST7/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST8/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST9/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST10/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST11/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST12/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST13/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST14/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST15/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST16/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST17/enable]  \
  [get_pins tx_inst/fifo_inst/write_pointer_inst/pow_opt_RC_CG_HIER_INST19/enable]  \
  [get_pins rx_inst/fifo_inst/pow_opt_RC_CG_DECLONE_HIER_INST/enable]  \
  [get_pins rx_inst/fifo_inst/pow_opt_RC_CG_DECLONE_HIER_INST/enable]  \
  [get_pins rx_inst/fifo_inst/pow_opt_RC_CG_DECLONE_HIER_INST/enable]  \
  [get_pins rx_inst/fifo_inst/pow_opt_RC_CG_DECLONE_HIER_INST/enable]  \
  [get_pins tx_inst/fifo_inst/pow_opt_RC_CG_DECLONE_HIER_INST/enable]  \
  [get_pins tx_inst/fifo_inst/pow_opt_RC_CG_DECLONE_HIER_INST/enable]  \
  [get_pins tx_inst/fifo_inst/pow_opt_RC_CG_DECLONE_HIER_INST/enable]  \
  [get_pins tx_inst/fifo_inst/pow_opt_RC_CG_DECLONE_HIER_INST/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST2/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST3/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST4/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST5/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST6/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST7/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST8/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST9/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST10/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST11/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST12/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST13/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST14/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST15/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST16/enable]  \
  [get_pins rx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST17/enable]  \
  [get_pins rx_inst/fifo_inst/write_pointer_inst/pow_opt_RC_CG_HIER_INST19/enable]  \
  [get_pins rx_inst/fifo_inst/pow_opt_RC_CG_DECLONE_HIER_INST/enable]  \
  [get_pins rx_inst/uart_rx_inst/pow_opt_RC_CG_HIER_INST20/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST2/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST3/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST4/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST5/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST6/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST7/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST8/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST9/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST10/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST11/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST12/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST13/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST14/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST15/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST16/enable]  \
  [get_pins tx_inst/fifo_inst/memory_inst/pow_opt_RC_CG_HIER_INST17/enable]  \
  [get_pins tx_inst/fifo_inst/write_pointer_inst/pow_opt_RC_CG_HIER_INST19/enable]  \
  [get_pins tx_inst/fifo_inst/pow_opt_RC_CG_DECLONE_HIER_INST/enable] ]
set_load -pin_load 0.01 [get_ports tx_o]
set_load -pin_load 0.01 [get_ports {rx_dout[7]}]
set_load -pin_load 0.01 [get_ports {rx_dout[6]}]
set_load -pin_load 0.01 [get_ports {rx_dout[5]}]
set_load -pin_load 0.01 [get_ports {rx_dout[4]}]
set_load -pin_load 0.01 [get_ports {rx_dout[3]}]
set_load -pin_load 0.01 [get_ports {rx_dout[2]}]
set_load -pin_load 0.01 [get_ports {rx_dout[1]}]
set_load -pin_load 0.01 [get_ports {rx_dout[0]}]
set_load -pin_load 0.01 [get_ports rx_fifo_full]
set_load -pin_load 0.01 [get_ports rx_fifo_empty]
set_load -pin_load 0.01 [get_ports tx_fifo_full]
set_false_path -from [get_ports rst_n]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks sys_clk] -add_delay -max 33.0 [get_ports rst_n]
set_input_delay -clock [get_clocks sys_clk] -add_delay -max 33.0 [get_ports rx_i]
set_input_delay -clock [get_clocks sys_clk] -add_delay -max 33.0 [get_ports rx_read_en]
set_input_delay -clock [get_clocks sys_clk] -add_delay -max 33.0 [get_ports tx_wr_en]
set_input_delay -clock [get_clocks sys_clk] -add_delay -max 33.0 [get_ports {tx_din[7]}]
set_input_delay -clock [get_clocks sys_clk] -add_delay -max 33.0 [get_ports {tx_din[6]}]
set_input_delay -clock [get_clocks sys_clk] -add_delay -max 33.0 [get_ports {tx_din[5]}]
set_input_delay -clock [get_clocks sys_clk] -add_delay -max 33.0 [get_ports {tx_din[4]}]
set_input_delay -clock [get_clocks sys_clk] -add_delay -max 33.0 [get_ports {tx_din[3]}]
set_input_delay -clock [get_clocks sys_clk] -add_delay -max 33.0 [get_ports {tx_din[2]}]
set_input_delay -clock [get_clocks sys_clk] -add_delay -max 33.0 [get_ports {tx_din[1]}]
set_input_delay -clock [get_clocks sys_clk] -add_delay -max 33.0 [get_ports {tx_din[0]}]
set_input_delay -clock [get_clocks sys_clk] -add_delay -min 1.0 [get_ports rst_n]
set_input_delay -clock [get_clocks sys_clk] -add_delay -min 1.0 [get_ports rx_i]
set_input_delay -clock [get_clocks sys_clk] -add_delay -min 1.0 [get_ports rx_read_en]
set_input_delay -clock [get_clocks sys_clk] -add_delay -min 1.0 [get_ports tx_wr_en]
set_input_delay -clock [get_clocks sys_clk] -add_delay -min 1.0 [get_ports {tx_din[7]}]
set_input_delay -clock [get_clocks sys_clk] -add_delay -min 1.0 [get_ports {tx_din[6]}]
set_input_delay -clock [get_clocks sys_clk] -add_delay -min 1.0 [get_ports {tx_din[5]}]
set_input_delay -clock [get_clocks sys_clk] -add_delay -min 1.0 [get_ports {tx_din[4]}]
set_input_delay -clock [get_clocks sys_clk] -add_delay -min 1.0 [get_ports {tx_din[3]}]
set_input_delay -clock [get_clocks sys_clk] -add_delay -min 1.0 [get_ports {tx_din[2]}]
set_input_delay -clock [get_clocks sys_clk] -add_delay -min 1.0 [get_ports {tx_din[1]}]
set_input_delay -clock [get_clocks sys_clk] -add_delay -min 1.0 [get_ports {tx_din[0]}]
set_output_delay -clock [get_clocks sys_clk] -add_delay -max 33.0 [get_ports tx_o]
set_output_delay -clock [get_clocks sys_clk] -add_delay -max 33.0 [get_ports {rx_dout[7]}]
set_output_delay -clock [get_clocks sys_clk] -add_delay -max 33.0 [get_ports {rx_dout[6]}]
set_output_delay -clock [get_clocks sys_clk] -add_delay -max 33.0 [get_ports {rx_dout[5]}]
set_output_delay -clock [get_clocks sys_clk] -add_delay -max 33.0 [get_ports {rx_dout[4]}]
set_output_delay -clock [get_clocks sys_clk] -add_delay -max 33.0 [get_ports {rx_dout[3]}]
set_output_delay -clock [get_clocks sys_clk] -add_delay -max 33.0 [get_ports {rx_dout[2]}]
set_output_delay -clock [get_clocks sys_clk] -add_delay -max 33.0 [get_ports {rx_dout[1]}]
set_output_delay -clock [get_clocks sys_clk] -add_delay -max 33.0 [get_ports {rx_dout[0]}]
set_output_delay -clock [get_clocks sys_clk] -add_delay -max 33.0 [get_ports rx_fifo_full]
set_output_delay -clock [get_clocks sys_clk] -add_delay -max 33.0 [get_ports rx_fifo_empty]
set_output_delay -clock [get_clocks sys_clk] -add_delay -max 33.0 [get_ports tx_fifo_full]
set_output_delay -clock [get_clocks sys_clk] -add_delay -min 0.5 [get_ports tx_o]
set_output_delay -clock [get_clocks sys_clk] -add_delay -min 0.5 [get_ports {rx_dout[7]}]
set_output_delay -clock [get_clocks sys_clk] -add_delay -min 0.5 [get_ports {rx_dout[6]}]
set_output_delay -clock [get_clocks sys_clk] -add_delay -min 0.5 [get_ports {rx_dout[5]}]
set_output_delay -clock [get_clocks sys_clk] -add_delay -min 0.5 [get_ports {rx_dout[4]}]
set_output_delay -clock [get_clocks sys_clk] -add_delay -min 0.5 [get_ports {rx_dout[3]}]
set_output_delay -clock [get_clocks sys_clk] -add_delay -min 0.5 [get_ports {rx_dout[2]}]
set_output_delay -clock [get_clocks sys_clk] -add_delay -min 0.5 [get_ports {rx_dout[1]}]
set_output_delay -clock [get_clocks sys_clk] -add_delay -min 0.5 [get_ports {rx_dout[0]}]
set_output_delay -clock [get_clocks sys_clk] -add_delay -min 0.5 [get_ports rx_fifo_full]
set_output_delay -clock [get_clocks sys_clk] -add_delay -min 0.5 [get_ports rx_fifo_empty]
set_output_delay -clock [get_clocks sys_clk] -add_delay -min 0.5 [get_ports tx_fifo_full]
set_max_fanout 20.000 [current_design]
set_max_transition 1.5 [current_design]
set_driving_cell -lib_cell BUFX2_LP -library sky130_ss_1.62_125_LP -pin "Y" [get_ports rx_i]
set_driving_cell -lib_cell BUFX2_LP -library sky130_ss_1.62_125_LP -pin "Y" [get_ports rx_read_en]
set_driving_cell -lib_cell BUFX2_LP -library sky130_ss_1.62_125_LP -pin "Y" [get_ports tx_wr_en]
set_driving_cell -lib_cell BUFX2_LP -library sky130_ss_1.62_125_LP -pin "Y" [get_ports {tx_din[7]}]
set_driving_cell -lib_cell BUFX2_LP -library sky130_ss_1.62_125_LP -pin "Y" [get_ports {tx_din[6]}]
set_driving_cell -lib_cell BUFX2_LP -library sky130_ss_1.62_125_LP -pin "Y" [get_ports {tx_din[5]}]
set_driving_cell -lib_cell BUFX2_LP -library sky130_ss_1.62_125_LP -pin "Y" [get_ports {tx_din[4]}]
set_driving_cell -lib_cell BUFX2_LP -library sky130_ss_1.62_125_LP -pin "Y" [get_ports {tx_din[3]}]
set_driving_cell -lib_cell BUFX2_LP -library sky130_ss_1.62_125_LP -pin "Y" [get_ports {tx_din[2]}]
set_driving_cell -lib_cell BUFX2_LP -library sky130_ss_1.62_125_LP -pin "Y" [get_ports {tx_din[1]}]
set_driving_cell -lib_cell BUFX2_LP -library sky130_ss_1.62_125_LP -pin "Y" [get_ports {tx_din[0]}]
set_clock_uncertainty -setup 2.0 [get_clocks sys_clk]
set_clock_uncertainty -hold 2.0 [get_clocks sys_clk]
