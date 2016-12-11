/* Top level design entity for testing DAC
*  ex15_top.v
*/

//spi2dac (sysclk, data_in, load, dac_sdi, dac_cs, dac_sck, dac_ld);

module ex15_top(CLOCK_50,DAC_SDI, DAC_SCK, DAC_CS, DAC_LD, ADC_SDI, ADC_SCK, ADC_CS, ADC_SDO, PWM_OUT);

	input			CLOCK_50;		// DE0 50MHz system clock
	output 		DAC_SDI;			//Serial data out to SDI of the DAC
	output 		DAC_SCK;				//Serial clock signal to both DAC and ADC
	output		DAC_CS;			//Chip select to the DAC, low active
	output 		DAC_LD;			//Load new data to DAC, low active
	
	output 		ADC_SDI;			//Serial data out to SDI of the ADC
	output 		ADC_SCK;		// ADC Clock signal
	output		ADC_CS;			//Chip select to the ADC, low active
	input 		ADC_SDO;			//Converted serial data from ADC
	
	output		PWM_OUT;			// PWM output to R channel
	
	wire tick, CLOCK_50;
	wire [9:0] data_adc;
	wire data_valid;
	
	
	spi2adc SPI_ADC (						// perform a A-to-D conversion
		.sysclk (CLOCK_50), 				// order of parameters do not matter
		.channel (1'b1), 											// use only CH1
		.start (tick_10k),
		.data_from_adc (data_adc),
		.data_valid (data_valid),     // Active high
		.sdata_to_adc (ADC_SDI),
		.adc_cs (ADC_CS),
		.adc_sck (ADC_SCK),
		.sdata_from_adc (ADC_SDO));
	
	modulo_counter_16 TICKGEN(CLOCK_50,1,0,5000,tick);
	
	// Instead of switches, count value is data_adc
	counter_mult_10 ADRCNT (CLOCK_50,tick&data_valid,data_adc,adr);
	
	ROM ROM1(adr,tick,data_in);
	
	spi2dac CONV (CLOCK_50, data_in, tick, DAC_SDI, DAC_CS, DAC_SCK, DAC_LD); 
	
	pwm PWM(CLOCK_50,data_in,tick,PWM_OUT);
	
endmodule
