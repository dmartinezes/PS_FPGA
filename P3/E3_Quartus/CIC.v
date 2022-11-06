module CIC
#(parameter Win=16, // Input length
  parameter Wg=22)  // Guard bits

  (input signed [Win-1:0] i_data,  		// Data input
   input clk,
   input rst,
   input val_in,  						// Validation input
   output val_out,						// Validation output
   output signed [15:0] o_data_trunc);	// Data output

   wire signed [Win+Wg-1:0] o_data;

   CIC_pc #(.Win(Win), .Wg(Wg)) cic1
    (.i_data(i_data), 
    .clk(clk), 
    .rst(rst), 
    .val_in(val_in), 
    .val_out(val_out), 
    .o_data(o_data));

   assign o_data_trunc = o_data [37:22];

endmodule