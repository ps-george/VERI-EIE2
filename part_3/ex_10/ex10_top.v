/* Top level design entity for testing DAC
*  ex10_top.v
*/

//spi2dac (sysclk, data_in, load, dac_sdi, dac_cs, dac_sck, dac_ld);

module ex10_top(
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
	wire [9:0] SW;
	
	modulo_counter_16 TICKGEN(CLOCK_50,1,0,5000,tick);

	spi2dac CONV (CLOCK_50, SW, tick, DAC_SDI, DAC_CS, DAC_SCK, DAC_LD); 
	
	assign PWM_OUT = tick;
	
endmodule
