
module INT 
#(	parameter Win = 16,					// Input
	parameter Wg= 22	) 					// Crecimiento del dato
  (input signed [Win-1:0] data_in, 	// Input data
  input clk,
  input rst,
  input val_in,  					// Validation input
  output reg val_out,					// Validation output
  output reg signed [Win+Wg-1:0] data_out);// Output data

  /*wire signed [Win-1:0] data_out_reg;
	register #(.n(Win+Wg)) r1(.clk(clk), .B(data_out), .Q(data_out_reg));*/

  always@(posedge clk) begin
    if(rst) begin
      data_out <= {(Win+Wg){1'b0}};
      val_out <= 0;
    end
    else begin
      if (val_in) begin
        data_out <= (data_in + data_out);
      end
      val_out <= val_in;
    end
  end
		
endmodule 