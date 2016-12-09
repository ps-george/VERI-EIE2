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
	
	wire [3:0] BCD0, BCD1, BCD2, BCD3, BCD4;
	wire [13:0] lfsr_out;
	wire tick_ms;
	wire tick_hs;
	wire start_delay, time_out, lfsr_en;
	
	modulo_counter_16 TICK50M(CLOCK_50,1,0,50000,tick_ms);
	modulo_counter_16 TICK25K(CLOCK_50,tick_ms,0,500,tick_hs);
	
	//clk, out
	lfsr16 lfsr(tick_ms, lfsr_en, lfsr_out);
	
	// If time_out happens, move result from lfsr reg to output -> later.
	//always @ (posedge tick_ms)
	bin2bcd_16 DCODE(lfsr_out,BCD0,BCD1,BCD2,BCD3,BCD4);
	
	hex_to_7seg seg0(BCD0,HEX0);
	hex_to_7seg seg1(BCD1,HEX1);
	hex_to_7seg seg2(BCD2,HEX2);
	hex_to_7seg seg3(BCD3,HEX3);
	hex_to_7seg seg4(BCD4,HEX4);
	// clk, trigger, N, out
	delay_16 DELAY(tick_ms, start_delay, lfsr_out, time_out);
	
	// IN: clk, tick, trigger, time_out OUT: lfsr_en, start_delay, ledr
	starting_line_fsm FSM(tick_ms,tick_hs, KEY[3], time_out, lfsr_en, start_delay, LEDR);
	

endmodule
