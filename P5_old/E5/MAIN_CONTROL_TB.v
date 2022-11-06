`timescale 1ns / 1ps

module MAIN_CONTROL_TB;

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
    MAIN_CONTROL dut1 
    (.rxrdy(rxrdy), 
    .clk(clk), 
    .rst(rst),
    .rxdw(rxdw),
    .done_wr(done_wr),
    .done_rd(done_rd),
    .start_wr(start_wr),
    .start_rd(start_rd),
    .sleds(sleds));
    
    initial begin

        clk = 1'b1;
        rst = 1'b1;
        rxrdy = 1'b0;   // señal que indica que se ha recibido dato por puerto serie
        //rxdw = ;      // dato (byte) recibido
        done_wr = 1'b0;
        done_rd = 1'b0;
        
        //Simulacion de lectura
        #(10*PER);
        rst = #(PER/10) 1'b0;
        rxrdy = 1'b1;
        rxdw = 8'hF0;
        done_wr = 1'b0;
        done_rd = 1'b0;

        #(1*PER);
        rxrdy = 1'b0;

        #(20*PER);
        done_rd = 1'b1;
        #(1*PER);
        done_rd = 1'b0;

        //ciclos de espera
        #(50*PER);

        //Simulacion de escritura
        #(10*PER);
        rst = #(PER/10) 1'b0;
        rxrdy = 1'b1;
        rxdw = 8'h0F;
        done_wr = 1'b0;
        done_rd = 1'b0;

        #(1*PER);
        rxrdy = 1'b0;

        #(20*PER);
        done_wr = 1'b1;
        #(1*PER);
        done_wr = 1'b0;

        

        #(500*PER) $stop;
        
    end
    

  /*  function integer log2;
        input integer value;
        begin
            value = value-1;
            for (log2=0; value>0; log2=log2+1)
                value = value>>1;
        end
    endfunction*/

endmodule