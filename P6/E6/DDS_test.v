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

	register #(.n(1)) r1(.clk(clk), .B(val_in), .Q(val_out_reg1));
	register #(.n(1)) r2(.clk(clk), .B(val_out_reg1), .Q(val_out_reg2));
	register #(.n(1)) r3(.clk(clk), .B(val_out_reg2), .Q(val_out_reg3));
	register #(.n(1)) r4(.clk(clk), .B(val_out_reg3), .Q(val_out_reg4));

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
				acc_out <= acc_out;	
		end
	end

	//onda rampa
	reg [(M-1):(M-W)] ramp_wave_reg1;
	

	always @(posedge clk)
	begin
		ramp_wave_reg1[(M-1):(M-W)] <= acc_out[(M-1):(M-W)];
	end
	
	wire [(M-1):(M-W)] ramp_wave_reg2;
	register #(.n(W)) rw1(.clk(clk), .B(ramp_wave_reg1), .Q(ramp_wave_reg2));
	register #(.n(W)) rw2(.clk(clk), .B(ramp_wave_reg2), .Q(ramp_wave));

	//onda cuadrada 
	reg [(M-1):(M-W)] ramp_sqr_reg1;
	
	always @(posedge clk)
	begin
		ramp_sqr_reg1[M-1] <= acc_out[M-1];
		ramp_sqr_reg1[M-2:(M-W+1)] <= {{(W-2)}{!acc_out[M-1]}}; 
		ramp_sqr_reg1[M-W] <= 1'b1;
	end

	wire [(M-1):(M-W)] ramp_sqr_reg2;
	register #(.n(W)) rs1(.clk(clk), .B(ramp_sqr_reg1), .Q(ramp_sqr_reg2));
	register #(.n(W)) rs2(.clk(clk), .B(ramp_sqr_reg2), .Q(sqr_wave));

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
	register #(.n(L)) ra1(.clk(clk), .B(wire_a), .Q(wire_a_reg1));
	register #(.n(L)) ra2(.clk(clk), .B(wire_a_reg1), .Q(wire_a_reg2));
	
	always @(posedge clk)
	begin
		if (wire_a_reg2[L-1] == 0)  sin_wave <= q;
		else sin_wave <= ~q + 1;
	end

endmodule 

module rom_mem
#(parameter DATA_WIDTH=14, parameter ADDR_WIDTH=13)
(
	input [(ADDR_WIDTH-1):0] addr,
	input clk, 
	output reg [(DATA_WIDTH-1):0] q
);

	reg [DATA_WIDTH-1:0] rom[2**ADDR_WIDTH-1:0];

	initial
		begin
			if ((DATA_WIDTH == 14)&(ADDR_WIDTH == 13))
				$readmemh("rom_dds_L15_W14.txt", rom);
			else	if ((DATA_WIDTH == 16)&(ADDR_WIDTH == 13))
				$readmemh("rom_dds_L15_W16.txt", rom);
			else	if ((DATA_WIDTH == 16)&(ADDR_WIDTH == 4))
				$readmemh("rom_dds_L6_W16.txt", rom);
		end


	always @ (posedge clk)
		q <= rom[addr];
	
endmodule
