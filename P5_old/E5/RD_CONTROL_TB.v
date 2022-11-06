`timescale 1ns / 1ps

module RD_CONTROL_TB;

    // CLOCK PERIOD
	parameter PER=10; 

	// Estimulos
	reg clk;
	reg rst;
    reg txbusy;
    reg start_rd;

    // Monitorizacion
    wire txena;
    wire load_txregs;
    wire shift_txregs;
    wire done_rd;
    wire [2:0] rd_leds;

    // clock
    always begin
        #(PER/2) clk = ~clk;
    end

    // Instancia a DUT
    RD_CONTROL dut1 
    (.txbusy(txbusy), 
    .start_rd(start_rd),
    .clk(clk), 
    .rst(rst),
    .txena(txena),
    .load_txregs(load_txregs),
    .shift_txregs(shift_txregs),
    .done_rd(done_rd),
    .rd_leds(rd_leds));

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
        txbusy = 1'b1;   
        start_rd = 1'b0;
        
        //Simulacion de proceso de lectura

        #(10*PER);
        start_rd = 1'b1;
        RESET();
        
        repeat(11) 
        begin
            #(20*PER);
            READ();   //simular con ciclos justos al igual que haria el puerto serie  
        end
        
        #(10*PER);
        start_rd = 0;
        
        $stop;
        
    end

    task READ();
    begin
        txbusy = 1'b0;
        #(1*PER);
        txbusy = 1'b1;
    end
    endtask

endmodule

/*
`timescale 1ns / 1ps

module RD_CONTROL_TB;

    // CLOCK PERIOD
	parameter PER=10; 

	// Estimulos
	reg clk;
	reg rst;
    reg txbusy;
    reg start_rd;

    // Monitorizacion
    wire txena;
    wire load_txregs;
    wire shift_txregs;
    wire done_rd;
    wire [2:0] rd_leds;

    // clock
    always begin
        #(PER/2) clk = ~clk;
    end

    // Instancia a DUT
    RD_CONTROL dut1 
    (.txbusy(txbusy), 
    .start_rd(start_rd),
    .clk(clk), 
    .rst(rst),
    .txena(txena),
    .load_txregs(load_txregs),
    .shift_txregs(shift_txregs),
    .done_rd(done_rd),
    .rd_leds(rd_leds));

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
        txbusy = 1'b1;   
        start_rd = 1'b0;
        
        //Simulacion de proceso de lectura

        #(10*PER);
        start_rd = 1'b1;
        RESET();
        
        repeat(11) 
        begin
            #(20*PER);
            READ();   //simular con ciclos justos al igual que haria el puerto serie  
        end

        #(20*PER);
        txbusy = 1'b0;
        
        #(10*PER);
        start_rd = 0;
        
        $stop;
        
    end

    task READ();
    begin
        txbusy = 1'b0;
        #(1*PER);
        txbusy = 1'b1;
    end
    endtask

endmodule
*/