module rom_mem
#(parameter DATA_WIDTH=14, parameter ADDR_WIDTH=13)
(
	input [(ADDR_WIDTH-1):0] addr,
	input clk, 
	output reg [(DATA_WIDTH-1):0] q
);

	reg [DATA_WIDTH-1:0] rom[2**ADDR_WIDTH-1:0];

	initial
		begin
			if ((DATA_WIDTH == 14)&(ADDR_WIDTH == 13))
				$readmemh("rom_dds_L15_W14.txt", rom);
			else	if ((DATA_WIDTH == 16)&(ADDR_WIDTH == 13))
				$readmemh("rom_dds_L15_W16.txt", rom);
			else	if ((DATA_WIDTH == 16)&(ADDR_WIDTH == 4))
				$readmemh("rom_dds_L6_W16.txt", rom);
		end


	always @ (posedge clk)
		q <= rom[addr];
	
endmodule 