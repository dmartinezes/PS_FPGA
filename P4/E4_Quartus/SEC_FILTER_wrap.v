module SEC_FILTER_wrap
#(parameter Win=16,    // Cuantificacion de la entrada y salida
  parameter Wc = 18,   // Cuantificacion coeficientes
  parameter Num_coef=17)   // Numero de coeficientes
  (input  signed [Win-1:0] din, // entrada
   input  clk, 
   input val_in,
   input rst,
   output reg val_out,
   //output reg signed [Win+Wc-1:0] dout); // salida precision completa
   output reg signed [Win+2:0] dout); // salida truncada a 19 bits
	
	reg signed [Win-1:0] din_reg;
	reg val_in_reg;
	reg rst_reg;
	wire val_out_reg;
	wire signed [Win+2:0] dout_reg;
	
	 always @(posedge clk) begin 
		din_reg <= din;
		val_in_reg <= val_in;
		rst_reg <= rst;
		val_out <= val_out_reg;
		dout <= dout_reg;
	end 
	
	SEC_FILTER sec_filter 
	(.din(din_reg),
	.clk(clk),
	.rst(rst_reg),
	.val_in(val_in_reg),
	.val_out(val_out_reg),
	.dout(dout_reg));
	
endmodule 