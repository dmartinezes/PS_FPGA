`timescale 1ns / 1ps

module TB_SEC_FILTER;

    // CLOCK PERIOD
	parameter PER=10; 

	// Estimulos
    localparam Win = 16;
    localparam Wc = 18;
    localparam Num_coef = 17;

	reg signed [Win-1:0] din;
	reg clk;
	reg rst;
	reg val_in;

    // Monitorizacion
	wire val_out;

	//wire signed [(Win+Wc)-1:0] dout;			// salida precision completa
	//reg signed [(Win+Wc)-1:0] dout_M, dout_F;	// salida precision completa

	wire signed [Win+2:0] dout;			// salida truncada a 19 bits
	reg signed [Win+2:0] dout_M, dout_F; // salida truncada a 19 bits

    // contadores y control
    integer error_cnt; // contador de errores
    integer sample_cnt; // contador de muestras
    reg load_data;  // Inicio de lectura de datos 
    reg end_sim; // Indicación de simulación on/off

    // Gestion I/O texto
    integer din_file, datain_din, scan_din;       //data in COMB
    integer dout_file, scan_dout;    //data out COMB
	
	//reg signed [(Win+Wc)-1:0] dataout_dout;  // salida precision completa
	reg signed [Win+2:0] dataout_dout;  // salida truncada a 19 bits

    // clock
    always #(PER/2) clk = !clk&end_sim;

    // Instancia a DUT
    SEC_FILTER DUT
    (.din(din), 
    .clk(clk), 
    .val_in(val_in),
    .rst(rst),  
    .val_out(val_out), 
    .dout(dout));
    
    initial begin
        din_file = $fopen("C:/Users/Usuario/Desktop/Procesado_Digital_de_la_Senyal_en_FPGA/P4/E4_Quartus/s_FC_CIC_in.txt", "r");
        dout_file = $fopen("C:/Users/Usuario/Desktop/Procesado_Digital_de_la_Senyal_en_FPGA/P4/E4_Quartus/s_FC_CIC_out1.txt", "r");


        clk = 1'b1;
        rst = 1'b1;
        val_in = 1'b0;
        sample_cnt = 0;
		error_cnt = 0;
        load_data = 0;
        end_sim = 1'b1;
        #(10*PER);
        //load_data <= 1;
        repeat(101) 
        begin
            load_data = 1;
            #(1*PER);  
            load_data = 0;
            #(1999*PER);
        end
    end

    // Proceso de lectura de datos de entrada 
	always@(posedge clk)
	begin
		if (load_data) begin	

			rst <= 1'b0;
			val_in <= 1'b1;

			scan_din = $fscanf(din_file, "%b\n", datain_din);
			din <= #(PER/10) datain_din;

			if ($feof(din_file))
			begin
				val_in <= #(PER+PER/10)  1'b0;
				load_data <= #(PER/10) 1'b0;
				end_sim = #(5*PER) 1'b0;
				#(4*PER) $stop;
			end
		end
		else 
			val_in <= 0;
	end

    // Proceso de lectura de datos de salida
	always@(posedge clk)
	begin
		if (val_out)
		begin
			sample_cnt = sample_cnt +1;
			if (!$feof(dout_file))
				begin
					scan_dout = $fscanf(dout_file, "%b\n", dataout_dout);
					dout_F <= #(PER/10) dataout_dout;
					dout_M <= #(PER/10) dout;
				end
		end
	end

    // Contador de errores y muestras
	always@(dout_F,dout_M)
	begin
		if (dout_F != dout_M)
			begin
				error_cnt = error_cnt + 1;
				$display("Error in sample number ","%d", sample_cnt);
			end   
	end	

	// Fin de simulación
	always@(end_sim)
	begin
		if (!end_sim)
		begin
			$display("Number of checked samples ","%d", sample_cnt);	
			$display("Number of errors ","%d", error_cnt);
		end
	end

endmodule


