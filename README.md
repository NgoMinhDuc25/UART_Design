# Thiết kế bộ điều khiển UART với FIFO trên FPGA (SystemVerilog)

![Language](https://img.shields.io/badge/Language-SystemVerilog-blue)
![Platform](https://img.shields.io/badge/Platform-FPGA-green)
![Tool](https://img.shields.io/badge/Tool-Vivado%20%7C%20ModelSim-orange)
![Status](https://img.shields.io/badge/Status-Verified-success)

## 📖 Tổng quan
Dự án này là thiết kế phần cứng cho giao thức **UART (Universal Asynchronous Receiver-Transmitter)** sử dụng ngôn ngữ **SystemVerilog**. Thiết kế tập trung vào độ tin cậy và hiệu năng cao, tích hợp bộ đệm **FIFO (First-In-First-Out)** cho cả luồng truyền (TX) và nhận (RX), giúp hệ thống hoạt động ổn định mà không mất mát dữ liệu ở tốc độ cao.

Giao thức được hiện thực hóa chuẩn **8N1** (1 Start bit, 8 Data bits, No Parity, 1 Stop bit) cùng kỹ thuật **Oversampling 16x** để chống nhiễu tín hiệu đầu vào.

## 🌟 Tính năng nổi bật
* **Tham số hóa toàn diện:** Dễ dàng cấu hình Baud rate, Clock frequency, độ rộng dữ liệu (Data Width) và độ sâu FIFO (FIFO Depth).
* **Cơ chế RX tin cậy:**
    * Sử dụng **16x Oversampling** để lấy mẫu tại điểm giữa của bit (center-aligned sampling).
    * Tích hợp bộ đồng bộ hóa 2 tầng (2-stage synchronizer) để chống hiện tượng **Metastability**.
* **Bộ đệm FIFO tích hợp:** Giúp tách biệt miền thời gian giữa UART core và hệ thống xử lý chính.
* **Giao diện đơn giản:** Sử dụng tín hiệu `wr_en` (Write Enable) và `rd_en` (Read Enable) tiêu chuẩn.

## 🏗️ Kiến trúc phần cứng (Block Diagram)
Sơ đồ khối tổng quát của hệ thống, bao gồm các module chính: Baud Rate Generator, UART TX, UART RX và các khối FIFO.

![Block Diagram](/public/uart_rx.png)
*(Sơ đồ khối hệ thống UART_RX)*

![Block Diagram](/public/uart_tx.png)
*(Sơ đồ khối hệ thống UART_TX)*

## 🔄 Máy trạng thái hữu hạn (FSM Diagram)
Luồng hoạt động của bộ thu (RX) và bộ phát (TX) được điều khiển bởi các máy trạng thái (Finite State Machine) để đảm bảo tuân thủ chặt chẽ timing của giao thức UART.

![FSM Diagram](/public/fsm_rx.png)
![FSM Diagram](/public/fsm_tx.png)

*(Biểu đồ trạng thái FSM cho TX và RX)*

## 🪢 Waveform
![Waveform 1](https://raw.githubusercontent.com/NgoMinhDuc25/UART_Design/refs/heads/main/public/wf_rx%20.png)
- UART_RX
 
![Waveform 2](/public/wf_tx.png)
- UART_TX

## ♾️ Simulation with ModelSim
![Simulation 1](/public/sim_rx_1.png)
- UART_RX
 
![Simulation 2](/public/sim_tx_1.png)
![Simulation 3](/public/sim_tx_2.png)
- UART_TX
  
## 📂 Cấu trúc Repository

```text
├── public/                # Chứa tài liệu hình ảnh (Diagrams, Waveforms)
│   ├── block_diagram.png
│   ├── fsm_diagram.png
│   ├── simulation.png
│   └── waveform.png
├── rtl/                   # Mã nguồn SystemVerilog (Source Code)
│   ├── uart_tx_module.sv  # Top-level TX với FIFO
│   ├── uart_rx_module.sv  # Top-level RX với FIFO
│   ├── tx.sv              # Core xử lý phát (TX Core)
│   ├── rx.sv              # Core xử lý thu (RX Core)
│   ├── bau_gen.sv         # Bộ tạo tốc độ Baud
│   ├── FIFO.sv            # Wrapper cho FIFO
│   └── ... (Các file con của FIFO)
├── tb/                    # Testbenches
│   ├── tb_uart_tx_module.sv
│   └── tb_uart_rx_module.sv
└── README.md
