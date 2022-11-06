`timescale 1ns / 1ps

module TB_ROM;

    // CLOCK PERIOD
	parameter PER=10; 

	// Estimulos
    localparam Num_coef = 17;
    localparam Wc = 18;
	reg clk;
	reg rst;

    // Monitorizacion
    reg [log2(Num_coef)-1:0] addr;
    wire signed [Wc-1:0] data;

    // clock
    always begin
        #(PER/2) clk = ~clk;
    end

    // Instancia a DUT
    ROM #(.Num_coef(Num_coef), .Wc(Wc)) dut1
    (.addr(addr), 
    .clk(clk),
    .data(data));
    
    initial begin

        clk = 1'b1;
        rst = 1'b1;

        #(10*PER);
        rst = #(PER/10) 1'b0;
        addr = 0;

        #(500*PER) $stop;
        
    end

    always @(posedge clk) begin
        if (!rst) begin

            addr <= addr + 1;

            if (addr == Num_coef-1)
                addr <= 0;

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
