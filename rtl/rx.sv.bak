module uart_rx #(parameter DATA_WIDTH = 8) (
    input wire clk,
    input wire rst_n_i,
    input wire s_tick,
    input wire rx_i,
    output wire [DATA_WIDTH-1:0] dout_o,
    output reg rx_done_o
  );

  localparam IDLE    = 2'b00;
  localparam START   = 2'b01;
  localparam DATA    = 2'b10;
  localparam STOP    = 2'b11;
  localparam DATA_TICK = 16;
  localparam START_TICK = 8;
  localparam count_width = $clog2(DATA_TICK);
  localparam data_width = $clog2(DATA_WIDTH);

  reg [count_width-1:0] scount, next_scount; //count for s_tick
  reg [data_width-1:0] ncount, next_ncount; //count for data bits
  reg [DATA_WIDTH-1:0] data_reg, next_data_reg; //data shift register
  reg [DATA_WIDTH-1:0] meta, rx; //uart meta buffer
  reg [1:0] state, next_state;
  reg next_rxdone;

  assign dout_o = rx_done_o ? data_reg : dout_o;

  always @(posedge clk)
  begin: output_assignment
    if (!rst_n_i)
    begin
      state <= IDLE;
      scount <= 0;
      ncount <= 0;
      data_reg <= 0;
      rx_done_o <= 0;
      rx <= 0;
    end
    else
    begin
      state <= next_state;
      scount <= next_scount;
      ncount <= next_ncount;
      data_reg <= next_data_reg;
      rx_done_o <= next_rxdone;
    end
  end

  always @(*)
  begin: FSM
    next_state = state;
    next_scount = scount;
    next_ncount = ncount;
    next_data_reg = data_reg;
    next_rxdone = 0;
    case(state)
      IDLE:
      begin
        if (rx == 0)
        begin
          next_state = START;
          next_scount = 0;
        end
        else
        begin
          next_state = IDLE;
        end
      end

      START:
      begin
        if(s_tick)
        begin
          if(scount == START_TICK-1)
          begin
            next_state = DATA;
            next_scount = 0;
            next_ncount = 0;
          end
          else
          begin
            next_scount = scount + 1;
          end
        end
      end

      DATA:
      begin
        if(s_tick)
        begin
          if(scount == DATA_TICK -1)
          begin
            next_scount = 0;
            next_data_reg = {rx, data_reg[DATA_WIDTH-1:1]};
            if(ncount == DATA_WIDTH - 1)
            begin
              next_state = STOP;
            end
            else
            begin
              next_ncount = ncount + 1;
            end
          end
          else
          begin
            next_scount = scount + 1;
          end
        end
      end

      STOP:
      begin
        if(s_tick)
        begin
          if(scount == DATA_TICK - 1)
          begin
            next_rxdone = 1;
            next_state = IDLE;
          end
          else
          begin
            next_scount = scount + 1;
          end
        end
      end

      default:
        next_state = IDLE;
    endcase
  end

  always @(posedge clk)
  begin: metastability
    meta <= rx_i;
    rx <= meta;
  end


endmodule
