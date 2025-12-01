`timescale 1ns/1ps
`include "../rtl/uart_rx_module.sv "

module tb_uart_rx_module;
  parameter DATA_WIDTH = 8;
  parameter FIFO_DEPTH = 16;
  parameter FIFO_ADDR_WIDTH = 4;

  // Clock 12MHz -> Period ~ 83.33ns
  parameter CLK_PERIOD = 83.333;
  // Baudrate 9600 -> 1 bit duration = 1/9600s = 104167ns
  parameter BIT_PERIOD = 104167;

  reg clk;
  reg rst_n;
  reg rx_i;
  reg rd_en; 

  wire [DATA_WIDTH-1:0] dout_o;
  wire fifo_full;
  wire fifo_empty;

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

  initial
  begin
    clk = 0;
    forever
      #(CLK_PERIOD/2) clk = ~clk;
  end

  task send_uart_byte(input [7:0] data);
    integer i;
    begin
      // A. Start Bit 
      rx_i = 0;
      #(BIT_PERIOD);

      // B. Data Bits (LSB First)
      for (i = 0; i < 8; i = i + 1)
      begin
        rx_i = data[i];
        #(BIT_PERIOD);
      end

      // C. Stop Bit 
      rx_i = 1;
      #(BIT_PERIOD);
    end
  endtask

  initial
  begin
    rst_n = 0;
    rx_i = 1;      
    rd_en = 0;

    $display("Testbench bat dau...");
    $display("[Time %0t] Bat dau Reset...", $time);
    repeat(5) @(posedge clk);
    rst_n = 1;    
    $display("[Time %0t] Da tha Reset.", $time);
    repeat(10) @(posedge clk);

    //0 (Start) -> 1-0-1-0-0-1-0-1 -> 1 (Stop)
    $display("[Time %0t] Bat dau gui data 0xA5 qua UART Rx...", $time);
    send_uart_byte(8'hA5);
    $display("[Time %0t] Gui xong data.", $time);

    #(BIT_PERIOD * 2);

    if (fifo_empty == 0)
    begin
      $display("[Time %0t] FIFO da co du lieu (Empty = 0).", $time);
    end
    else
    begin
      $display("[Time %0t] ERROR: FIFO van Empty!", $time);
    end

    $display("[Time %0t] Kich hoat doc FIFO...", $time);
    @(posedge clk);
    rd_en = 1'b1;     
    $display("[Time %0t] Gia tri doc duoc tai dout_o ", $time);

    #20000;
    $finish;
  end

endmodule
