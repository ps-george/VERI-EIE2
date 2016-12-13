/* Top level design entity for variable frequency sine wave
*  ex14_top.v
*/

module ex14_top(
	SW,
	CLOCK_50,
	DAC_CS, DAC_SDI, DAC_LD,DAC_SCK,
	PWM_OUT,
	HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);
	input [9:0] SW;
	input CLOCK_50;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output DAC_CS, DAC_SDI, DAC_LD, DAC_SCK;
	output PWM_OUT;
	
	wire tick, CLOCK_50;
	wire [9:0] data_in;
	wire [9:0] adr;
	wire [3:0] BCD0, BCD1, BCD2, BCD3, BCD4;
	
	modulo_counter_16 TICKGEN(CLOCK_50,1,0,5000,tick);
	
	counter_mult_10 ADRCNT (CLOCK_50,tick,SW[9:0],adr);
	
	ROM ROM1(adr,tick,data_in);
	
	spi2dac CONV (CLOCK_50, data_in, tick, DAC_SDI, DAC_CS, DAC_SCK, DAC_LD); 
	pwm PWM(CLOCK_50,data_in,tick,PWM_OUT);
	
	bin2bcd_16 BINDECODE(SW, BCD0, BCD1, BCD2, BCD3, BCD4);
	hex_to_7seg SEG0(0, HEX0);
	hex_to_7seg SEG1(BCD0, HEX1);
	hex_to_7seg SEG2(BCD1, HEX2);
	hex_to_7seg SEG3(BCD2, HEX3);
	hex_to_7seg SEG4(BCD3, HEX4);
	hex_to_7seg SEG5(BCD4, HEX5);
endmodule
