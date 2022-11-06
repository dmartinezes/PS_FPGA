module RD_CONTROL
(
	input txbusy,
	input start_rd,
	input rst, 
	input clk,
	output reg txena,
	output reg load_txregs,
	output reg shift_txregs,
	output reg done_rd,
	output reg [2:0] rd_leds
	);

	//Definición de estados
  	//Binario natural
	reg [1:0] state;
	parameter [1:0] carga = 2'b00, registro_salida = 2'b01, espera = 2'b10, fin_registro_salida = 2'b11;

	reg [3:0] count;
	reg cont_enable;

	initial begin
		count = 0;
	end

	//Contador hasta 11
	always @(posedge clk) begin 

		if(cont_enable) begin 

			count <= count + 1;
			
			if (count >= 11) begin
				count <= 0;
			end

		end
	end

	//Definimos la memoria de estado
	always @(posedge clk or posedge rst) begin
		if (rst)
		state <= carga;
		else begin
			case (state)

				carga: 
				if (txbusy == 0 && start_rd == 1)
					state <= registro_salida;
					
				registro_salida: 
				begin
					if (txbusy == 1 && count < 10)
						state <= espera;
					else if (count >= 10)
						state <= fin_registro_salida;
				end

				espera:
					if (txbusy == 0)
						state <= registro_salida;

				fin_registro_salida:
					state <= carga;

			endcase
		end
	end


	always @(state, txbusy, start_rd) begin
		case (state)

		carga: begin
			cont_enable = 0;
			txena = 0;
			load_txregs = 1;
			shift_txregs = 0;
			done_rd = 0;
			rd_leds = 0;
		end

		registro_salida: begin
			cont_enable = 1;
			txena = 1;
			load_txregs = 0;
			shift_txregs = 1;
			done_rd = 0;
			rd_leds = 1;
		end

		espera: begin
			cont_enable = 0;
			txena = 0;
			load_txregs = 0;
			shift_txregs = 0;
			done_rd = 0;
			rd_leds = 2;
		end

		fin_registro_salida: begin
			cont_enable = 0;
			txena = 0;
			load_txregs = 0;
			shift_txregs = 0;
			done_rd = 1;
			rd_leds = 3;
		end

		endcase
	end

endmodule 

/*
module RD_CONTROL
(
	input txbusy,
	input start_rd,
	input rst, 
	input clk,
	output reg txena,
	output reg load_txregs,
	output reg shift_txregs,
	output reg done_rd,
	output reg [2:0] rd_leds
	);

	//Definición de estados
  	//Binario natural
	reg [1:0] state;
	parameter [1:0] carga = 2'b00, registro_salida = 2'b01, espera = 2'b10, fin_registro_salida = 2'b11;

	reg [3:0] count;
	reg cont_enable;

	initial begin
		count = 0;
	end

	//Contador hasta 11
	always @(posedge clk) begin 

		if(cont_enable) begin 

			count <= count + 1;
			
			if (count >= 11) begin
				count <= 0;
			end

		end
	end

	//Definimos la memoria de estado
	always @(posedge clk or posedge rst) begin
		if (rst)
		state <= carga;
		else begin
			case (state)

				carga: 
				if (txbusy == 0 && start_rd == 1)
					state <= registro_salida;
					
				registro_salida: 
				begin
					if (txbusy == 1 && count < 11)
						state <= espera;
					else if (count >= 11)
						state <= fin_registro_salida;
				end

				espera:
					if (txbusy == 0)
						state <= registro_salida;

				fin_registro_salida:
					state <= espera;

			endcase
		end
	end


	always @(state, txbusy, start_rd) begin
		case (state)

		carga: begin
			cont_enable = 0;
			txena = 0;
			load_txregs = 1;
			shift_txregs = 0;
			done_rd = 0;
			rd_leds = 0;
		end

		registro_salida: begin
			cont_enable = 1;
			txena = 1;
			load_txregs = 0;
			shift_txregs = 1;
			done_rd = 0;
			rd_leds = 1;
		end

		espera: begin
			cont_enable = 0;
			txena = 0;
			load_txregs = 0;
			shift_txregs = 0;
			done_rd = 0;
			rd_leds = 2;
		end

		fin_registro_salida: begin
			cont_enable = 0;
			txena = 0;
			load_txregs = 0;
			shift_txregs = 0;
			done_rd = 1;
			rd_leds = 3;
			count = 0;
		end

		endcase
	end

endmodule 
*/