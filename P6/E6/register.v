module register
#(parameter n = 8)
(clk, B, Q);

input clk;
input[n-1:0] B;
output reg[n-1:0] Q;

always@(posedge clk)
    Q <= B;
endmodule
