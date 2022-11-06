module DP_MOD_wrap
	(
	input signed [15:0] i_data,
	input rst,
	input clk,
	input val_in,
	input c_fm_am, // Control modo fm/am
	input [23:0] frec_por,
	input [15:0] im_am,
	input [15:0] im_fm,
	output reg signed [15:0] o_data,
	output reg val_out
	);

	reg [15:0] i_data_reg;
	reg val_in_reg;
	reg rst_reg, c_fm_am_reg;
	reg [23:0] frec_por_reg;
	reg [15:0] im_am_reg;
	wire [15:0] im_fm_reg;
	wire signed [15:0] o_data_wire;
	wire val_out_wire;

	always @(posedge clk) begin

		i_data_reg <= i_data;
		val_in_reg <= val_in;
		rst_reg <= rst;
		c_fm_am_reg <= c_fm_am;
		frec_por_reg <= frec_por;
		im_am_reg <= im_am;
		//im_fm_reg <= im_fm;
		o_data <= o_data_wire;
		val_out <= val_out_wire;
		
	end
	
	DP_MOD D1 
	(.i_data(i_data_reg),
	 .val_in(val_in_reg),
	 .rst(rst_reg),
	 .clk(clk),
	 .c_fm_am(c_fm_am_reg),
	 .frec_por(frec_por_reg),
	 .im_am(im_am_reg),
	 .im_fm(im_fm_reg),
	 .o_data(o_data_wire),
	 .val_out(val_out_wire));

endmodule   