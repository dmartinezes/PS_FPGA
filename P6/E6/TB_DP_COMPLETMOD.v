`timescale 1ns / 1ps

module TB_DP_COMPLETMOD;

    // CLOCK PERIOD
	parameter PER=10; 

	// Estimulos
	reg signed [15:0] i_data;
    reg rst;
	reg clk;
	reg val_in;
    reg c_fm_am;
    reg [1:0] c_source;
    reg c_comp_dac;
    reg [23:0] frec_mod;
    reg [23:0] frec_por;
    reg [15:0] im_am;
    reg [15:0] im_fm;

    // Monitorizacion
    wire signed [13:0] o_data;
	wire val_out;

    // contadores y control
    integer error_cnt; // contador de errores
    integer sample_cnt; // contador de muestras
    reg load_data;  // Inicio de lectura de datos 
    reg end_sim; // Indicación de simulación on/off

    // Gestion I/O texto
    integer dout_file, scan_dout;    
	reg signed [13:0] o_data_out; 
    reg signed [13:0] dout_M, dout_F;

    // clock
    always #(PER/2) clk = !clk&end_sim;

    // Instancia a DUT
    DP_COMPLETMOD dp_completmod
	(
	.i_data(i_data),
	.rst(rst),
	.clk(clk),
	.val_in(val_in),
	.c_fm_am(c_fm_am), // Control modo fm/am
	.c_source(c_source), // Selecccion fuente  de señal moduladora
	.c_comp_dac(c_comp_dac), // Control multiplexor de compensación DAC
	.frec_mod(frec_mod),
	.frec_por(frec_por),
	.im_am(im_am),
	.im_fm(im_fm),
	.o_data(o_data),
	.val_out(val_out)
	);

    initial begin
        dout_file = $fopen("out_waves_am.txt", "r"); // AM Modulation
		//dout_file = $fopen("out_waves_fm.txt", "r"); // FM Modulation

        clk = 1'b1;
        rst = 1'b1;
        val_in = 1'b0;
        sample_cnt = 0;
		error_cnt = 0;
        end_sim = 1'b1;

        #(10*PER);

        c_fm_am = 0;
        c_source = 0;
        frec_mod = 335544;
        frec_por = 167772;
        im_am = 32767;
        im_fm = 3277;

        #(10*PER);

        //val_in = 1'b1;
        //rst = 1'b0;

		repeat(200001) 
        begin
            load_data = 1;
            #(1*PER);  
            load_data = 0;
            #(1999*PER);
        end

    end

	always @(posedge clk) begin
		if(load_data) begin
			val_in = 1'b1;
			rst = 1'b0;
		end
		else
			val_in = 1'b0;
	end

// Proceso de lectura de datos de salida
	always@(posedge clk)
	begin
		if (val_out)
		begin
			sample_cnt = sample_cnt +1;
			if (!$feof(dout_file))
            begin
                scan_dout = $fscanf(dout_file, "%b\n", o_data_out);
                dout_F <= #(PER/10) o_data_out;
                dout_M <= #(PER/10) o_data;
            end
            else
            begin
				val_in <= #(PER+PER/10)  1'b0;
				end_sim = #(5*PER) 1'b0;
				#(4*PER) $stop;
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