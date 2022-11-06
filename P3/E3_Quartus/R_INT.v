module R_INT
#(parameter Win=16)
  (input signed [Win-1:0] data_in,
  input clk,
  input rst,
  input val_in,  					// Validation input
  output reg val_out,					// Validation output
  output reg signed [Win-1:0] data_out);
  
  reg [11:0] count;

  /*
  always @(posedge clk) 
  begin
    if(rst) begin
      data_out <= {(Win){1'b0}};
      //val_out <= 0;
    end
    else begin
      if(val_in == 1'b1) begin
        data_out <= data_in;
        val_out <= 1;
      end
      else begin
        data_out <= {(Win){1'b0}};
      end
    end
  end
  */
  always @(posedge clk) 
  begin
    if(rst) begin
      data_out <= {(Win){1'b0}};
      count <= 0;
      //val_out <= 0;
    end
    else begin
      if(val_in == 1'b1) begin
            count <= count + 1'b1;
            data_out <= data_in;
            val_out <= 1;
        end

      else begin
        data_out <= {(Win){1'b0}};
      end
    end
  end



endmodule
			

   