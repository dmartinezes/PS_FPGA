module COMB 
#(parameter Win=16) // Input length
  (input signed [Win-1:0] data_in,
   input clk,
   input rst,
   input val_in,  					// Validation input
   output reg val_out,					// Validation output
   output reg signed  [(Win+1)-1:0] data_out);
	
	//// Insertar la descripción del modulo

  reg signed [Win-1:0] data_in_reg;
 
  always @(posedge clk) begin
    if(rst) begin
        data_out <= {(Win){1'b0}};
        val_out <= 0;
      	data_in_reg <= 0;
    end
    else begin
        if(val_in) begin
          data_in_reg <= data_in;
          data_out <= (data_in - data_in_reg);
        end
        val_out <= val_in;
      end
  end
  
  
  /*
  reg signed [Win-1:0] data_in_reg;
  always @(posedge clk) begin
    data_in_reg = data_in;
  end

  assign data_out = (!rst) && (val_in)? (data_in - data_in_reg) : {(Win){1'b0}};
  assign val_out = (!rst) && (val_in)? val_in : 0;*/
	 
endmodule 
