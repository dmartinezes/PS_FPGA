`timescale 1ns / 1ps

module TB_INT;

    // CLOCK PERIOD
	parameter PER=10; 

	// Estimulos
    localparam Win = 38;
    localparam Wg = 0;

	reg signed [Win-1:0] data_in;
	reg clk;
	reg rst;
	reg val_in;

    // Monitorizacion
	wire val_out;
	wire signed [Win+Wg-1:0] data_out;
	reg signed [Win+Wg-1:0] data_out_M, data_out_F;

    // contadores y control
    integer error_cnt; // contador de errores
    integer sample_cnt; // contador de muestras
    reg load_data;  // Inicio de lectura de datos 
    reg end_sim; // Indicación de simulación on/off

    // Gestion I/O texto
    integer datain_int1_file, datain_int1, scan_datain;       //data in COMB
    integer dataout_int1_file, dataout_int1, scan_dataout;    //data out COMB

    // clock
    always #(PER/2) clk = !clk&end_sim;

    // Instancia a DUT
    INT #(.Win(Win), .Wg(Wg)) c1
    (.data_in(data_in), 
    .clk(clk), 
    .rst(rst), 
    .val_in(val_in), 
    .val_out(val_out), 
    .data_out(data_out));
    
    initial begin
        datain_int1_file = $fopen("idata_int1.txt", "r");
        dataout_int1_file = $fopen("odata_int1.txt", "r");


        clk = 1'b1;
        rst = 1'b1;
        val_in = 1'b0;
        sample_cnt = 0;
		error_cnt = 0;
        load_data = 0;
        end_sim = 1'b1;
        #(10*PER);
        load_data <= 1;
    end

    // Proceso de lectura de datos de entrada 
	always@(posedge clk)
	begin
		if (load_data) begin	

			rst <= 1'b0;
			val_in <= 1'b1;

			scan_datain = $fscanf(datain_int1_file, "%b\n", datain_int1);
			data_in <= #(PER/10) datain_int1;

			if ($feof(datain_int1_file))
			begin
				val_in <= #(PER+PER/10)  1'b0;
				load_data <= #(PER/10) 1'b0;
				end_sim = #(5*PER) 1'b0;
				#(4*PER) $stop;
			end
		end
	end

    // Proceso de lectura de datos de salida
	always@(posedge clk)
	begin
		if (val_out)
		begin
			sample_cnt = sample_cnt +1;
			if (!$feof(dataout_int1_file))
				begin
					scan_dataout = $fscanf(dataout_int1_file, "%b\n", dataout_int1);
					data_out_F <= #(PER/10) dataout_int1;
					data_out_M <= #(PER/10) data_out;
				end
		end
	end

    // Contador de errores y muestras
	always@(data_out_F,data_out_M)
	begin
		if (data_out_F != data_out_M)
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
