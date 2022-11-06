module CONF_CONTROL
	(
	input rxsd,
	input rst,
	input clk,
	output txsd,
	output [8:0] sleds,
	output [7:0] r_control,
	output [23:0] r_frec_mod,
	output [23:0] r_frec_por,
	output [15:0] r_im_am,
	output [15:0] r_im_fm,
	output [7:0] view_rxdw
);

// Conexiones módulos
wire [7:0] rxdw;
wire [7:0] txdw;
wire txena, txbusy, rxrdy;
wire ld_byte;
wire start_wr, start_rd, done_wr, done_rd;
wire load_confregs, shift_rxregs, load_txregs, shift_txregs; 


assign view_rxdw = rxdw;

 RS232COM #(.ncpb(434)) C1
//RS232COM #(.ncpb(8)) C1
			(
			.rxsd(rxsd),
			.txdw(txdw),
			.txena(txena),
			.rst(rst),
			.clk(clk),
			.txsd(txsd),
			.rxdw(rxdw),
			.txbusy(txbusy),
			.rxrdy(rxrdy)
			);
			
REGS_CONF C2 
			(
			.rxdw(rxdw), 		// rx dw from RS232
			.clk(clk), 		// clk 
			.load_confregs(load_confregs), 	// load configuration registers
			.shift_rxregs(shift_rxregs), 	// shift rx registers
			.load_txregs(load_txregs), 	// load conf_regs in tx_regs
			.shift_txregs(shift_txregs), 	// shift tx registers
			.txdw(txdw), 		// tx dw to RS232
			.r_control(r_control),
			.r_frec_mod(r_frec_mod),
			.r_frec_por(r_frec_por),
			.r_im_am(r_im_am),
			.r_im_fm(r_im_fm)
			);
CONECT_FSMs C3
			(
			.rxdw(rxdw), 		// rx dw from RS232
			.rst(rst),
			.clk(clk),
			.txena(txena),
			.txbusy(txbusy),
			.rxrdy(rxrdy),
			.load_confregs(load_confregs), 	// load configuration registers
			.shift_rxregs(shift_rxregs), 	// shift rx registers
			.load_txregs(load_txregs), 	// load conf_regs in tx_regs
			.shift_txregs(shift_txregs), 	// shift tx registers
			.sleds(sleds)
			);
			
endmodule
