module MOD_COMP
	(
	input		[13:0]	ADC_DA, ADC_DB,
//	input		ADC_OTR_A, ADC_OTR_B,
	input 	UART_RXD, 		// rx serial input
	input		CLOCK_50, CLOCK2_50,		// Main clock 50 MHz
	input		[0:0]	KEY, 	// Push buttom [3:0]
	input    [3:0] SW, 	// Switch [17:0]
	output	UART_TXD, 	// tx serial output
	output	ADC_CLK_A, ADC_CLK_B,
	output	ADC_OEB_A, ADC_OEB_B,
	output	reg [13:0]	DAC_DA, DAC_B,
	output	DAC_CLK_A, DAC_CLK_B,
	output	DAC_MODE,
	output	DAC_WRT_A, DAC_WRT_B,
	output	[2:0]	LEDG,	// green LEDs [8:0]
	output	[15:0]	LEDR, 	// Red LEDs [17:0]
		// I2C Audio/Video config interface
	output I2C_SCLK,
	inout I2C_SDAT,
	// Audio CODEC
	output AUD_XCK,
	input AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK,
	input AUD_ADCDAT,
	output AUD_DACDAT
	);


	wire rxsd;
	wire rst;
	wire clk;
	wire clk_ps;
	wire [3:0] addr_reg;
	wire txsd;
	wire [2:0] sleds;
	reg [7:0] viewregs;
	wire [7:0] view_rxdw;
	
	wire [7:0] r_control;
	wire [23:0] r_frec_mod;
	wire [23:0] r_frec_por;
	wire [15:0] r_im_am;
	wire [15:0] r_im_fm;

	wire c_fm_am;
	wire c_on_off;
	wire [1:0] c_source;
	wire c_comp_dac;
	
			//////////////////////////////////
	wire val_in;
	wire val_out;
	wire [15:0] out_dds_mod;
	reg [15:0] i_adc;
	wire [15:0] i_codec;
	reg [15:0] i_data;
	wire [13:0] o_data;
	
	// CODEC conexion
	reg val_in_syn1, val_in_syn2, read;
	wire read_ready, write_ready, write;
	wire [23:0] readdata_left, readdata_right;
	wire [23:0] writedata_left, writedata_right;
	
	// Conexión puertos
	
	assign rxsd = UART_RXD;
	assign UART_TXD = txsd;
	assign rst = !KEY[0];
	assign addr_reg = SW[3:0];
	assign LEDG = sleds;
	assign LEDR[7:0] = viewregs;
	
	assign LEDR[15:8]= view_rxdw;
	
	// Conexion ADC DAC
	assign  DAC_MODE = 1; 		  //Mode Select. 1 = dual port, 0 = interleaved.
	
	assign  DAC_WRT_A = !clk;     //Input write signal for PORT A
	assign  DAC_CLK_A = !clk; 	  //PLL Clock to DAC_A
	assign  ADC_CLK_A = clk;  	  //PLL Clock to ADC_A
	assign  ADC_OEB_A = 0; 		  //ADC_OEA
	
	assign  DAC_WRT_B = clk;     //Input write signal for PORT B
	assign  DAC_CLK_B = clk; 	  //PLL Clock to DAC_B
	assign  ADC_CLK_B = clk;  	  //PLL Clock to ADC_B
	assign  ADC_OEB_B = 0; 		  //ADC_OEB
	
	// COnexión señales internas
	assign c_on_off = !r_control[0];
	assign c_fm_am = r_control[1];
	assign c_source = r_control[3:2];
	assign c_comp_dac = r_control[4];
	
	// Conexion salida de datos del codec de audio
	assign i_codec = readdata_left[23:8];
	
	always @(posedge clk)
		DAC_DA = {!o_data[13],o_data[12:0]}; //A
	
//	always @(negedge clk)
//		i_adc <= {ADC_DA[13],ADC_DA[12:0],2'b00};	
	
	// Multiplexor para monitorizar registros mediante los LEDs (ver practica E5)
	always@*
		case(addr_reg)
			4'b 0000: 	viewregs = r_control;
			4'b 0001: 	viewregs = r_frec_mod[23:16];
			4'b 0010: 	viewregs = r_frec_mod[15:8];
			4'b 0011: 	viewregs = r_frec_mod[7:0];
			4'b 0100: 	viewregs = r_frec_por[23:16];
			4'b 0101: 	viewregs = r_frec_por[15:8];
			4'b 0110: 	viewregs = r_frec_por[7:0];
			4'b 0111: 	viewregs = r_im_am[15:8];
			4'b 1000: 	viewregs = r_im_am[7:0];
			4'b 1001: 	viewregs = r_im_fm[15:8];
			4'b 1010: 	viewregs = r_im_fm[7:0];
			default:  	viewregs = 8'b 00000000;
		endcase 
	/////////////////////

	
	DP_COMPLETMOD U1
			(
			.i_data(i_codec),
			.rst(c_on_off),
			.clk(clk),
			.val_in(val_in),
			.c_fm_am(c_fm_am),
			.c_source(c_source),
			.c_comp_dac(c_comp_dac), 
			.frec_mod(r_frec_mod),
			.frec_por(r_frec_por),
			.im_am(r_im_am),
			.im_fm(r_im_fm),
			.o_data(o_data),
			.val_out(val_out)
			);

	
	CONF_CONTROL U2
			(
			.rxsd(rxsd),
			.rst(rst),
			.clk(clk_ps),
			.txsd(txsd),
			.sleds(sleds),
			.r_control(r_control),
			.r_frec_mod(r_frec_mod),
			.r_frec_por(r_frec_por),
			.r_im_am(r_im_am),
			.r_im_fm(r_im_fm),
			.view_rxdw(view_rxdw)
			);


	
	// Generación de la tasa de muestreo de 48 kHz
	GEN_CE #(.N(2000)) U3 (.clk(clk),.rst(rst),.ce(val_in));
	

	// PLL para la generación de clk a 98 MHz
	pll_mod	pll_inst1 (
					.areset ( 1'b0 ),
					.inclk0 ( CLOCK_50 ),
					.c0 ( clk )
					);
	// PLL para la generación de clk_sp a 25 MHz
	pll_com	pll_inst2 (
					.areset ( 1'b0 ),
					.inclk0 ( CLOCK_50 ),
					.c0 ( clk_ps )
					);
					
/////////////////////////////////////////////////////////////////////////////////
// Audio CODEC interface. 
//
// The interface consists of the following wires:
// read_ready, write_ready - CODEC ready for read/write operation 
// readdata_left, readdata_right - left and right channel data from the CODEC
// read - send data from the CODEC (both channels)
// writedata_left, writedata_right - left and right channel data to the CODEC
// write - send data to the CODEC (both channels)
// AUD_* - should connect to top-level entity I/O of the same name.
//         These signals go directly to the Audio CODEC
// I2C_* - should connect to top-level entity I/O of the same name.
//         These signals go directly to the Audio/Video Config module
/////////////////////////////////////////////////////////////////////////////////
	clock_generator my_clock_gen(
		// inputs
		CLOCK2_50,
		1'b0, //reset
		// outputs
		AUD_XCK
	);

	audio_and_video_config cfg(
		// Inputs
		CLOCK_50,
		1'b0, //reset
		// Bidirectionals
		I2C_SDAT,
		I2C_SCLK
	);

	audio_codec codec(
		// Inputs
		CLOCK_50,
		1'b0, //reset
		read,	write,
		writedata_left, writedata_right,
		AUD_ADCDAT,
		// Bidirectionals
		AUD_BCLK,
		AUD_ADCLRCK,
		AUD_DACLRCK,
		// Outputs
		read_ready, write_ready,
		readdata_left, readdata_right,
		AUD_DACDAT
	);

	// sincronizadores
	always@(posedge AUD_XCK)
		begin
			val_in_syn1 <= val_in;
			val_in_syn2 <= val_in_syn1;
			read <= val_in_syn2;
		end
	
endmodule 