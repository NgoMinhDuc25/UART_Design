`include "bau_gen.sv"
`include "rx.sv"
`include "FIFO.sv"

module uart_rx_module #(parameter DATA_WIDTH = 8, parameter FIFO_DEPTH = 16, parameter FIFO_ADDR_WIDTH = 4) (
    input wire clk,
    input wire rst_n,
    input wire rx_i,
    input wire read_en,
    output wire [DATA_WIDTH-1:0] dout_o,
    output wire fifo_full,
    output wire fifo_empty
  );

    wire bau_tick;
    wire [DATA_WIDTH-1:0] rx_data;
    wire rx_done;
    reg fifo_wr_en;
    wire rx_done_in;

    // Baud rate generator instance
    baurate_gen #(
        .BAUDCOUNT(78) // Example value for 9600 baud with 12MHz clock
    ) bau_gen_inst (
        .clk(clk),
        .rst_n(rst_n),
        .bau_tick_o(bau_tick)
    );

    // UART receiver instance
    uart_rx #(
        .DATA_WIDTH(DATA_WIDTH)
    ) uart_rx_inst (
        .clk(clk),
        .rst_n_i(rst_n),
        .s_tick(bau_tick),
        .rx_i(rx_i),
        .dout_o(rx_data),
        .rx_done_o(rx_done)
    );

    // FIFO instance
    FIFO #(
        .DEPTH(FIFO_DEPTH),
        .ADDR_WIDTH(FIFO_ADDR_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) fifo_inst (
        .clk(clk),
        .n_rst(rst_n),
        .wr_en(fifo_wr_en),
        .rd_en(read_en),        
        .din(rx_data),
        .dout(dout_o),
        .f_full(fifo_full),
        .f_empty(fifo_empty)
    );

    // FIFO write enable logic
    always @(posedge clk) begin
        if (!rst_n) begin
            fifo_wr_en <= 1'b0;
        end else begin
            fifo_wr_en <= rx_done && !fifo_full;
        end
    end
endmodule