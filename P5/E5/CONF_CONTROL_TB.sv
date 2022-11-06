module CONF_CONTROL_TB();
parameter HPER = 5;
parameter PER = 2*HPER;
parameter RET = 1;

reg rst;
reg clk = 1'b0;
reg rxrdy;
reg txbusy;
reg [7:0] rxdw;
wire [7:0] txdw;
wire txena;
wire [8:0] sleds;
reg [7:0] C_check = 8'b1;
wire [7:0] r_control;
wire [23:0] r_frec_mod;
wire [23:0] r_frec_por;
wire [15:0] r_im_am;
wire [15:0] r_im_fm;
	
// clock generator
always #HPER clk = ~clk;


CONF_CONTROL_VERIFICA DUT
	(
	.rxdw(rxdw),
	.rxrdy(rxrdy),
	.txbusy(txbusy),
	.rst(rst),
	.clk(clk),
	.txdw(txdw),
	.txena(txena),
	.sleds(sleds),
	.r_control(r_control),
	.r_frec_mod(r_frec_mod),
	.r_frec_por(r_frec_por),
	.r_im_am(r_im_am),
	.r_im_fm(r_im_fm)	
	);

initial begin
	rxrdy = 1'b0;  		// 1st variables initialization
	rst = 1'b0;
	txbusy = 1'b0;
	delay_clks(3);		// 2nd delays 3 clk cycles
	mk_rst();   		// 3th  makes reset
	delay_clks(3);		// 4th delays 3 clk cycles
	wr_frame();			// 5th generates a write frame to send 5 bytes
	delay_clks(20);		// 6th delays 20 clk cycles
	rd_frame();			// 7th generates a reaf frame to receive 5 bytes
	delay_clks(3);		// 8th delays 3 clk cycles
    //Assert_registers:
	$display(" CHECK CONFIGURATION REGISTER ====================");	// 
    assert  (r_frec_mod == 24'h030201) // expression to be checked
		 $display(" Reg frec_mod configured OK");
		else                  // 
		 $error("  WRONG Reg frec_mod config.  %h",r_frec_mod);
	assert  (r_frec_por == 24'h060504) // expression to be checked
		 $display(" Reg frec_por configured OK");
		else                  // 
		 $error("  WRONG Reg frec_por config.  %h",r_frec_por);
	assert  (r_im_am == 16'h0807) // expression to be checked
		 $display(" Reg im_am configured OK");
		else                  // 
		 $error("  WRONG Reg im_am config.  %h",r_im_am);	
	assert  (r_im_fm == 16'h0a09) // expression to be checked
		 $display(" Reg im_fm configured OK");
		else                  // 
		 $error("  WRONG Reg im_fm config.  %h",r_im_fm);
	assert  (r_control == 8'h0b) // expression to be checked
		 $display(" Reg r_control configured OK");
		else                  // 
		 $error("  WRONG Reg control config.  %h",r_control);		 
	$stop;

end

// Busy generator
always@(posedge clk)
	if (txena)
		begin
			#(RET/10) txbusy = 1'b1;
			@(posedge clk);
			delay_clks(10);
			#(RET/10) txbusy = 1'b0;
		end


// Assertion on txena signal		
always@(posedge txena)
	Assert_tena:              // assertion name
     assert (txena != txbusy) // expression to be checked
		 $display(" OK: txena is activated properly");
		else                  // (optional) custom error message
		 $error(" txena cannot be activated when txbusy is enable");

// Assertion on txena 		
always@(posedge txena)
begin
	Assert_tx:              // assertion name
     assert (C_check == txdw) // expression to be checked
		 $display(" Data %d transmitted OK",C_check);
		else                  // (optional) custom error message
		 $error(" TX data should be %d",C_check);		 
	C_check = C_check + 8'b1;
end

// Assertion on txena 		



// Tasks
task wr_frame() ;
	logic [7:0] C;
	// Write instruction
	tx_byte(8'h0F);
	// 11 consecutive data
	C = 8'b0;
	repeat(11) begin
		C = C +8'b1;
		tx_byte(C);
		end
endtask

task tx_byte(logic [7:0] data) ;
	// Write instruction
	@(posedge clk);
	#RET rxrdy = 1'b1;
	#RET rxdw = data;
	@(posedge clk);
	#RET rxrdy = 1'b0;
	// delay
	#(PER*$urandom_range(30,20));
endtask

task rd_frame() ;
	logic C;
	// Write instruction
	tx_byte(8'hF0);
	// Wait to TX data
	delay_clks(11*20);
endtask

task mk_rst();
	@(posedge clk);
	#RET rst = 1'b1;
	@(posedge clk);
	#RET rst = 1'b0;
endtask

task delay_clks(integer n_delays);
	#(PER*n_delays);
endtask

	
endmodule 