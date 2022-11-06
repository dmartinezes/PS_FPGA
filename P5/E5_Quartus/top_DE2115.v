module top_DE2115
	(
	input UART_RXD, 		// rx serial input
	input	CLOCK_50, 		// Main clock 50 MHz
	input		[0:0]	KEY, 	// Push buttom [3:0]
	input    [3:0] SW, 	// Switch [17:0]
	output	UART_TXD, 	// tx serial output
	output	[8:0]	LEDG,	// green LEDs [8:0]
	output	[15:0]	LEDR 	// Red LEDs [17:0]
	);


	wire rxsd;
	wire rst;
	wire clk;
	wire [3:0] addr_reg;
	wire txsd;
	wire [8:0] sleds;
	reg [7:0] viewregs;
	wire [7:0] view_rinst,view_rxdw;
	
	wire [7:0] r_control;
	wire [23:0] r_frec_mod;
	wire [23:0] r_frec_por;
	wire [15:0] r_im_am;
	wire [15:0] r_im_fm;
	
	// Conexión puertos y señales internas
	assign rxsd = UART_RXD;
	assign UART_TXD = txsd;
	//assign clk = CLOCK_50;
	assign rst = !KEY[0];
	assign addr_reg = SW[3:0];
	assign LEDG = sleds;
	assign LEDR[7:0] = viewregs;
	
	assign LEDR[15:8] = view_rxdw;
	
	always@*
		case(addr_reg)
			4'b 0000: 	viewregs = r_control;
			4'b 0001: 	viewregs = r_frec_mod[23:16];
			4'b 0010: 	viewregs = r_frec_mod[15:8];
			4'b 0011: 	viewregs = r_frec_mod[7:0];
			4'b 0100: 	viewregs = r_frec_por[23:16];
			4'b 0101: 	viewregs = r_frec_por[15:8];
			4'b 0110: 	viewregs = r_frec_por[7:0];
			4'b 0111: 	viewregs = r_im_am[15:8];
			4'b 1000: 	viewregs = r_im_am[7:0];
			4'b 1001: 	viewregs = r_im_fm[15:8];
			4'b 1010: 	viewregs = r_im_fm[7:0];
			default:  	viewregs = 8'b 00000000;
		endcase 
	
	
	CONF_CONTROL INST1
					(
					.rxsd(rxsd),
					.rst(rst),
					.clk(clk),
					.txsd(txsd),
					.sleds(sleds),
					.r_control(r_control),
					.r_frec_mod(r_frec_mod),
					.r_frec_por(r_frec_por),
					.r_im_am(r_im_am),
					.r_im_fm(r_im_fm),
					.view_rxdw(view_rxdw)
					);
					
PLL_test	PLL_test_inst (
					.areset ( 1'b0),
					.inclk0 ( CLOCK_50 ),
					.c0 ( clk )
					);
endmodule 