module CIC_pc
#(parameter Win=16, // Input length
  parameter Wg=22)  // Guard bits

  (input signed [Win-1:0] i_data,  		// Data input
   input clk,
   input rst,
   input val_in,  						// Validation input
   output val_out,						// Validation output
   output signed [Win+Wg-1:0] o_data);	// Data output

	

	
	
	//// Insertar la descripción del modulo
	/*Este módulo implementa el filtro CIC en precisión completa. 
  Se trata del módulo TOP, el cual implementa 3 bloques COMB, 1 bloque RINT y 3 bloques INT
  para la implementacion del filtro de orden 3. */

  
  
  //Bloques COMB

  wire signed [(Win+1)-1:0] data_comb1;
  wire signed [(Win+2)-1:0] data_comb2;
  wire signed [(Win+3)-1:0] data_comb3;
  wire val_comb1, val_comb2, val_comb3;

  COMB #(.Win(Win)) comb1(.data_in(i_data),
                          .clk(clk),
                          .rst(rst),
                          .val_in(val_in),
                          .val_out(val_comb1),
                          .data_out(data_comb1));

  COMB #(.Win(Win+1)) comb2(.data_in(data_comb1),
                          .clk(clk),
                          .rst(rst),
                          .val_in(val_comb1),
                          .val_out(val_comb2),
                          .data_out(data_comb2));
                          
  COMB #(.Win(Win+2)) comb3(.data_in(data_comb2),
                          .clk(clk),
                          .rst(rst),
                          .val_in(val_comb2),
                          .val_out(val_comb3),
                          .data_out(data_comb3));

  //RINT
  //wire signed [Win+Wg-1:0] data_int [3:0];
  wire signed [Win+3-1:0] data_int1;
  wire signed [Win+Wg-1:0] data_int2;
  wire signed [Win+Wg-1:0] data_int3;
  wire val_int1, val_int2, val_int3;

  R_INT #(.Win(Win+3)) 
      RINT(.data_in(data_comb3),
          .clk(clk),
          .rst(rst),
          .val_in(val_comb3),
          .val_out(val_int1),
          .data_out(data_int1)); 
  
  //Bloques INT
  INT #(.Win(Win+Wg), .Wg(0)) int1(.data_in( { { (19){data_int1[18]} },data_int1[18:0] } ),
                          .clk(clk),
                          .rst(rst),
                          .val_in(val_int1),
                          .val_out(val_int2),
                          .data_out(data_int2));
  INT #(.Win(Win+Wg), .Wg(0)) int2(.data_in(data_int2),
                          .clk(clk),
                          .rst(rst),
                          .val_in(val_int2),
                          .val_out(val_int3),
                          .data_out(data_int3));
  INT #(.Win(Win+Wg), .Wg(0)) int3(.data_in(data_int3),
                          .clk(clk),
                          .rst(rst),
                          .val_in(val_int3),
                          .val_out(val_out),
                          .data_out(o_data));                                                

  /*
  Utilizando generate (no nos funciona)
  
  //Bloques COMB
  wire signed [(Win+3)-1:0] data_comb [3:0];

  assign data_comb[0] = i_data;
  wire val_comb [3:0];
  assign val_comb[0] = val_in;

  genvar i;
  generate
    for(i=0; i<3; i=i+1)
    begin : combs
      COMB #(.Win(Win+i))
          tab_comb(.data_in(data_comb[i]),
                  .clk(clk),
                  .rst(rst),
                  .val_in(val_comb[i]),
                  .val_out(val_comb[i+1]),
                  .data_out(data_comb[i+1]));
    end
  endgenerate
  
  //RINT
  wire signed [Win+Wg-1:0] data_int [3:0];
  wire val_int [3:0];

  R_INT #(.Win(19)) 
      RINT(.data_in(data_comb[3]),
          .clk(clk),
          .rst(rst),
          .val_in(val_comb[3]),
          .val_out(val_int[0]),
          .data_out(data_int[0])); 
  
  //Bloques INT
  genvar j;
  generate
    for(j=0; j<3; j=j+1)
    begin : ints
      INT #(.Win(Win+Wg), .Wg(Wg))
          tab_int(.data_in(data_int[j]),
                  .clk(clk),
                  .rst(rst),
                  .val_in(val_int[j]),
                  .val_out(val_int[j+1]),
                  .data_out(data_int[j+1]));
    end
  endgenerate

  assign val_out = val_int[3];
  assign o_data = data_int[3];
  */

	
	endmodule 




