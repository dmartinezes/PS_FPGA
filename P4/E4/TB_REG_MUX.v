`timescale 1ns / 1ps

module TB_REG_MUX;

    // CLOCK PERIOD
	parameter PER=10; 

	// Estimulos
    localparam Win = 16;
    localparam Num_coef = 17;

	//reg signed [Win-1:0] din;
	reg clk;
	reg rst;
	reg val_in;

    // Monitorizacion
	wire signed [Win-1:0] dout;
    reg [log2(Num_coef)-1:0] sel, sel_reg1;

    reg signed [Win-1:0] count;

    // clock
    always begin
        #(PER/2) clk = ~clk;
    end

    // Instancia a DUT
    REG_MUX #(.Win(Win), .Num_coef(Num_coef)) dut1
    (.din(count), 
    .sel(sel_reg1),
    .clk(clk), 
    .ce(val_in),  
    .dout(dout));
    
    initial begin

        clk = 1'b1;
        rst = 1'b1;
        val_in = 1'b0;
        count = 0;
        sel = 0;   
        sel_reg1 = 0;

        #(10*PER);
        rst = 1'b0;

        #(500*PER) $stop;
        
    end
    
    always @(posedge clk) begin
        if(!rst) begin

            sel_reg1 <= sel; //Primero entra dato Din y se tarda un ciclo 
                            //en asignarlo a reg_array[0] y desplazar el resto,
                            // en ese 2o ciclo sel debe apuntar a ese Din 

            sel <= sel + 1;
            if(sel >= (Num_coef - 1)) begin
                sel <= 0;
                val_in <= 1;
            end
            else 
                val_in <= 0;

            //valor aleatorio en entrada Din:
            count <= count + 1; 

            if(count == 25) begin
                count <= 0;
            end    

        end
        else begin
            val_in <= 0;
            count <= 0;
            sel <= 0;
        end
    end






    function integer log2;
        input integer value;
        begin
            value = value-1;
            for (log2=0; value>0; log2=log2+1)
                value = value>>1;
        end
    endfunction

endmodule