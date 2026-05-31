module FIFO_Read_Pointer #(parameter ADDR_WIDTH = 4)(
    input wire clk,
    input wire n_rst,
    input wire rd_en,
    input wire f_empty,
    output reg [ADDR_WIDTH-1:0] rd_ptr,
    output wire can_read
  );
  assign can_read = rd_en && !f_empty;
  always @(posedge clk or negedge n_rst)
  begin
    if(!n_rst)
    begin
      rd_ptr <= 0;
    end
    else
    begin
      if(can_read)
      begin
        rd_ptr <= rd_ptr + 1;
      end
      else
      begin
        rd_ptr <= rd_ptr;
      end
    end
  end
endmodule
