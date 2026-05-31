################################################################################
#
# Genus(TM) Synthesis Solution setup file
# Created by Genus(TM) Synthesis Solution 23.10-p004_1
#   on 05/13/2026 17:15:24
#
#
################################################################################


# This script is intended for use with Genus(TM) Synthesis Solution version 23.10-p004_1


# To allow user-readonly attributes
################################################################################
::legacy::set_attribute -quiet force_tui_is_remote 1 /


# Libraries
################################################################################
create_library_domain {slow fast typ}
::legacy::set_attribute library {/home/ngominhduc/Documents/VKU_Project/UART_Design/synth/../sky130_scl_9T_0.1.2/sky130_scl_9T_LP/lib/sky130_ss_1.62_125_nldm.lib /home/ngominhduc/Documents/VKU_Project/UART_Design/synth/../sky130_scl_9T_0.1.2/sky130_scl_9T/lib/sky130_ss_1.62_125_nldm_dontFalse.lib /home/ngominhduc/Documents/VKU_Project/UART_Design/synth/../sky130_scl_9T_0.1.2/sky130_scl_9T_HS/lib/sky130_ss_1.62_125_nldm.lib} slow
::legacy::set_attribute library {/home/ngominhduc/Documents/VKU_Project/UART_Design/synth/../sky130_scl_9T_0.1.2/sky130_scl_9T_LP/lib/sky130_ff_1.98_0_nldm.lib /home/ngominhduc/Documents/VKU_Project/UART_Design/synth/../sky130_scl_9T_0.1.2/sky130_scl_9T/lib/sky130_ff_1.98_0_nldm_dontFalse.lib /home/ngominhduc/Documents/VKU_Project/UART_Design/synth/../sky130_scl_9T_0.1.2/sky130_scl_9T_HS/lib/sky130_ff_1.98_0_nldm.lib} fast
::legacy::set_attribute library {/home/ngominhduc/Documents/VKU_Project/UART_Design/synth/../sky130_scl_9T_0.1.2/sky130_scl_9T_LP/lib/sky130_tt_1.8_25_nldm.lib /home/ngominhduc/Documents/VKU_Project/UART_Design/synth/../sky130_scl_9T_0.1.2/sky130_scl_9T/lib/sky130_tt_1.8_25_nldm_dontFalse.lib /home/ngominhduc/Documents/VKU_Project/UART_Design/synth/../sky130_scl_9T_0.1.2/sky130_scl_9T_HS/lib/sky130_tt_1.8_25_nldm.lib} typ
::legacy::set_attribute -quiet default true slow
::legacy::set_attribute -quiet wireload_selection none slow
::legacy::set_attribute -quiet wireload_selection none fast
::legacy::set_attribute -quiet wireload_selection none typ
::legacy::set_attribute -quiet power_library {/libraries/library_domains/fast} typ

