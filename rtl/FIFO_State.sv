module FIFO_State #(parameter ADDR_WIDTH = 4)(
    input wire clk,
    input wire n_rst,
    input wire can_write,
    input wire can_read,
    input wire [ADDR_WIDTH-1:0] wr_ptr,
    input wire [ADDR_WIDTH-1:0] rd_ptr,
    output reg f_full,
    output reg f_empty
  );

  always @(posedge clk or negedge n_rst)
  begin
    if(!n_rst)
    begin
      f_full <= 0;
      f_empty <= 1;
    end
    else
    begin
      if(can_write)
      begin
        f_empty <= 0;
        if((wr_ptr + 1 == rd_ptr))
        begin
          f_full <= 1;
        end
        else
        begin
          f_full <= 0;
        end
      end

      if(can_read)
      begin
        f_full <= 0;
        if((rd_ptr + 1 == wr_ptr))
        begin
          f_empty <= 1;
        end
        else
        begin
          f_empty <= 0;
        end
      end
    end
  end

endmodule
