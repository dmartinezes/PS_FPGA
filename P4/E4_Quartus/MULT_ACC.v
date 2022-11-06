
module MULT_ACC
#(parameter Win = 16,    		// Cuantificacion de la entrada y salida
  parameter Wc = 18) 		// Cuantificacion coeficientes
  (input  signed [Win-1:0] din  , // entrada
   input  signed [Wc-1:0] coef , // coeficiente
   input  clk, 
   input rst,                // reset del acumulador
   input ce,				// habiliatacion del acumulador
   output signed [Win+Wc-1:0] dout); // salida Win+Wc

  wire signed [Win+Wc-1:0] mult;
  assign mult = din * coef;

  reg signed [Win+Wc-1:0] acc_out;

  //salida acumulador
	always @(posedge clk)
	begin 
		if(rst)
			acc_out <= 0;
		else 
		begin
			if(ce==1)
				acc_out <= acc_out + mult;	
		end
	end

  assign dout = acc_out;
		
endmodule
			

   