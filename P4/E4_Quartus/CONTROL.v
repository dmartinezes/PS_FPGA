module CONTROL
# (parameter Num_coef = 17)
( input val_in,
  input clk,
  input rst,
  output reg [log2(Num_coef)-1:0] addr,
  output reg ce_Reg,
  output reg rst_Acc,
  output reg ce_Acc
  );

  initial begin
    addr = 0;
  end

  //Definición de estados
  reg [1:0] state;
  parameter [1:0] S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
  
  reg fin_count, cont_enable;

  //Contador hasta Num_coef
  always @(posedge clk) begin 

    if(cont_enable) begin 

      addr <= addr + 1;
      
      if (addr >= Num_coef-1) begin
        fin_count <= 1;
      end

      if (addr >= Num_coef) begin
        addr <= 0;
      end

    end

    else begin
      addr <= 0;
      fin_count <= 0;
    end

  end

  //Definimos la memoria de estado
  always @(posedge clk) begin
    if (rst)
      state <= S0;
    else begin
      case (state)

      S0: if(val_in == 1'b1)
            state <= S1;
          else 
            state <= S0;

      S1: state <= S2;

      S2: if (fin_count) 
            state <= S3;
          else 
            state <= S2;

      S3: state <= S0;

      default: state <= S0;

      endcase
    end
  end 

  //Definimos la lógica  de las salidas 
  always @(state, val_in) begin
      case (state) 

          S0: begin
            cont_enable = 0;
            ce_Acc = 0;
            rst_Acc = 1;
            ce_Reg = 0;
          end 

          S1: begin
            cont_enable = 1;
            ce_Acc = 0;
            rst_Acc = 1;
            ce_Reg = 0;
          end

          S2: begin
            cont_enable = 1;
            ce_Acc = 1;
            rst_Acc = 0;
            ce_Reg = 0;
          end

          S3: begin
            cont_enable = 0;
            ce_Acc = 0;
            rst_Acc = 1;
            ce_Reg = 1;
          end 
              
          default: begin 
            cont_enable = 0;
            ce_Acc = 0;
            rst_Acc = 0;
            ce_Reg = 0;
          end

      endcase
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