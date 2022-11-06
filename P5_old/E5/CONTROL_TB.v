`timescale 1ns / 1ps

module CONTROL_TB;

    // CLOCK PERIOD
	parameter PER=10; 

	// Estimulos
	reg clk;
	reg rst;
    reg rxrdy;
    reg [7:0] rxdw;
    reg done_wr;
    reg done_rd;
 

    // Monitorizacion
    wire start_wr;
    wire start_rd;
    wire [2:0] sleds;

    // clock
    always begin
        #(PER/2) clk = ~clk;
    end

    // Instancia a DUT
    CONTROL dut1 ;



endmodule 