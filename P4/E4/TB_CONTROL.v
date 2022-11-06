`timescale 1ns / 1ps

module TB_CONTROL;

    // CLOCK PERIOD
	parameter PER=10; 

	// Estimulos
    localparam Num_coef = 17;
	reg clk;
	reg rst;
	reg val_in;

    // Monitorizacion
    wire [log2(Num_coef)-1:0] addr;
    wire ce_Reg;
    wire rst_Acc;
    wire ce_Acc;

    // clock
    always begin
        #(PER/2) clk = ~clk;
    end

    // Instancia a DUT
    CONTROL #(.Num_coef(Num_coef)) dut1
    (.val_in(val_in), 
    .clk(clk), 
    .rst(rst),
    .addr(addr),
    .ce_Reg(ce_Reg),
    .rst_Acc(rst_Acc),
    .ce_Acc(ce_Acc));
    
    initial begin

        clk = 1'b1;
        rst = 1'b1;
        val_in = 1'b0;

        #(10*PER);
        rst = #(PER/10) 1'b0;
        val_in = 1'b1;

        #(500*PER) $stop;
        
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