module DP_COMPLETMOD
	(
	input signed [15:0] i_data,
	input rst,
	input clk,
	input val_in,
	input c_fm_am, // Control modo fm/am
	input [1:0] c_source, // Selecccion fuente  de señal moduladora
	input c_comp_dac, // Control multiplexor de compensación DAC
	input [23:0] frec_mod,
	input [23:0] frec_por,
	input [15:0] im_am,
	input [15:0] im_fm,
	output signed [13:0] o_data,
	output val_out
	);

	// DDS test block

	wire signed [13:0] sqr_wave;
	wire signed [13:0] ramp_wave;
	wire signed [13:0] sin_wave;
	wire val_out_dds;

	DDS_test #(.M(24),.L(15),.W(14)) dds_test 
			(.P(frec_mod),
			.val_in(val_in),
			.rst_ac(rst),
			.ena_ac(val_in),
			.clk(clk),
			.sqr_wave(sqr_wave),
			.ramp_wave(ramp_wave),
			.sin_wave(sin_wave),
			.val_out(val_out_dds)
			);

	// 1st MUX

	wire signed [15:0] mux1_out;
	assign mux1_out = (c_source == 0)? sin_wave : (c_source == 1)? ramp_wave : (c_source == 2)? sqr_wave : i_data;

	// COMP CIC block

	wire val_out_comp;
	wire signed [18:0] dout_comp;

	SEC_FILTER #(.Win(16), .Wc(18), .Num_coef(17)) sec_filter
    (.din(mux1_out), 
    .clk(clk), 
    .val_in(val_out_dds),
    .rst(rst),  
    .val_out(val_out_comp), 
    .dout(dout_comp));

	// Truncate from S[19,15] to S[18,15]

	wire signed [17:0] dout_comp_trunc;
	assign dout_comp_trunc[17:0] = dout_comp[17:0];

	// ÇIC block

	wire val_out_cic;
	wire signed [15:0] data_out_cic;

	CIC #(.Win(18), .Wg(22)) cic
    (.i_data(dout_comp_trunc), 
    .clk(clk), 
    .rst(rst), 
    .val_in(val_out_comp), 
    .val_out(val_out_cic), 
    .o_data_trunc(data_out_cic));

	// DP_MOD block

	wire signed[15:0] o_data_dp;

	assign rst_dp = !val_out_cic || rst;

	DP_MOD dp_mod 
	(.i_data(data_out_cic),
	.rst(rst_dp),
	.clk(clk),
	.val_in(val_out_cic),
	.c_fm_am(c_fm_am), // Control modo fm/am
	.frec_por(frec_por),
	.im_am(im_am),
	.im_fm(im_fm),
	.o_data(o_data_dp),
	.val_out(val_out)
	);

	assign o_data = o_data_dp[15:2];
	
	
endmodule
	