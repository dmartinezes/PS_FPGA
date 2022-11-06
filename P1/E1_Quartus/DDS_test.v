module DDS_test
#(parameter M=27,
  parameter L=15,
  parameter W=14)
(
input [M-1:0] P,
input val_in,
input rst_ac, ena_ac,
input clk,
output signed [W-1:0] sqr_wave,
output signed [W-1:0] ramp_wave,
output reg signed [W-1:0] sin_wave,
output val_out
);
	
	wire val_out_reg1, val_out_reg2, val_out_reg3, val_out_reg4;

	reg [M-1:0] acc_out;

	register #(.n(1)) r1(.clk(clk), .reset(rst_ac), .B(val_in), .Q(val_out_reg1));
	register #(.n(1)) r2(.clk(clk), .reset(rst_ac), .B(val_out_reg1), .Q(val_out_reg2));
	register #(.n(1)) r3(.clk(clk), .reset(rst_ac), .B(val_out_reg2), .Q(val_out_reg3));
	register #(.n(1)) r4(.clk(clk), .reset(rst_ac), .B(val_out_reg3), .Q(val_out_reg4));

	assign val_out = val_out_reg4;

	//salida acumulador
	always @(posedge clk)
	begin
		if(rst_ac)
			acc_out <= 0;
		else 
		begin
			if(ena_ac==1)
				acc_out <= P + acc_out;
			else
				acc_out <= 0;	
		end
	end

	//onda rampa
	reg [(M-1):(M-W)] ramp_wave_reg1;
	

	always @(posedge clk)
	begin
		if(rst_ac)
			ramp_wave_reg1 <= 0;
		else 
		begin
			if(ena_ac==1)
				ramp_wave_reg1[(M-1):(M-W)] <= acc_out[(M-1):(M-W)];
			else
				ramp_wave_reg1[(M-1):(M-W)] <= 0;
		end
	end
	
	wire [(M-1):(M-W)] ramp_wave_reg2;
	register #(.n(W)) rw1(.clk(clk), .reset(rst_ac), .B(ramp_wave_reg1), .Q(ramp_wave_reg2));
	register #(.n(W)) rw2(.clk(clk), .reset(rst_ac), .B(ramp_wave_reg2), .Q(ramp_wave));

	//onda cuadrada 
	//wire [(W-1):0] ramp_sqr_reg1, ramp_sqr_reg2;
	reg [(M-1):(M-W)] ramp_sqr_reg1;
	
	always @(posedge clk)
	begin
		if(rst_ac)
			ramp_sqr_reg1 <= 0;
		else 
		begin
			if(ena_ac==1)
			begin
				ramp_sqr_reg1[M-1] <= acc_out[M-1];
				ramp_sqr_reg1[M-2:(M-W+1)] <= {{(W-2)}{!acc_out[M-1]}};//{{W-2}{ramp_sqr_reg2}};
				ramp_sqr_reg1[M-W] <= 1'b1;
			end
			else
				ramp_sqr_reg1[(M-1):(M-W)] <= {((W)){1'b0}};
		end
	end

	wire [(M-1):(M-W)] ramp_sqr_reg2;
	register #(.n(W)) rs1(.clk(clk), .reset(rst_ac), .B(ramp_sqr_reg1), .Q(ramp_sqr_reg2));
	register #(.n(W)) rs2(.clk(clk), .reset(rst_ac), .B(ramp_sqr_reg2), .Q(sqr_wave));

	//onda senoidal	
	wire [L-1:0] wire_a = acc_out[M-1:M-L];
	reg [(L-3):0] wire_b;

	//pre-proc
	always @(posedge clk)
	begin
		if (wire_a[L-2] == 0)  wire_b <= wire_a[(L-3):0];
		else wire_b <= ~wire_a[(L-3):0];
	end

	//instanciar rom
	wire [(W-1):0] q;
	
	rom_mem #(.DATA_WIDTH(W), .ADDR_WIDTH(L-2)) m1(.addr(wire_b), .clk(clk), .q(q));

	//Post-proc
	wire [L-1:0] wire_a_reg1, wire_a_reg2;
	register #(.n(L)) ra1(.clk(clk), .reset(rst_ac), .B(wire_a), .Q(wire_a_reg1));
	register #(.n(L)) ra2(.clk(clk), .reset(rst_ac), .B(wire_a_reg1), .Q(wire_a_reg2));
	
	always @(posedge clk)
	begin
		if (wire_a_reg2[L-1] == 0)  sin_wave <= q;
		else sin_wave <= ~q + 1;
	end

endmodule 