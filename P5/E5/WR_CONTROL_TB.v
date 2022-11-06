`timescale 1ns / 1ps

module WR_CONTROL_TB;

    // CLOCK PERIOD
	parameter PER=10; 

	// Estimulos
	reg clk;
	reg rst;
    reg rxrdy;
    reg start_wr;

    // Monitorizacion
    wire shift_rxregs;
    wire load_confregs;
    wire done_wr;
    wire [2:0] wr_leds;

    // clock
    always begin
        #(PER/2) clk = ~clk;
    end

    // Instancia a DUT
    WR_CONTROL dut1 
    (.rxrdy(rxrdy), 
    .clk(clk), 
    .rst(rst),
    .start_wr(start_wr),
    .load_confregs(load_confregs),
    .wr_leds(wr_leds),
    .shift_rxregs(shift_rxregs),
    .done_wr(done_wr));

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
        rst = 1'b1;
        rxrdy = 1'b0;   // señal que indica que se ha recibido dato por puerto serie
        
        // Inicio proceso de escritura

        start_wr = 1'b1;
        RESET();
        
        repeat (15) begin
            WRITE();
        end


        #(500*PER) $stop;
        
    end  

    task WRITE();
    begin

        // Simulacion de escritura 
        rxrdy = 1'b1;
        #(1*PER);
        rxrdy = 1'b0;
        #(20*PER);

    end
    endtask

endmodule