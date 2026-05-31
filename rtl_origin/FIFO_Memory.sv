module FIFO_Memory #(parameter DEPTH = 16, parameter DATA_WIDTH = 8)(
    input wire clk,
    input wire can_write,
    input wire can_read,
    input wire [DATA_WIDTH-1:0] din,
    input wire [3:0] wr_ptr,
    input wire [3:0] rd_ptr,
    output reg [DATA_WIDTH-1:0] dout
  );
  reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

  always @(posedge clk)
  begin
    if(can_write)
    begin
      mem[wr_ptr] <= din;
    end
    if(can_read)
    begin
      dout <= mem[rd_ptr];
    end
  end

endmodule
