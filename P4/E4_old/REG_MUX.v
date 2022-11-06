


module REG_MUX
#(parameter Win=16, // Cuantificación de la entrada y salida
  parameter Num_coef = 17) // Numero de datos a procesar
  (input  signed [Win-1:0] din  , // entrada
   input  [log2(Num_coef)-1:0] sel, // selector del mux
   input  clk, 
   input ce,
   output reg signed [Win-1:0] dout); // salida 

  reg [Win-1:0] reg_array[Num_coef-1:0];
  always @(posedge clk) begin

    if (ce == 1'b1) begin
        reg_array[Num_coef-1:0] <= {din, reg_array[Num_coef-1:1]}; //desplaz a la derecha
        //dout[Win-1:0] <= din[Win-1:0]}; //diap 4 pdf arrays memoria verilog
    end

    case (sel)
    begin
      /*
      for(i=0; i<Num_coef; i=i+1) begin
        log2(Num_coef)'d(i) : dout = reg_array[i];
      end
      default: dout = reg_array[0];
      */
      log2(Num_coef)'d0 : dout = reg_array[0];
      log2(Num_coef)'d1 : dout = reg_array[1];
      log2(Num_coef)'d2 : dout = reg_array[2];
      log2(Num_coef)'d3 : dout = reg_array[3];
      log2(Num_coef)'d4 : dout = reg_array[4];
      log2(Num_coef)'d5 : dout = reg_array[5];
      log2(Num_coef)'d6 : dout = reg_array[6];
      log2(Num_coef)'d7 : dout = reg_array[7];
      log2(Num_coef)'d8 : dout = reg_array[8];
      log2(Num_coef)'d9 : dout = reg_array[9];
      log2(Num_coef)'d10 : dout = reg_array[10];
      log2(Num_coef)'d11 : dout = reg_array[11];
      log2(Num_coef)'d12 : dout = reg_array[12];
      log2(Num_coef)'d13 : dout = reg_array[13];
      log2(Num_coef)'d14 : dout = reg_array[14];
      log2(Num_coef)'d15 : dout = reg_array[15];
      log2(Num_coef)'d16 : dout = reg_array[16];
      default: dout = reg_array[0];
    end

  end

 function integer log2;
   input integer value;
   begin
     value = value-1;
     for (log2=0; value>0; log2=log2+1)
       value = value>>1;
   end
 endfunction
endmodule
			

   