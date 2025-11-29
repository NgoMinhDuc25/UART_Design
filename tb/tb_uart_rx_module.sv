`timescale 1ns/1ps
`include "../rtl/uart_rx_module.sv "

module tb_uart_rx_module;

  // 1. Parameters & Constants
  parameter DATA_WIDTH = 8;
  parameter FIFO_DEPTH = 16;
  parameter FIFO_ADDR_WIDTH = 4;

  // Clock 12MHz -> Period ~ 83.33ns
  parameter CLK_PERIOD = 83.333;
  // Baudrate 9600 -> 1 bit duration = 1/9600s = 104167ns
  parameter BIT_PERIOD = 104167;

  // 2. Signals
  reg clk;
  reg rst_n;
  reg rx_i;
  reg rd_en; // Tín hiệu này cần được thêm vào module top

  wire [DATA_WIDTH-1:0] dout_o;
  wire fifo_full;
  wire fifo_empty;

  // 3. Instantiate DUT (Device Under Test)
  // LƯU Ý: Bạn cần sửa uart_rx_module để thêm cổng input rd_en
  uart_rx_module #(
                   .DATA_WIDTH(DATA_WIDTH),
                   .FIFO_DEPTH(FIFO_DEPTH),
                   .FIFO_ADDR_WIDTH(FIFO_ADDR_WIDTH)
                 ) dut (
                   .clk(clk),
                   .rst_n(rst_n),
                   .rx_i(rx_i),
                   .read_en(rd_en),
                   .dout_o(dout_o),
                   .fifo_full(fifo_full),
                   .fifo_empty(fifo_empty)
                 );

  // 4. Clock Generation
  initial
  begin
    clk = 0;
    forever
      #(CLK_PERIOD/2) clk = ~clk;
  end

  // 5. Task: Mô phỏng gửi 1 Byte qua UART (8N1)
  task send_uart_byte(input [7:0] data);
    integer i;
    begin
      // A. Start Bit (Kéo xuống 0)
      rx_i = 0;
      #(BIT_PERIOD);

      // B. Data Bits (LSB First)
      for (i = 0; i < 8; i = i + 1)
      begin
        rx_i = data[i];
        #(BIT_PERIOD);
      end

      // C. Stop Bit (Kéo lên 1)
      rx_i = 1;
      #(BIT_PERIOD);
    end
  endtask

  // 6. Main Test Scenario
  initial
  begin
    // --- Setup ban đầu ---
    rst_n = 0;
    rx_i = 1;      // Trạng thái IDLE của UART là 1
    rd_en = 0;

    // --- Scenario 1: Reset trong 5 chu kỳ ---
    $display("Testbench bat dau...");
    $display("[Time %0t] Bat dau Reset...", $time);
    repeat(5) @(posedge clk);
    rst_n = 1;     // Thả Reset
    $display("[Time %0t] Da tha Reset.", $time);

    // Chờ hệ thống ổn định 1 chút
    repeat(10) @(posedge clk);

    // --- Scenario 2: Gửi Data (Ví dụ gửi số 0xA5 = 10100101) ---
    // UART truyền LSB trước nên trên dây sẽ thấy: 0 (Start) -> 1-0-1-0-0-1-0-1 -> 1 (Stop)
    $display("[Time %0t] Bat dau gui data 0xA5 qua UART Rx...", $time);
    send_uart_byte(8'hA5);
    $display("[Time %0t] Gui xong data.", $time);

    // --- Scenario 3: Đợi xử lý ---
    // Cần đợi một chút để UART Rx module phát hiện xong Stop bit và đẩy vào FIFO
    // UART RX của bạn mất khoảng 16 tick baud để verify stop bit
    #(BIT_PERIOD * 2);

    // Kiểm tra xem FIFO đã hết empty chưa
    if (fifo_empty == 0)
    begin
      $display("[Time %0t] FIFO da co du lieu (Empty = 0).", $time);
    end
    else
    begin
      $display("[Time %0t] ERROR: FIFO van Empty!", $time);
    end

    // --- Scenario 4: Đọc Data ra (Read) ---
    $display("[Time %0t] Kich hoat doc FIFO...", $time);
    @(posedge clk);
    rd_en = 1'b1;     // Kích hoạt đọc
    //@(posedge clk); // Đợi 1 nhịp để data update ra ngõ ra
    $display("[Time %0t] Gia tri doc duoc tai dout_o = 0x%h", $time, dout_o);

    if (dout_o == 8'hA5)
      $display("--> TEST PASSED: Nhan dung du lieu!");
    else
      $display("--> TEST FAILED: Du lieu sai!");

    // Kết thúc mô phỏng
    #20000;
    $finish;
  end

endmodule
