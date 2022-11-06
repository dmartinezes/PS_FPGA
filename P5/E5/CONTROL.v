module CONTROL
	(
	input [7:0] rxdw, 		// rx dw from RS232
	input	clk, 		// clk 
	input	rst,
	output   txena, 	// tx enable to RS232
	input	rxrdy, 	// rx rdy from RS232
	input	txbusy, 	// tx busy from RS232
	output  load_confregs, 	// load configuration registers
	output  shift_rxregs, 	// shift rx registers
	output  load_txregs, 	// load conf_regs in tx_regs
	output  shift_txregs, 	// shift tx registers
	output [8:0] sleds
	);

// Conexiones módulos
wire start_wr, start_rd, done_wr, done_rd;

MAIN_CONTROL C1
			(
			.rxrdy(rxrdy),
			.rxdw(rxdw),
			.done_wr(done_wr),
			.done_rd(done_rd),
			.rst(rst),
			.clk(clk),
			.start_wr(start_wr),
			.start_rd(start_rd),
			.sleds(sleds[2:0]) 
			);
WR_CONTROL C2
			(
			.rxrdy(rxrdy),
			.start_wr(start_wr),
			.rst(rst),
			.clk(clk),
			.shift_rxregs(shift_rxregs),
			.load_confregs(load_confregs),
			.done_wr(done_wr),
			.wr_leds(sleds[5:3])
			);
			
RD_CONTROL C3
			(
			.txbusy(txbusy),
			.start_rd(start_rd),
			.rst(rst),
			.clk(clk),
			.txena(txena),
			.load_txregs(load_txregs),
			.shift_txregs(shift_txregs),
			.done_rd(done_rd),
			.rd_leds(sleds[8:6])
			);		
	
endmodule
