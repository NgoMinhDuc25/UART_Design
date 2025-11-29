module FIFO_Write_Pointer #(parameter ADDR_WIDTH = 4)(
    input wire clk,
    input wire n_rst,
    input wire wr_en,
    input wire f_full,
    output reg [ADDR_WIDTH-1:0] wr_ptr,
    output wire can_write
  );
  assign can_write = wr_en && !f_full;
  always @(posedge clk or negedge n_rst)
  begin
    if(!n_rst)
    begin
      wr_ptr <= 0;
    end
    else
    begin
      if(can_write)
      begin
        wr_ptr <= wr_ptr + 1;
      end
      else
      begin
        wr_ptr <= wr_ptr;
      end
    end
  end
endmodule
