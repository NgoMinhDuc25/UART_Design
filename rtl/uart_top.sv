module uart_top #(
    parameter DATA_WIDTH = 8,
    parameter FIFO_DEPTH = 16,
    parameter FIFO_ADDR_WIDTH = 4
) (
    input wire clk,
    input wire rst_n,

    // Giao diện UART vật lý
    input wire rx_i,
    output wire tx_o,

    // Giao diện phía hệ thống (User Interface)
    // --- Nhận (RX) ---
    input wire rx_read_en,      // Đọc dữ liệu ra từ FIFO nhận
    output wire [DATA_WIDTH-1:0] rx_dout,
    output wire rx_fifo_full,
    output wire rx_fifo_empty,

    // --- Truyền (TX) ---
    input wire tx_wr_en,        // Ghi dữ liệu vào FIFO truyền
    input wire [DATA_WIDTH-1:0] tx_din,
    output wire tx_fifo_full
);

    // Instance bộ nhận UART (RX)
    uart_rx_module #(
        .DATA_WIDTH(DATA_WIDTH),
        .FIFO_DEPTH(FIFO_DEPTH),
        .FIFO_ADDR_WIDTH(FIFO_ADDR_WIDTH)
    ) rx_inst (
        .clk(clk),
        .rst_n(rst_n),
        .rx_i(rx_i),
        .read_en(rx_read_en),
        .dout_o(rx_dout),
        .fifo_full(rx_fifo_full),
        .fifo_empty(rx_fifo_empty)
    );

    // Instance bộ truyền UART (TX)
    uart_tx_module #(
        .DATA_WIDTH(DATA_WIDTH)
    ) tx_inst (
        .clk(clk),
        .rst_n(rst_n),
        .wr_en(tx_wr_en),
        .tx_data_i(tx_din),
        .tx_o(tx_o),
        .tx_full_o(tx_fifo_full)
    );

endmodule
