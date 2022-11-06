`timescale 1ns / 1ps

module REGS_CONF_TB;

    // CLOCK PERIOD
	parameter PER=10; 

	// Estimulos
	reg clk;
	reg rst;
    reg [7:0] rxdw;
    reg load_confregs, shift_rxregs, load_txregs, shift_txregs;

    // Monitorizacion
    wire [7:0] txdw;
    wire [7:0] r_control;
    wire [23:0] r_frec_mod;
    wire [23:0] r_frec_por;
    wire [15:0] r_im_am;
    wire [15:0] r_im_fm;

    // clock
    always begin
        #(PER/2) clk = ~clk;
    end

    // Instancia a DUT
    REGS_CONF dut1 
    (.rxdw(rxdw), 
    .clk(clk), 
    .load_confregs(load_confregs),
    .shift_rxregs(shift_rxregs),
    .load_txregs(load_txregs),
    .shift_txregs(shift_txregs),
    .txdw(txdw),
    .r_control(r_control),
    .r_frec_mod(r_frec_mod),
    .r_frec_por(r_frec_por),
    .r_im_am(r_im_am),
    .r_im_fm(r_im_fm));

    task RESET();
    begin
        // Activaion de reset de 2 ciclos (asíncrono)
        rst = 1'b1;
        repeat(2) @(posedge clk);
        // Desactivacion de reset
        rst = 1'b0;
    end
    endtask

    initial begin

        // Inicializacion de señales

        clk = 1'b1;
        shift_rxregs <= 0;
        load_confregs <= 0;
        load_txregs <= 0;
        shift_txregs <= 0;
        rxdw <= 0;

        // Inicio

        RESET();

        rxdw <= 25;
        shift_rxregs <= 1;
        #(11*PER);
 

        load_confregs <= 1;
        #(10*PER);

        load_txregs <= 1;
        #(10*PER);


        shift_txregs <= 1;
        #(20*PER);


        $stop;

    end

endmodule