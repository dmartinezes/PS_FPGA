module MAIN_CONTROL
(
	input rxrdy,
	input [7:0] rxdw,
	input done_wr, 
	input done_rd,
	input rst, 
	input clk,
	output reg start_wr, 
	output reg start_rd,
	output reg [2:0] sleds 
);

//Definición de estados
  //Binario natural
  reg [1:0] state;
  parameter [1:0] inicial = 2'b00, read = 2'b01, write = 2'b10, error = 2'b11;

  //Definimos la memoria de estado
  always @(posedge clk) begin
    if (rst)
      state <= inicial;
    else begin

      case (state)

        inicial:
        begin

          if(rst == 0 && rxrdy == 1 && rxdw == 8'hF0)
            state <= read;

          else if(rst == 0 && rxrdy == 1 && rxdw == 8'h0F)
            state <= write;

          else 
            state <= error;

        end
        
        read: 
          if(done_rd == 1)
            state <= inicial;
          else 
            state <= read;

        write:
          if(done_wr == 1)
            state <= inicial;
          else 
            state <= write;

        error:
        begin
          if(rst == 0 && rxrdy == 1 && rxdw == 8'hF0)
            state <= read;

          else if(rst == 0 && rxrdy == 1 && rxdw == 8'h0F)
            state <= write;
          else 
            state <= error;
        end

        default: 
          state <= inicial;

      endcase
    end
    
  end


  always @(state) begin
    case (state)

      inicial: begin
        start_wr = 0;
        start_rd = 0;
        sleds = 0;
      end

      read: begin
        start_wr = 0;
        start_rd = 1;
        sleds = 1;
      end

      write: begin
        start_wr = 1;
        start_rd = 0;
        sleds = 2;
      end

      error: begin
        start_wr = 0;
        start_rd = 0;
        sleds = 3;
      end

    endcase
  end

endmodule