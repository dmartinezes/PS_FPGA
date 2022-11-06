module DDS_wrap_test
	(
	input [26:0] P,
	input val_in,
	input rst_ac, ena_ac,
	input clk,
	output reg signed [13:0] sqr_wave,
	output reg signed [13:0] ramp_wave,
	output reg signed [13:0] sin_wave,
	output reg val_out
	);

reg [26:0] P_reg;
reg val_in_reg;
reg rst_ac_reg, ena_ac_reg;
wire signed [13:0] sqr_wave_wire;
wire signed [13:0] ramp_wave_wire;
wire signed [13:0] sin_wave_wire;
wire val_out_wire;

always@(posedge clk) 	
	begin
		P_reg <= P;
		val_in_reg <= val_in;
		rst_ac_reg <= rst_ac;
		ena_ac_reg <= ena_ac;
		sqr_wave <= sqr_wave_wire;
		ramp_wave <= ramp_wave_wire;
		sin_wave <= sin_wave_wire;
		val_out <= val_out_wire;
	end
		
	
DDS_test #(.M(27),.L(15),.W(14)) DDS1 
			(.P(P_reg),
			.val_in(val_in_reg),
			.rst_ac(rst_ac_reg),
			.ena_ac(ena_ac_reg),
			.clk(clk),
			.sqr_wave(sqr_wave_wire),
			.ramp_wave(ramp_wave_wire),
			.sin_wave(sin_wave_wire),
			.val_out(val_out_wire)
			);


endmodule 