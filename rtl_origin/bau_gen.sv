
module baurate_gen #(parameter BAUDCOUNT = 78) (
    input clk,
    input rst_n,
    output bau_tick_o
  );

  //for 9600 baud with 12MHz clk over 16 samples
  localparam BAUDWIDTH = $clog2(BAUDCOUNT);
  reg [BAUDWIDTH-1:0] baudcount_reg;

  assign bau_tick_o = (baudcount_reg == BAUDCOUNT - 1) ? 1'b1 : 1'b0;

  always @(posedge clk)
  begin
    if (!rst_n)
    begin
      baudcount_reg <= 0;
    end
    else
    begin
      baudcount_reg <= (baudcount_reg == BAUDCOUNT - 1) ? 0 : baudcount_reg + 1;
    end
  end

endmodule
