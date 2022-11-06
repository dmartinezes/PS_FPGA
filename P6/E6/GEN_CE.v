
// Enable generator
module GEN_CE 
#(parameter N=10)
  (input clk, rst,
   output reg ce);

reg [log2(N)-1:0] C;

  always @ (posedge clk)
        if (rst)
				begin
					C <= 0;
					ce <= 1'b 0;
				end
        else 
             if (C == (N-1))
                begin
                 C <= 0;
                 ce <= 1'b1;
                end
             else
                begin
                 C <= C + 1'b1;
                 ce <= 1'b0;
                end

  function integer log2;
   input integer value;
   begin
     value = value-1;
     for (log2=0; value>0; log2=log2+1)
       value = value>>1;
   end
 endfunction
endmodule 
