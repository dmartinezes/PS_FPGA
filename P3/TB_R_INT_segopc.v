`timescale 1ns / 1ps

module TB_R_INT;

    // CLOCK PERIOD
	parameter PER=10; 

	// Estimulos
    localparam Win = 19;

	reg signed [Win-1:0] data_in;
	reg clk;
	reg rst;
	reg val_in;

    // Monitorizacion
	wire val_out;
	wire signed [Win-1:0] data_out;
	reg signed [Win-1:0] data_out_M, data_out_F;

    // contadores y control
    integer error_cnt; // contador de errores
    integer sample_cnt; // contador de muestras
    reg load_data;  // Inicio de lectura de datos 
    reg end_sim; // Indicación de simulación on/off

    // Gestion I/O texto
    integer datain_r_int_file, datain_r_int, scan_datain;       //data in COMB
    integer dataout_r_int_file, dataout_r_int, scan_dataout;    //data out COMB

    // clock
    always #(PER/2) clk = !clk&end_sim;

    // Instancia a DUT
    R_INT #(.Win(Win)) ri1
    (.data_in(data_in), 
    .clk(clk), 
    .rst(rst), 
    .val_in(val_in), 
    .val_out(val_out), 
    .data_out(data_out));
    
    initial begin
        datain_r_int_file = $fopen("idata_r_int.txt", "r");
        dataout_r_int_file = $fopen("odata_r_int.txt", "r");


        clk = 1'b1;
        rst = 1'b1;
        val_in = 1'b0;
        sample_cnt = 0;
		error_cnt = 0;
        load_data = 0;
        end_sim = 1'b1;
        #(10*PER);
        //load_data <= 1;
        
        repeat(51) 
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

			scan_datain = $fscanf(datain_r_int_file, "%b\n", datain_r_int);
			data_in <= #(PER/10) datain_r_int;

            //repeat (1999) @(posedge clk);

			if ($feof(datain_r_int_file))
			begin
				val_in <= #(PER+PER/10)  1'b0;
				load_data <= #(PER/10) 1'b0;
				end_sim = #(5*PER) 1'b0;
				#(4*PER) $stop;
			end
		end
        //else val_in = 0;
	end

    // Proceso de lectura de datos de salida
	always@(posedge clk)
	begin
		if (val_in)
		begin
			sample_cnt = sample_cnt +1;
			if (!$feof(dataout_r_int_file))
				begin
					scan_dataout = $fscanf(dataout_r_int_file, "%b\n", dataout_r_int);
					data_out_F <= #(PER/10) dataout_r_int;
				end
		end
        if (val_out)
		begin
            begin
                data_out_M <= #(PER/10) data_out;
            end
		end
        else data_out_M <= 0;
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

