/*
+-------------------------------------------------------------------------------------------------------------------+
| This is my synchronous FIFO implementation in Verilog.                                                            |
| It includes separate modules for write pointer, read pointer, memory, and state management (full/empty flags).    |
| The regiters array is 8 bits wide and has a depth of 16 by default.                                               |
| You can adjust the parameters DEPTH, ADDR_WIDTH, and DATA_WIDTH as needed.                                        |
+-------------------------------------------------------------------------------------------------------------------+
*/

`include "FIFO_Memory.sv"
`include "FIFO_Read_Pointer.sv"
`include "FIFO_Write_Pointer.sv"
`include "FIFO_State.sv"

module FIFO #(    
    parameter DEPTH = 16,
    parameter ADDR_WIDTH = 4, 
    parameter DATA_WIDTH = 8
    )(
    input wire clk,
    input wire n_rst,
    input wire wr_en,
    input wire rd_en,
    input wire [7:0] din,
    output wire [7:0] dout,
    output wire f_full,
    output wire f_empty
);
    wire [ADDR_WIDTH-1:0] wr_ptr, rd_ptr;
    wire can_wite, can_read;

    FIFO_Write_Pointer #(
        .ADDR_WIDTH(ADDR_WIDTH)
    ) write_pointer_inst (
        .clk(clk),
        .n_rst(n_rst),
        .wr_en(wr_en),
        .f_full(f_full),
        .wr_ptr(wr_ptr),
        .can_write(can_wite)
    );

    FIFO_Read_Pointer #(
        .ADDR_WIDTH(ADDR_WIDTH)
    ) read_pointer_inst (
        .clk(clk),
        .n_rst(n_rst),
        .rd_en(rd_en),
        .f_empty(f_empty),
        .rd_ptr(rd_ptr),
        .can_read(can_read)
    );

    FIFO_Memory #(
        .DEPTH(DEPTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) memory_inst (
        .clk(clk),
        .can_write(can_wite),
        .can_read(can_read),
        .din(din),
        .wr_ptr(wr_ptr),
        .rd_ptr(rd_ptr),
        .dout(dout)
    );

    FIFO_State #(
        .ADDR_WIDTH(ADDR_WIDTH)
    ) state_inst (
        .clk(clk),
        .n_rst(n_rst),
        .can_write(can_wite),
        .can_read(can_read),
        .wr_ptr(wr_ptr),
        .rd_ptr(rd_ptr),
        .f_full(f_full),
        .f_empty(f_empty)
    );
endmodule








