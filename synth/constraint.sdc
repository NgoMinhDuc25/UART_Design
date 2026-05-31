# ----------------------------------------------------------------------------
# UART IP Core Design Constraints
# Target: SkyWater 130nm PDK
# ----------------------------------------------------------------------------

# 1. Tạo xung Clock (Giả định 12MHz dựa trên BAUDCOUNT=78)
# Chu kỳ T = 1/12MHz ≈ 83.33ns
create_clock -name sys_clk -period 83.33 [get_ports clk]

# 2. Thiết lập độ bất định của Clock (Clock Uncertainty)
# Bao gồm Jitter và margin cho quá trình tổng hợp (~5-10% chu kỳ)
set_clock_uncertainty 2.0 [get_clocks sys_clk]

# 3. Ràng buộc các tín hiệu đầu vào (Input Delay)
set_input_delay -max 33.0 -clock sys_clk [get_ports {rst_n rx_i rx_read_en tx_wr_en tx_din[*]}]
set_input_delay -min 1.0  -clock sys_clk [get_ports {rst_n rx_i rx_read_en tx_wr_en tx_din[*]}]

# 4. Ràng buộc các tín hiệu đầu ra (Output Delay)
set_output_delay -max 33.0 -clock sys_clk [get_ports {tx_o rx_dout[*] rx_fifo_full rx_fifo_empty tx_fifo_full}]
set_output_delay -min 0.5  -clock sys_clk [get_ports {tx_o rx_dout[*] rx_fifo_full rx_fifo_empty tx_fifo_full}]

# 5. Ràng buộc về vật lý (Driving Cell & Load)
set_driving_cell -lib_cell BUFX2 [get_ports {rx_i rx_read_en tx_wr_en tx_din[*]}]

# Giả lập tải trọng ở đầu ra (ví dụ 10fF)
set_load 0.01 [all_outputs]

# 6. Loại bỏ Reset khỏi phân tích Timing chuyển mạch (False Path)
set_false_path -from [get_ports rst_n]

# 7. Thiết lập giới hạn Transition và Fanout (Tối ưu hóa PPA)
set_max_fanout 20 [current_design]
set_max_transition 1.5 [current_design]
