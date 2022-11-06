`timescale 1ns / 1ps

module mult_add_tb;
// CLOCK PERIOD
parameter PER=10; 

// Estimulos
reg signed [7:0] a,b,c;
reg clk;
reg val_in;

// Monitorizacion
wire signed [15:0] s;
reg signed [15:0] s_M, s_F;
wire rdy_out;

// contadores y control
integer error_cnt; // contador de errores
integer sample_cnt; // contador de muestras
reg load_data;  // Inicio de lectura de datos 
reg end_sim; // Indicación de simulación on/off

// Gestion I/O texto
integer data_in_file,data_out_file;
integer scan_data_in, scan_data_out;
integer din_file_a,din_file_b,din_file_c, dout_file;


// clock
 always #(PER/2) clk = !clk&end_sim;
 
// Instancia a uut
	mult_add uut 
		(
		.a(a), 
		.b(b), 
		.c(c),
		.clk(clk),
		.val_in(val_in),
		.s(s),
		.rdy_out(rdy_out)
		);

// Proceso initial
initial begin
    data_in_file = $fopen("datos_in.txt", "r");
    data_out_file = $fopen("datos_out.txt", "r");
	clk = 1'b1;
	val_in = 1'b0;
	sample_cnt = 0;
    error_cnt = 0;
	load_data = 0;
	end_sim = 1'b1;
	#(5*PER);
	load_data = 1;
   end      
   
// Proceso de lectura de datos de entrada
always@(posedge clk)
     if (load_data)
         begin
             scan_data_in = $fscanf(data_in_file, "%b %b %b\n", din_file_a, din_file_b, din_file_c);
             a <= #(PER/10)  din_file_a;
             b <= #(PER/10)  din_file_b;
             c <= #(PER/10)  din_file_c;
             val_in <= #(PER/10)  1'b1;
             if ($feof(data_in_file))
				begin
					val_in <= #(PER+PER/10)  1'b0;
					load_data <= #(PER/10) 1'b0;
					end_sim = #(5*PER) 1'b0;
					#(4*PER) $stop;
				end
         end
		 
// Proceso de lectura de salida 
always@(posedge clk)
       if (rdy_out)
			begin
				sample_cnt = sample_cnt +1;
				if (!$feof(data_out_file))
					begin
						scan_data_out = $fscanf(data_out_file, "%b\n", dout_file);
						s_F <= #(PER/10) dout_file;
						s_M <= #(PER/10) s;
					end
			end
			
// Contador de errores y muestras
always@(s_F,s_M)
    begin
	   if (s_F != s_M)
			begin
				error_cnt = error_cnt + 1;
				$display("Error in sample number ","%d", sample_cnt);
			end   
	end	
	
// Fin de simulación
always@(end_sim)
	if (!end_sim)
		begin
			$display("Number of checked samples ","%d", sample_cnt);	
			$display("Number of errors ","%d", error_cnt);
		end

endmodule

