module mult_add(
input signed [7:0] a,b,c,
input clk,
input val_in,
output reg signed [7:0] s,
output reg rdy_out
);


reg [0:1] shift_reg;


wire signed [15:0] mult;
assign mult = a * b;

wire signed [8:0] mult_trunc;
assign mult_trunc[8:0] = mult [15:7];
reg signed [8:0] mult_trunc_reg;

always@(posedge clk) begin
	mult_trunc_reg <= mult_trunc;
end

reg signed [7:0] c_reg;

always@(posedge clk) begin
	c_reg <= c;
end

wire signed [8:0] sum;
assign sum = mult_trunc_reg + c_reg;

wire signed [7:0] sum_trunc;
assign sum_trunc [7:0] = sum [8:1];

always@(posedge clk) begin
	s <= sum_trunc;
end

reg val_in_reg1, val_in_reg2;

always@(posedge clk) begin
	val_in_reg1 <= val_in;
end

always@(posedge clk) begin
	val_in_reg2 <= val_in_reg1;
end

assign val_out = val_in_reg2;

always@(posedge clk)
	{shift_reg[1],rdy_out} <= {val_in,shift_reg[1]};


endmodule 