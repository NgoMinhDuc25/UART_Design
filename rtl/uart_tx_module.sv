`include "tx.sv"
`include "bau_gen.sv"
`include "FIFO.sv"

module uart_tx_module #(parameter DATA_WIDTH = 8) (
    input wire clk,
    input wire rst_n,
    input wire wr_en,
    input wire [DATA_WIDTH-1:0] tx_data_i,
    output wire tx_o,
    output wire tx_full_o
  );

  wire s_tick;
  wire tx_done_o;
  wire read_en;
  wire fifo_empty;
  wire start_tx;
  wire [DATA_WIDTH-1:0] tx_data_buf;
  reg start_tx_delayed;

  assign read_en = tx_done_o & ~fifo_empty;
  assign start_tx = ~fifo_empty;

  always @(posedge clk)
  begin
    if (!rst_n)
    begin
      start_tx_delayed <= 0;
    end
    else
    begin
      start_tx_delayed <= start_tx;
    end
  end

  baurate_gen #(
                .BAUDCOUNT(78) // Example value for 9600 baud with 12MHz clock
              ) bau_gen_inst (
                .clk(clk),
                .rst_n(rst_n),
                .bau_tick_o(s_tick)
              );

  uart_tx #(
            .DATAWIDTH(DATA_WIDTH)
          ) uart_tx_inst (
            .clk(clk),
            .rst_n_i(rst_n),
            .s_tick(s_tick),
            .tx_start_i(start_tx_delayed),
            .tx_data_i(tx_data_buf),
            .tx_o(tx_o),
            .tx_done_o(tx_done_o)
          );

  // FIFO to buffer data to be transmitted
  FIFO #(
         .DEPTH(16),
         .ADDR_WIDTH(4),
         .DATA_WIDTH(DATA_WIDTH)
       ) fifo_inst (
         .clk(clk),
         .n_rst(rst_n),
         .wr_en(wr_en),
         .rd_en(read_en),
         .din(tx_data_i),
         .dout(tx_data_buf),
         .f_full(tx_full_o),
         .f_empty(fifo_empty)
       );



endmodule
