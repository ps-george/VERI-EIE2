module ex7_top(
	KEY,
	HEX0, HEX1
);
	input [3:0] KEY;
	output [6:0] HEX0;
	output [6:0] HEX1;
	wire [3:0] BCD0, BCD1, BCD2, BCD3, BCD4;
	wire [6:0] SEQ_OUT;
	
	lfsr7 SEQGEN (KEY[3], SEQ_OUT);
	
	bin2bcd_16 DCODER (SEQ_OUT,BCD0,BCD1,BCD2,BCD3,BCD4);
	
	hex_to_7seg SEG0 (BCD0,HEX0);
	hex_to_7seg SEG1 (BCD1,HEX1);
	
endmodule
