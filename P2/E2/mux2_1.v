module mux2_1 
#(parameter n = 16)
(sel, A, B, clk, out);

	input sel, clk;
	input [n-1:0] A;
	input [n-1:0] B;
	output [n-1:0] out;
	
	assign out = (sel == 0)? A : B;

endmodule 
