module SEC_FILTER
#(parameter Win=16,    // Cuantificacion de la entrada y salida
  parameter Wc = 18,   // Cuantificacion coeficientes
  parameter Num_coef=17)   // Numero de coeficientes
  (input  signed [Win-1:0] din, // entrada
   input  clk, 
   input val_in,
   input rst,
   output reg val_out,
   output reg signed [Win+Wc-1:0] dout); // salida precision completa
   //output reg signed [Win+2:0] dout); // salida truncada a 19 bits


	 
endmodule