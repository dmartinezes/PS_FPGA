module mult_add(
input signed [7:0] a,b,c,
input clk,
input val_in,
output reg signed [15:0] s,
output reg rdy_out
);


reg [0:1] shift_reg;


wire signed [15:0] mult;
assign mult = a * b;

reg signed [15:0] mult_reg;

always@(posedge clk) begin
	mult_reg <= mult;
end

reg signed [7:0] c_reg;

always@(posedge clk) begin
	c_reg <= c;
end

wire signed [15:0] sum;
assign sum = mult_reg + (c_reg<<<7);
//reg signed  [15:0] sum_reg;

always@(posedge clk) begin
	s <= sum;
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