module RS232COM
	#(parameter ncpb = 434)
	(
	input rxsd,
	input [7:0] txdw,
	input txena,
	input rst,
	input clk,
	output txsd,
	output [7:0] rxdw,
	output txbusy,
	output rxrdy
	);

	wire nrst;
	wire i_rxrdy;
	

comm_rs232 #(.ncpb(ncpb)) U1
				(
				.id_rxds(rxsd),    		// rx serial data
				.id_txdw(txdw),  			// data to transmit : u[8 0]
				.ic_txena(txena),      	// transmit enable
				.ic_clk(clk),          	// clock signal
				.ic_rst(rst),          	// reset signal
				.od_txds(txsd),        	// tx serial data
				.oc_txbsy(txbusy),      // transmitting busy
				.od_rxdw(rxdw), 			// received data : u[8 0]
				.oc_rxrdy(rxrdy)       	// r1eceived ready
				);
endmodule 

