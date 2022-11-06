module CONTROL
# (parameter Num_coef = 17)
( input val_in,
 input clk,
 input rst,
 output [log2(Num_coef)-1:0] addr,
 output reg ce_Reg,
 output reg rst_Acc,
 output reg ce_Acc
);

//Definición de estados
//Binario natural
reg [1:0] state, next_state;
parameter [1:0] S0=2'b00, S1=2'b01, S2=2'b10;

//Definimos la memoria de estado
always @(posedge CLK or negedge RESET) begin
  if (!RESET)
    state<=S0;
  else
    state<=next_state;
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

/*// --------------------------------------------------------------------
// Universitat Politècnica de València
// Departamento de Ingeniería Electronica
// --------------------------------------------------------------------
// Sistemas Digitales Programables MUISE
// Curso 2021 -2022
// --------------------------------------------------------------------
// Nombre del archivo: FSM_luces_kit_mealy.v
//
// Descripción: Este código Verilog implementa una máquina de estados de tipo mealy, en la que la salida 
// depende tanto de las entradas como de los estados.
//
//		La funcionalidad de sus entradas y salidas:
//
// 	1. CLK: Reloj activo por flanco de subida.
//		2. RESET: Reset activo a nivel bajo.
//		3. key2: Entrada para que el contador incrementa una cuenta.
//		4. key1: Entrada para que el contador decrementa una cuenta.
//		5. oENABLE: Salida que indica habilitación del contador conectado a esat salida, a nivel alto. 
//		4. oUP_DOWN: Salida que indica si se quiere incrementar o decrementar la cuenta del contador conectado a esta salida.
//			
//		Se adjunta una simulación individual de la máquina.
//
// --------------------------------------------------------------------
// Versión: V1.0| Fecha Modificación: 13/11/2021
//
// Autor(es): Carlos Raya y David Martínez
// 
//
// --------------------------------------------------------------------
module FSM_speed_mealy (
    input CLK, RESET, key2, key1,
    output reg oENABLE, oUP_DOWN
	 );

//Definición de estados
//Binario natural
reg [1:0] state, next_state;
parameter [1:0] S0=2'b00, S1=2'b01, S2=2'b10;

//Definimos la memoria de estado
always @(posedge CLK or negedge RESET) begin
if (!RESET)
state<=S0;
else
state<=next_state;
end

//Definimos la lógica  del estado siguiente
always @(state or key2 or key1) begin
    case (state) //caso en el que el estado actual es
	 
        S0: if (!key1) begin 
                next_state=S1;
					 end
            else if (!key2)
                next_state=S2;
					 else
					 next_state=S0;
					 
			S1: if (key1) 
                next_state=S0;
            else
                next_state=S1;
					 
			S2: if (key2) 
                next_state=S0;
            else
                next_state=S2;
					 
            
        default: next_state=S0;
    endcase
end

//Definimos la lógica  de las salidas
always @(state, key2, key1) begin
    case (state) //caso en el que el estado actual es
        S0: 
				oENABLE=0;
					 
        S1: begin
					oENABLE=1;
					oUP_DOWN=0;
				end
			S2: begin
					oENABLE=1;
					oUP_DOWN=1;
				end
					
            
        default: oENABLE=0;
    endcase
end

    
endmodule /*