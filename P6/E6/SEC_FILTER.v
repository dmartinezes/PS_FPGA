module SEC_FILTER
#(parameter Win=16,    // Cuantificacion de la entrada y salida
  parameter Wc = 18,   // Cuantificacion coeficientes
  parameter Num_coef=17)   // Numero de coeficientes
  (input  signed [Win-1:0] din, // entrada
   input  clk, 
   input val_in,
   input rst,
   output reg val_out,
   //output reg signed [Win+Wc-1:0] dout); // salida precision completa
   output reg signed [Win+2:0] dout); // salida truncada a 19 bits

    wire [log2(Num_coef)-1:0] addr;
    wire ce_Reg;
    wire rst_Acc;
    wire ce_Acc;

    reg [log2(Num_coef)-1:0] addr_reg;
    reg ce_Reg_reg, ce_Reg_reg2, ce_Reg_reg3;
    reg rst_Acc_reg, rst_Acc_reg2, rst_Acc_reg3;
    reg ce_Acc_reg, ce_Acc_reg2, ce_Acc_reg3;

    reg val_in_reg;
    reg rst_reg;

    CONTROL #(.Num_coef(Num_coef)) dut1
    (.val_in(val_in), 
    .clk(clk), 
    .rst(rst),
    .addr(addr),
    .ce_Reg(ce_Reg),
    .rst_Acc(rst_Acc),
    .ce_Acc(ce_Acc));

    reg signed [Win-1:0] din_reg;

    wire signed [Win-1:0] dout_mux; 
    reg signed [Win-1:0] dout_mux_reg, dout_mux_reg2; 

    REG_MUX #(.Win(Win), .Num_coef(Num_coef)) regMux
    (.din(din_reg), 
    .sel(addr_reg),
    .clk(clk), 
    .ce(val_in_reg),  
    .dout(dout_mux));

    wire signed [Wc-1:0] data;
    reg signed [Wc-1:0] data_reg, data_reg2;
    wire signed [Win+Wc-1:0] dout_mult;

    ROM #(.Num_coef(Num_coef), .Wc(Wc)) rom
    (.addr(addr_reg), 
    .clk(clk),
    .data(data));
    
    MULT_ACC #(.Win(Win), .Wc(Wc)) multAcc
    (.din(dout_mux_reg2), 
    .coef(data_reg2),
    .clk(clk), 
    .rst(rst_Acc_reg3),  
    .ce(ce_Acc_reg3),
    .dout(dout_mult));

    always @(posedge clk) begin

        din_reg <= din;
        val_in_reg <= val_in;
        rst_reg <= rst;

        addr_reg <= addr;

        dout_mux_reg <= dout_mux;
        data_reg <= data;
        ce_Reg_reg <= ce_Reg;
        rst_Acc_reg <= rst_Acc;
        ce_Acc_reg <= ce_Acc;

        dout_mux_reg2 <= dout_mux_reg;
        data_reg2 <= data_reg;
        ce_Reg_reg2 <= ce_Reg_reg;
        rst_Acc_reg2 <= rst_Acc_reg;
        ce_Acc_reg2 <= ce_Acc_reg;

        ce_Reg_reg3 <= ce_Reg_reg2;
        rst_Acc_reg3 <= rst_Acc_reg2;
        ce_Acc_reg3 <= ce_Acc_reg2;

        if (ce_Reg_reg3) begin
            //dout <= dout_mult;        // salida precision completa
            dout <= dout_mult[33:15]; // salida truncada a 19 bits
            val_out <= 1'b1;
        end
        else 
            val_out <= 1'b0;
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