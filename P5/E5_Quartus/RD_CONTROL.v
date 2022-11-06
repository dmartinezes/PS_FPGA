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
	reg [2:0] state;
	parameter [2:0] inicial = 3'b000, carga = 3'b001, transmision = 3'b010, desplaza = 3'b011, espera = 3'b100, fin_desplaza = 3'b101;

	reg [3:0] count;
	reg cont_enable;

	initial begin
		count = 0;
	end

	//Contador hasta 11
	always @(posedge clk) begin 

		if(cont_enable) begin 

			count <= count + 1;

		end

		if (count >= 11) begin

			count <= 0;

		end
	end

	//Definimos la memoria de estado
	always @(posedge clk) begin
		if (rst)
		state <= inicial;
		else begin
			case (state)

				inicial:
					if (start_rd == 1)
						state <= carga;
					else
						state <= inicial;

				carga: 
				if (txbusy == 0)
					state <= transmision;
				else 
					state <= carga;

				transmision:
					if (count < 10)
						state <= desplaza;
					else
						state <= espera;
					
				desplaza: 
					state <= espera;

				espera:
					if (count >= 11)
						state <= fin_desplaza;
					else if (txbusy == 0)
						state <= transmision;
					else 
						state <= espera;

				fin_desplaza:
					state <= inicial;

				default: 
					state <= inicial;


			endcase
		end
	end


	always @(state) begin
		case (state)

		inicial: begin
			cont_enable = 0;
			txena = 0;
			load_txregs = 0;
			shift_txregs = 0;
			done_rd = 0;
			rd_leds = 0;
		end

		carga: begin
			cont_enable = 0;
			txena = 0;
			load_txregs = 1;
			shift_txregs = 0;
			done_rd = 0;
			rd_leds = 1;
		end

		transmision: begin
			cont_enable = 1;
			txena = 1;
			load_txregs = 0;
			shift_txregs = 0;
			done_rd = 0;
			rd_leds = 2;
		end

		desplaza: begin
			cont_enable = 0;
			txena = 0;
			load_txregs = 0;
			shift_txregs = 1;
			done_rd = 0;
			rd_leds = 3;
		end

		espera: begin
			cont_enable = 0;
			txena = 0;
			load_txregs = 0;
			shift_txregs = 0;
			done_rd = 0;
			rd_leds = 4;
		end

		fin_desplaza: begin
			cont_enable = 0;
			txena = 0;
			load_txregs = 0;
			shift_txregs = 0;
			done_rd = 1;
			rd_leds = 5;
		end

		endcase
	end

endmodule 