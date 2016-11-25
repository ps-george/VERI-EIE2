module ex8_top(
	KEY,
	CLOCK_50,
	HEX0,HEX1,HEX2,HEX3,HEX4,
	LEDR
);

	input [3:0] KEY;
	input CLOCK_50;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4;
	output [9:0] LEDR;

	wire tick_ms;
	wire tick_hs;
	
	modulo_counter_16 TICK50M(CLOCK_50, 1,0,50000,tick_ms);
	modulo_counter_16 TICK25K(tick_ms, 1,0,2500,tick_hs);
	

endmodule
