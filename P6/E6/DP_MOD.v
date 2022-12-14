module DP_MOD
	(
	input signed [15:0] i_data,
	input rst,
	input clk,
	input val_in,
	input c_fm_am, // Control modo fm/am
	input [23:0] frec_por,
	input [15:0] im_am,
	input [15:0] im_fm,
	output signed [15:0] o_data,
	output val_out
	);
	

	//Multiplexor im_fm
	wire [15:0] out_mux;
	mux2_1 #(.n(16)) m1( .sel(c_fm_am), .A(0), .B(im_fm), .clk(clk), .out(out_mux));
	wire signed [16:0] out_mux_trunc;
	assign out_mux_trunc = $signed({1'b0, out_mux});

	//Registro 1
	wire signed [16:0] out_mux_trunc_reg;
	register #(.n(17)) r1(.clk(clk), .B(out_mux_trunc), .Q(out_mux_trunc_reg));

	//Multiplicacion A
	wire signed [32:0] mult1_out;
	assign mult1_out = i_data * out_mux_trunc_reg;
	wire signed [23:0] mult1_out_trunc;
	assign mult1_out_trunc [23:0] = mult1_out [30:7];

	//Registro 2
	wire signed [23:0] mult1_out_trunc_reg;
	register #(.n(24)) r2(.clk(clk), .B(mult1_out_trunc), .Q(mult1_out_trunc_reg));

	//Suma A
	wire signed [23:0] sum1;
	wire signed [24:0] frec_por_s;
	assign frec_por_s = $signed({1'b0, frec_por});
	assign sum1 = frec_por_s + mult1_out_trunc_reg;

	//Registro 3
	wire signed [23:0] sum1_reg;
	register #(.n(24)) r3(.clk(clk), .B(sum1), .Q(sum1_reg));

	//Rama rst, registros 9 y 10
	wire rst_reg1, rst_reg2;
	register #(.n(1)) r9(.clk(clk), .B(rst), .Q(rst_reg1));
	register #(.n(1)) r10(.clk(clk), .B(rst_reg1), .Q(rst_reg2));

	/*wire val_in_reg1, val_in_reg2;
	register #(.n(1)) r10(.clk(clk), .B(val_in), .Q(val_in_reg1));
	register #(.n(1)) r10(.clk(clk), .B(val_in_reg1), .Q(val_in_reg2));*/

	//Bloque onda senoidal
	wire signed [15:0] sin_wave_out;
	wire val_out_dds;
	DDS #(.M(24),.L(15),.W(16)) D1
			(
			.P(sum1_reg),
			.val_in(1'b1),
			.rst_ac(rst_reg2), 
			.ena_ac(1'b1),
			.clk(clk),
			.sin_wave(sin_wave_out),
			.val_out(val_out_dds)
			);



	//Registros 4, 5 y 6 desde i_data
	wire signed [15:0] i_data_reg1, i_data_reg2, i_data_reg3;
	register #(.n(16)) r4(.clk(clk), .B(i_data), .Q(i_data_reg1));
	register #(.n(16)) r5(.clk(clk), .B(i_data_reg1), .Q(i_data_reg2));
	register #(.n(16)) r6(.clk(clk), .B(i_data_reg2), .Q(i_data_reg3));

	//Multiplicacion B
	wire signed [16:0] im_am_s = $signed({1'b0, im_am});
	wire signed [32:0] multB_out;
	assign multB_out = i_data_reg3 * im_am_s;
	wire signed [15:0] multB_out_trunc;
	assign multB_out_trunc [15:0] = multB_out [30:15];

	//Registro 7
	wire signed [15:0] multB_out_trunc_reg1;
	register #(.n(16)) r7(.clk(clk), .B(multB_out_trunc), .Q(multB_out_trunc_reg1));

	//Sumador B
	wire signed [16:0] sumB; //17 bits de suma, formato S[17,15]
	//Uno en formato S[16:15], valor = 1*2^(15) = 32768
	assign sumB = (multB_out_trunc_reg1 + 32768);  

	//Registro 8
	wire signed [16:0] sumB_reg;
	register #(.n(17)) r8(.clk(clk), .B(sumB), .Q(sumB_reg));

	//Multiplicacion por cte
	wire signed [16:0] const_out;
	assign const_out = (sumB_reg >>> 1);

	//Multiplexor 2
	wire signed [16:0] out_mux2;
	//uno en formato S[17:15], valor = 1*2^(15) = 32768
	mux2_1 #(.n(17)) m2( .sel(c_fm_am), .A(const_out), .B(32768), .clk(clk), .out(out_mux2));

	//Registro 11
	wire signed [16:0] out_mux2_reg;
	register #(.n(17)) r11(.clk(clk), .B(out_mux2), .Q(out_mux2_reg));

	//Multiplicacion C
	wire signed [32:0] multC_out;
	assign multC_out = sin_wave_out * out_mux2_reg;
	wire signed [15:0] multC_out_trunc;
	assign multC_out_trunc [15:0] = multC_out [30:15];

	//Registro 12
	wire signed [15:0] multC_out_trunc_reg;
	register #(.n(16)) r12(.clk(clk), .B(multC_out_trunc), .Q(multC_out_trunc_reg));

	assign o_data = multC_out_trunc_reg;

	// Se??al val_out
	wire val_in_reg1, val_in_reg2, val_in_reg3, val_in_reg4, val_in_reg5, val_in_reg6, val_in_reg7;
	register #(.n(1)) r13(.clk(clk), .B(val_in), .Q(val_in_reg1));
	register #(.n(1)) r14(.clk(clk), .B(val_in_reg1), .Q(val_in_reg2));
	register #(.n(1)) r15(.clk(clk), .B(val_in_reg2), .Q(val_in_reg3));
	register #(.n(1)) r16(.clk(clk), .B(val_in_reg3), .Q(val_in_reg4));
	register #(.n(1)) r17(.clk(clk), .B(val_in_reg4), .Q(val_in_reg5));
	register #(.n(1)) r18(.clk(clk), .B(val_in_reg5), .Q(val_in_reg6));
	register #(.n(1)) r19(.clk(clk), .B(val_in_reg6), .Q(val_in_reg7));

	assign val_out = val_in_reg7;

endmodule 