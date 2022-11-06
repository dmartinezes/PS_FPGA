`timescale 1ns/1ps

module TB_DDS_test();
// CONFIGURABLE PARAMETERS ///////////////////////////////////
parameter M = 27;
parameter L = 15;
parameter W = 14;
// END CONFIGURABLE PARAMETERS ///////////////////////////////

parameter PER=10; // CLOCK PERIOD

reg [M-1:0] P;
reg rst_ac, ena_ac;
reg clk;
reg val_in;
wire val_out;
wire signed [W-1:0] sin_wave;
wire signed [W-1:0] ramp_wave;
wire signed [W-1:0] sqr_wave;
reg signed [W-1:0] sin_wave_M, sin_wave_F;
reg signed [W-1:0] ramp_wave_M, ramp_wave_F;
reg signed [W-1:0] sqr_wave_M, sqr_wave_F;

// contadores y control
integer error_cnt; // contador de errores
integer sample_cnt; // contador de muestras
reg end_sim; // Indicación de simulación on/off

// Gestion O texto
integer conf_in_file;
integer data_conf;
integer scan_data_conf;
integer data_out_file;
integer scan_data_out;
integer dout_waves;

always #(PER/2) clk = !clk&end_sim;
 
DDS_test #(.M(M),.L(L),.W(W)) UUT 
			(.P(P),
			.val_in(val_in),
			.rst_ac(rst_ac),
			.ena_ac(ena_ac),
			.clk(clk),
			.sqr_wave(sqr_wave),
			.ramp_wave(ramp_wave),
			.sin_wave(sin_wave),
			.val_out(val_out)
			);

initial	
	begin
		conf_in_file = $fopen("config_Pe_DDS.txt", "r");
		data_out_file = $fopen("out_waves.txt", "r");
		scan_data_conf = $fscanf(conf_in_file, "%d\n", data_conf);
		P = data_conf;
		end_sim = 1'b1;
		error_cnt = 0;
		sample_cnt = 0;
		clk = 1'b1;
		val_in = 1'b0;
		rst_ac = 1'b1;
		ena_ac = 1'b0;
		#(10*PER);
		rst_ac = 1'b0;
		val_in = 1'b1;
		ena_ac = 1'b1;
		
	end

// Proceso de lectura de salida 
always@(posedge clk)
       if (val_out)
			begin
				sample_cnt = sample_cnt +1;
				if (!$feof(data_out_file))
					begin
					scan_data_out = $fscanf(data_out_file, "%b", dout_waves);						
					sin_wave_F <= #(PER/10) dout_waves; //Salida del fichero
					sin_wave_M <= #(PER/10) sin_wave; //Salida del modulo
					scan_data_out = $fscanf(data_out_file, "%b", dout_waves);	
					ramp_wave_F <= #(PER/10) dout_waves; //Salida del fichero
					ramp_wave_M <= #(PER/10) ramp_wave; //Salida del modulo					
					scan_data_out = $fscanf(data_out_file, "%b\n", dout_waves);
					sqr_wave_F <= #(PER/10) dout_waves; //Salida del fichero
					sqr_wave_M <= #(PER/10) sqr_wave; //Salida del modulo					
					end
				else
					end_sim = #(5*PER) 1'b0;
			end

// Contador de errores y muestras
always@(sin_wave_F,sin_wave_M,ramp_wave_F,ramp_wave_M,sqr_wave_F,sqr_wave_M)
		if (sin_wave_F!=sin_wave_M || ramp_wave_F!=ramp_wave_M || sqr_wave_F!=sqr_wave_M)
			begin
				error_cnt = error_cnt + 1;
				$display("Error in sample number ","%d", sample_cnt);
			end   

// Fin de simulación
always@(end_sim)
	if (!end_sim)
		begin
			$display("Number of checked samples ","%d", sample_cnt);	
			$display("Number of errors ","%d", error_cnt);
			#(PER*2) $stop;
		end
endmodule 