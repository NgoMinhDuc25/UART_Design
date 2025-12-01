`timescale 1ns/1ps
`include "../rtl/uart_tx_module.sv"

module tb_uart_tx_module;
    parameter DATA_WIDTH = 8;
    // Clock 12MHz -> Chu kỳ ~ 83.33ns
    parameter CLK_PERIOD = 83.333; 
    // Baudrate 9600 -> 1 bit kéo dài khoảng 104167ns
    parameter BIT_PERIOD = 104167; 

    reg clk;
    reg rst_n;
    reg wr_en;
    reg [DATA_WIDTH-1:0] tx_data_i;
    
    wire tx_o;
    wire tx_full_o;

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

    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    initial begin
        rst_n = 0;
        wr_en = 0;
        tx_data_i = 0;

        $display("[Time %0t] Bat dau Reset he thong...", $time);
        repeat(5) @(posedge clk);
        rst_n = 1; 
        $display("[Time %0t] Da tha Reset.", $time);
        
        repeat(2) @(posedge clk);

        // Nạp data 0xA5 vào FIFO
        $display("[Time %0t] Nap data 0xA5 vao FIFO...", $time);
        
        tx_data_i = 8'hA5; // 10100101
        wr_en = 1;         
        
        @(posedge clk);    
        
        wr_en = 0;         
        tx_data_i = 8'h00; 

        $display("[Time %0t] Nap xong. Cho UART truyen tin...", $time);

        #1200000; 

        $display("[Time %0t] Ket thuc mo phong.", $time);
        $finish;
    end

endmodule