module CONF_CONTROL_VERIFICA
	(
	input [7:0] rxdw,
	input rxrdy,
	input txbusy,
	input rst,
	input clk,
	output [7:0] txdw,
	output txena,
	output [8:0] sleds,
	output [7:0] r_control,
	output [23:0] r_frec_mod,
	output [23:0] r_frec_por,
	output [15:0] r_im_am,
	output [15:0] r_im_fm
);

// Conexiones módulos


wire load_confregs;
wire shift_rxregs;
wire load_txregs;
wire shift_txregs;

			
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
CONTROL C3
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
