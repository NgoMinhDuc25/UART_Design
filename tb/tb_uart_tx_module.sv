`timescale 1ns/1ps
`include "../rtl/uart_tx_module.sv"

module tb_uart_tx_module;

    // --- 1. Parameters ---
    parameter DATA_WIDTH = 8;
    // Clock 12MHz -> Chu kỳ ~ 83.33ns
    parameter CLK_PERIOD = 83.333; 
    // Baudrate 9600 -> 1 bit kéo dài khoảng 104167ns
    parameter BIT_PERIOD = 104167; 

    // --- 2. Signals ---
    reg clk;
    reg rst_n;
    reg wr_en;
    reg [DATA_WIDTH-1:0] tx_data_i;
    
    wire tx_o;
    wire tx_full_o;

    // --- 3. Instantiate DUT (Device Under Test) ---
    uart_tx_module #(
        .DATA_WIDTH(DATA_WIDTH)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .wr_en(wr_en),
        .tx_data_i(tx_data_i),
        .tx_o(tx_o),
        .tx_full_o(tx_full_o)
    );

    // --- 4. Clock Generation ---
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    // --- 5. Main Test Scenario ---
    initial begin
        // A. Khởi tạo giá trị ban đầu
        rst_n = 0;
        wr_en = 0;
        tx_data_i = 0;

        // B. Scenario 1: Reset trong 5 chu kỳ
        $display("[Time %0t] Bat dau Reset he thong...", $time);
        repeat(5) @(posedge clk);
        rst_n = 1; // Thả reset
        $display("[Time %0t] Da tha Reset.", $time);
        
        // Chờ 2 chu kỳ để hệ thống ổn định
        repeat(2) @(posedge clk);

        // C. Scenario 2: Nạp data 0xA5 vào FIFO
        $display("[Time %0t] Nap data 0xA5 vao FIFO...", $time);
        
        // Setup dữ liệu trước cạnh lên clock
        tx_data_i = 8'hA5; // 10100101
        wr_en = 1;         // Kích hoạt ghi
        
        @(posedge clk);    // Đợi 1 nhịp clock để FIFO ghi vào
        
        wr_en = 0;         // Tắt ghi
        tx_data_i = 8'h00; // Xóa input (để chắc chắn không ghi nhầm)

        $display("[Time %0t] Nap xong. Cho UART truyen tin...", $time);

        // D. Scenario 3: Quan sát quá trình truyền (Transmission)
        // 1 khung truyền 9600 baud tốn khoảng: 10 bit * 104us = ~1ms
        // Ta chờ khoảng 1.2ms để quan sát trọn vẹn
        #1200000; 

        $display("[Time %0t] Ket thuc mo phong.", $time);
        $finish;
    end

endmodule