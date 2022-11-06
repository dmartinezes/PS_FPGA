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
	
  wire signed [(Win+3)-1:0] data_comb [3:0];
  /*wire [(Win+1)-1:0] data_comb1;
  wire [(Win+2)-1:0] data_comb2;
  wire [(Win+3)-1:0] data_comb3;
  
  assign data_comb[1] = {data_comb1[(Win+1)-1], data_comb1[(Win+1)-2], data_comb1};*/

  /*wire [data_comb [3:0];
  assign data_comb = { [Win-1:0]data_comb[0], 
                      [(Win+1)-1:0]data_comb[1], 
                      [(Win+2)-1:0]data_comb[2], 
                      [(Win+3)-1:0]data_comb[3] };*/
  assign data_comb[0] = i_data;
  wire val_comb [3:0];
  assign val_comb[0] = val_in;
  
  
  //Bloques COMB
  /*genvar i;
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
  endgenerate*/

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
	
	endmodule 




