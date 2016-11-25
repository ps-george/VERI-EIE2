//-------------------------------
// Module name: ex6_top
// Function: top level module for this design
//           16 bit counter with enable and
// 			 reset assigned to switches
//--------------------------------


module ex6_top (
	KEY,
	HEX0, HEX1, HEX2, HEX3,HEX4,
	CLOCK_50
);
	input [1:0] KEY;
	input CLOCK_50;
	output [6:0] HEX0;
	output [6:0] HEX1;
	output [6:0] HEX2;
	output [6:0] HEX3;
	output [6:0] HEX4;
	
	wire [15:0] CTR_OUT;
	wire [3:0] BCD0, BCD1, BCD2, BCD3, BCD4;
	wire tick;
	
	modulo_counter_16 TICKGEN(CLOCK_50,1,0,tick);
	
	assign enable = ~KEY[0]&tick;
	
	counter_16 CTR(CLOCK_50, enable, ~KEY[1],CTR_OUT);
	bin2bcd_16 DCODER (CTR_OUT,BCD0,BCD1,BCD2,BCD3,BCD4);
	
	hex_to_7seg SEG0 (BCD0,HEX0);
	hex_to_7seg SEG1 (BCD1,HEX1);
	hex_to_7seg SEG2 (BCD2,HEX2);
	hex_to_7seg SEG3 (BCD3,HEX3);
	hex_to_7seg SEG4 (BCD4,HEX4);
	
endmodule
