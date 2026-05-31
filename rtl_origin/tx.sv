module uart_tx #(parameter DATAWIDTH = 8)(
    input wire clk,
    input wire rst_n_i,
    input wire s_tick,
    input wire tx_start_i,
    input wire [DATAWIDTH-1:0] tx_data_i,
    output wire tx_o,
    output reg tx_done_o
  );

  localparam IDLE = 2'b00;
  localparam START = 2'b01;
  localparam DATA = 2'b10;
  localparam STOP = 2'b11;
  localparam DATA_TICK = 16;
  localparam DATABIT = $clog2(DATAWIDTH);
  localparam count_width = $clog2(DATA_TICK);

  reg [count_width-1:0] scount, next_scount; //sampling count
  reg [DATABIT-1:0] ncount, next_ncount;
  reg [DATAWIDTH-1:0] data_reg, next_data_reg; //data shift register
  reg [1:0] state, next_state;
  reg next_tx_done;
  reg tx_o_buf, next_tx_reg_buf;

  always @(posedge clk)
  begin: output_assignment
    if (!rst_n_i)
    begin
      state <= IDLE;
      scount <= 0;
      ncount <= 0;
      data_reg <= 0;
      tx_done_o <= 0;
      tx_o_buf <= 1;
    end
    else
    begin
      state <= next_state;
      scount <= next_scount;
      ncount <= next_ncount;
      data_reg <= next_data_reg;
      tx_done_o <= next_tx_done;
      tx_o_buf <= next_tx_reg_buf;
    end
  end

  assign tx_o = tx_o_buf;

  always @(*)
  begin: FSM
    next_state = state;
    next_scount = scount;
    next_ncount = ncount;
    next_data_reg = data_reg;
    next_tx_done = 0;
    next_tx_reg_buf = tx_o_buf;

    case(state)
      IDLE:
      begin
        next_tx_reg_buf = 1;
        next_state = (tx_start_i == 1) ? START : IDLE;
        next_scount = 0;
        next_data_reg = tx_data_i;
        next_tx_done = 1;
      end
      START:
      begin
        if (s_tick == 1)
        begin
          next_tx_reg_buf = 0;
          if (scount == DATA_TICK - 1)
          begin
            next_state = DATA;
            next_scount = 0;
            next_ncount = 0;
          end
          else
          begin
            next_state = START;
            next_scount = scount + 1;
          end
        end
        else
        begin
          next_state = START;
        end
      end
      DATA:
      begin
        if (s_tick == 1)
        begin
          next_tx_reg_buf = data_reg[0];
          if (scount == 15)
          begin
            next_scount = 0;
            next_data_reg = data_reg >> 1;
            if (ncount == DATAWIDTH - 1)
            begin
              next_state = STOP;
            end
            else
            begin
              next_state = DATA;
              next_ncount = ncount + 1;
            end
          end
          else
          begin
            next_state = DATA;
            next_scount = scount + 1;
          end
        end
        else
        begin
          next_state = DATA;
        end
      end
      STOP:
      begin
        if (s_tick == 1)
        begin
          next_tx_reg_buf = 1;
          if (scount == 15)
          begin
            next_state = IDLE;
            next_tx_done = 1;
            next_scount = 0;
          end
          else
          begin
            next_state = STOP;
            next_scount = scount + 1;
          end
        end
        else
        begin
          next_state = STOP;
        end
      end
      default:
        next_state = IDLE;
    endcase
  end

endmodule
