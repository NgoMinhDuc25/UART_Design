{ signal: [
  { name: "clk",        wave: "p.........................." },
  { name: "rst_n",      wave: "0.1........................" },
  { name: "wr_en",      wave: "0...10....................." },
  { name: "fifo_data_i",  wave: "x..5.x.....................", data: ["0xA5"] },
  { name: "rd_en",      wave: "0....10...................." },
  { name: "tx_data_i",  wave: "x.....5....................", data: ["0xA5"] },
  { name: "fifo_empty", wave: "1...0.1...................." },
  { name: "tx_start",   wave: "0...1.0...................." },
  { name: "tx_o",       wave: "1....0101001011............", node: ".....a.........b" },
  { name: "tx_done_o",  wave: "0..............10.........." }
],
  edge: [
    "a~>b "
  ],
  head: {
   text: 'UART TX Simulation Waveform (Send from FIFO -> 0xA5)',
   tick: 0,
  },
 config: { hscale: 1 }
}