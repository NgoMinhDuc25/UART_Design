{ signal: [
  { name: "clk",        wave: "p......................." },
  { name: "rst_n",      wave: "0.1....................." },
  { name: "rx_i (Input)", wave: "1..01010010111..........", node: "...a.........b" },
  { name: "state (FSM)",  wave: "x..3444444442x.........", data: ["START", "DATA0", "DATA1", "DATA2", "DATA3", "DATA4", "DATA5", "DATA6", "DATA7", "STOP"] },
  { name: "rx_done",      wave: "0...........10.........." },
  { name: "fifo_empty",   wave: "1...........0..........." },
  { name: "rd_en (User)", wave: "0.............10........" },
  { name: "dout_o",       wave: "x.............5.........", data: ["0xA5"] }
],
  edge: [
    "a<->b Frame: 0xA5 (LSB First)",
    "b|->c FIFO Write",
    "c|->d Read Data"
  ],
  head: {
   text: 'UART RX Simulation Waveform (Scenario: Send 0xA5 -> Read FIFO)',
   tick: 0,
  },
 config: { hscale: 1 }
}