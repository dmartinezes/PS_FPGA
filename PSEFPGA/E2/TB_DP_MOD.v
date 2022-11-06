`timescale 1ns / 1ps

module TB_DP_MOD;
// CLOCK PERIOD
parameter PER=10; 

// Estimulos
reg signed [15:0] i_data;
reg clk;
reg rst;
reg val_in;
reg c_fm_am;
reg [23:0] frec_por;
reg [15:0] im_am;
reg [15:0] im_fm;

// Monitorizacion
wire val_out;
wire signed [15:0] o_data;
reg signed [15:0] o_data_M, o_data_F;

// contadores y control
integer error_cnt; // contador de errores
integer sample_cnt; // contador de muestras
reg load_data;  // Inicio de lectura de datos 
reg end_sim; // Indicación de simulación on/off

// Gestion I/O texto
integer conf_param_file, data_conf_frecpor, data_conf_imfm, data_conf_imam, data_conf_control, scan_data_param; //configuracion
integer conf_idata_file, data_conf_idata, scan_data_idata; //i_data
integer data_out_file_FM, scan_data_odata_FM, dout_FM; //o_data_FM
integer data_out_file_AM, scan_data_odata_AM, dout_AM; //o_data_AM

// clock
always #(PER/2) clk = !clk&end_sim;
 
// Instancia a DUT
DP_MOD D1 
	(.i_data(i_data),
	.rst(rst),
	.clk(clk),
	.val_in(val_in),
	.c_fm_am(c_fm_am), // Control modo fm/am
	.frec_por(frec_por),
	.im_am(im_am),
	.im_fm(im_fm),
	.o_data(o_data),
	.val_out(val_out)
	);

initial
begin
    conf_idata_file = $fopen("in_waves_idata.txt", "r");                 //Abrir fichero entrada
    data_out_file_FM = $fopen("out_waves_fm", "r");                      //Abrir ficheros salida
    data_out_file_AM = $fopen("out_waves_am", "r");
	conf_param_file = $fopen("conf_data_in", "r");


    clk = 1'b1;
    rst = 1'b1;
	val_in = 1'b0;
	sample_cnt = 0;
    error_cnt = 0;
	load_data = 0;
	end_sim = 1'b1;
	#(10*PER);
	load_data = 1; //poner estos 3 dentro del always de lectura
    rst = 1'b0;
	val_in = 1'b1;
end

// Proceso de lectura de datos de configuracion
/*
always@(posedge clk)
begin
	scan_data_param = $fscanf(conf_param_file, "%b %b %b %b\n", data_conf_frecpor, data_conf_imfm, data_conf_imam, data_conf_control);
	frec_por <= #(PER/10) data_conf_frecpor;
	im_fm <= #(PER/10) data_conf_imfm;
	im_am <= #(PER/10) data_conf_imam;
	c_fm_am <= #(PER/10) data_conf_control;
	val_in <= #(PER/10)  1'b1;
	
	if ($feof(conf_param_file))
	begin
		val_in <= #(PER+PER/10)  1'b0;
		load_data <= #(PER/10) 1'b0;
		end_sim = #(5*PER) 1'b0;
		#(4*PER) $stop;
	end
end
*/

// Proceso de lectura de datos de configuracion y entrada 
always@(posedge clk)
begin
	if (load_data)
	begin

		scan_data_param = $fscanf(conf_param_file, "%b %b %b %b\n", data_conf_frecpor, data_conf_imfm, data_conf_imam, data_conf_control);
		frec_por <= #(PER/10) data_conf_frecpor;
		im_fm <= #(PER/10) data_conf_imfm;
		im_am <= #(PER/10) data_conf_imam;
		c_fm_am <= #(PER/10) data_conf_control;
		val_in <= #(PER/10)  1'b1;

		scan_data_idata = $fscanf(conf_idata_file, "%b\n", data_conf_idata);
		i_data = data_conf_idata;

		if ($feof(conf_idata_file))
		begin
			val_in <= #(PER+PER/10)  1'b0;
			load_data <= #(PER/10) 1'b0;
			end_sim = #(5*PER) 1'b0;
			#(4*PER) $stop;
		end
	end
end
// Proceso de lectura de datos de salida FM
always@(posedge clk)
begin
	if (load_data)
	begin
		sample_cnt = sample_cnt +1;
		if (!$feof(data_out_file_FM))
			begin
				scan_data_odata_FM = $fscanf(data_out_file_FM, "%b\n", dout_FM);
				o_data_F <= #(PER/10) dout_FM;
				o_data_M <= #(PER/10) o_data;
			end
	end
end
// Proceso de lectura de datos de salida AM
always@(posedge clk)
begin
	if (load_data)
	begin
		sample_cnt = sample_cnt +1;
		if (!$feof(data_out_file_AM))
			begin
				scan_data_odata_AM = $fscanf(data_out_file_AM, "%b\n", dout_AM);
				o_data_F <= #(PER/10) dout_AM;
				o_data_M <= #(PER/10) o_data;
			end
	end
end


// Contador de errores y muestras
always@(o_data_F,o_data_M)
begin
	if (o_data_F != o_data_M)
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
