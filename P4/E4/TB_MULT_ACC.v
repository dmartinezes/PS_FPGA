`timescale 1ns / 1ps

module TB_MULT_ACC;

    // CLOCK PERIOD
	parameter PER=10; 

	// Estimulos
    localparam Win = 16;
    localparam Wc = 18;
    localparam Num_coef = 17;

	reg signed [Win-1:0] din;
    reg signed [Wc-1:0] coef;
    reg signed [Wc-1:0] coef_array[Num_coef-1:0];
	reg clk;
	reg rst;
	reg val_in;
	wire signed [Win+Wc-1:0] dout;

    // Monitorizacion
    reg signed [Win-1:0] count;
    integer i;

    // Contadores y control 
    reg load_data;

    // Gestion I/O texto
    integer coefs_file, coefs, scan_coefs;  //filter coefs

    // clock
    always begin
        #(PER/2) clk = ~clk;
    end

    // Instancia a DUT
    MULT_ACC #(.Win(Win), .Wc(Wc)) dut1
    (.din(din), 
    .coef(coef),
    .clk(clk), 
    .rst(rst),  
    .ce(val_in),
    .dout(dout));

    initial begin

        coefs_file = $fopen("coef.txt", "r");

        clk = 1'b1;
        rst = 1'b1;
        val_in = 1'b0;
        load_data = 1'b0;
        din = 0;
        count = -1; 
        i = 0;
        for (i = Num_coef-1 ; i >= 0 ; i = i - 1)
        coef_array[i] <= {(Wc){1'b0}};

        #(10*PER);
        rst = #(PER/10) 1'b0;
        load_data = 1'b1;

        #(500*PER) $stop;
        
    end
    
    always @(posedge clk) begin
        if(load_data) begin

            //gestion fcihero coefs para repeticion en loop
            i <= i + 1;
            if (i == Num_coef-1) begin
                i <= 0;
            end

            if (!$feof(coefs_file)) begin
                scan_coefs = $fscanf(coefs_file, "%b\n", coefs);
			    coef_array[i] = #(PER/10) coefs;
            end
            
            coef <= coef_array[i];

            //valor aleatorio en entrada Din:
            din <= din + 1; 
            if(din == 25) begin
                din <= 0;
            end    

            //gestion del acumulador
            count <= count + 1;
            if (count >= Num_coef - 1) begin
                count <= 0;
                rst <= 1;
                val_in <= 0;
            end
            else begin 
                val_in <= 1;
                rst <= 0;    
            end

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
