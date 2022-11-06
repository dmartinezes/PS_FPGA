module ROM
#(parameter Wc = 18,  // Cuantificacion de los coeficientes y Numero de coef.
  parameter Num_coef = 17)  //  Numero de coef.
( input [log2(Num_coef)-1:0] addr,  // direccionamiento de la memoria
  input clk,
  output reg signed [Wc-1:0] data); // salida 
  
  reg signed [Wc-1:0] rom[Num_coef-1:0];

  initial
    begin
      $readmemb("C:/Users/Usuario/Desktop/Procesado_Digital_de_la_Senyal_en_FPGA/P4/E4_Quartus/coef.txt", rom);
    end
  always @ (posedge clk)
    data <= rom[addr];

 function integer log2;
   input integer value;
   begin
     value = value-1;
     for (log2=0; value>0; log2=log2+1)
       value = value>>1;
   end
 endfunction
endmodule