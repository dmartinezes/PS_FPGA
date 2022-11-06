`timescale 1ns / 1ps

module TB_CIC;

    // CLOCK PERIOD
	parameter PER=10; 

	// Estimulos
    localparam Win = 16;
    localparam Wg = 22;

	reg signed [Win-1:0] data_in;
	reg clk;
	reg rst;
	reg val_in;

    // Monitorizacion
	wire val_out;
	wire signed [15:0] data_out; 
	reg signed [15:0] data_out_M, data_out_F;

    // contadores y control
    integer error_cnt; // contador de errores
    integer sample_cnt; // contador de muestras
    reg load_data;  // Inicio de lectura de datos 
    reg end_sim; // Indicación de simulación on/off
    reg load_data_out;

    // Gestion I/O texto
    integer datain_cic_file, datain_cic, scan_datain;       //data in COMB
    integer dataout_cic_file, scan_dataout;    //data out COMB
	reg signed [Win+Wg-1:0] dataout_cic;
	reg rst_reg1, rst_reg2, rst_reg3, rst_reg4, rst_reg5, rst_reg6;

    // clock
    always #(PER/2) clk = !clk&end_sim;

	CIC #(.Win(Win), .Wg(Wg)) cic
    (.i_data(data_in), 
    .clk(clk), 
    .rst(rst), 
    .val_in(val_in), 
    .val_out(val_out), 
    .o_data_trunc(data_out));
    
    initial begin
        datain_cic_file = $fopen("s_CIC_in.txt", "r");
		dataout_cic_file = $fopen("odata_trunc.txt", "r"); 


        clk = 1'b1;
        rst = 1'b1;
        val_in = 1'b0;
        sample_cnt = 0;
		error_cnt = 0;
        load_data = 0;
        end_sim = 1'b1;
        #(10*PER);
        
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

			scan_datain = $fscanf(datain_cic_file, "%d\n", datain_cic);
			data_in <= #(PER/10) datain_cic;

            //repeat (1999) @(posedge clk);

			if ($feof(datain_cic_file))
			begin
				val_in <= #(PER+PER/10)  1'b0;
				load_data <= #(PER/10) 1'b0;
				end_sim = #(5*PER) 1'b0;
				#(4*PER) $stop;
			end
		end
        else val_in <= 1'b0;
		rst_reg1 <= rst;
		rst_reg2 <= rst_reg1;
		rst_reg3 <= rst_reg2;
		rst_reg4 <= rst_reg3;
		rst_reg5 <= rst_reg4;
		rst_reg6 <= rst_reg5;
        load_data_out <= !rst_reg6;
	end

    // Proceso de lectura de datos de salida
	always@(posedge clk)
	begin
		if (load_data_out)
		begin
			sample_cnt = sample_cnt +1;
			if (!$feof(dataout_cic_file))
				begin
					scan_dataout = $fscanf(dataout_cic_file, "%b\n", dataout_cic);
					data_out_F <= #(PER/10) dataout_cic;
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


