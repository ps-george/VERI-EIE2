/* Top level design entity for variable frequency sine wave
*  ex14_top.v
*/

module ex14_top(
	SW,
	CLOCK_50,
	DAC_CS, DAC_SDI, DAC_LD,DAC_SCK,
	PWM_OUT
);
	input [9:0] SW;
	input CLOCK_50;
	output DAC_CS, DAC_SDI, DAC_LD, DAC_SCK;
	output PWM_OUT;
	
	wire tick, CLOCK_50;
	wire [9:0] data_in;
	wire [9:0] adr;
	
	modulo_counter_16 TICKGEN(CLOCK_50,1,0,5000,tick);
	
	counter_mult_10 ADRCNT (CLOCK_50,tick,SW[9:0],adr);
	
	ROM ROM1(adr,tick,data_in);
	spi2dac CONV (CLOCK_50, data_in, tick, DAC_SDI, DAC_CS, DAC_SCK, DAC_LD); 
	
	pwm PWM(CLOCK_50,data_in,tick,PWM_OUT);
	
endmodule
