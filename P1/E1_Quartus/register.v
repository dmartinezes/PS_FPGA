module register
#(parameter n = 8)
(clk, reset, B, Q);

input clk, reset;
input[n-1:0] B;
output reg[n-1:0] Q;

always@(posedge clk)
    if(reset)
        Q <= {n{1'b0}};
    else
        Q <= B;
endmodule
