module CIC_wrap
#(parameter Win=16, // Input length
  parameter Wg=22)  // Guard bits

  (input signed [Win-1:0] i_data,  		// Data input
   input clk,
   input rst,
   input val_in,  						// Validation input
   output reg val_out,						// Validation output
   output reg signed [15:0] o_data_trunc);	// Data output

    reg signed [Win-1:0] i_data_reg;
    reg val_in_reg;
    reg rst_reg;
    wire signed [15:0] o_data_trunc_wire; 
    wire val_out_wire;

    always @(posedge clk) begin
        i_data_reg <= i_data;
        val_in_reg <= val_in;
		rst_reg <= rst;
        o_data_trunc <= o_data_trunc_wire;
		val_out <= val_out_wire;
    end

    CIC #(.Win(Win), .Wg(Wg)) cic
    (.i_data(i_data_reg), 
    .clk(clk), 
    .rst(rst), 
    .val_in(val_in_reg), 
    .val_out(val_out_wire), 
    .o_data_trunc(o_data_trunc_wire));

endmodule