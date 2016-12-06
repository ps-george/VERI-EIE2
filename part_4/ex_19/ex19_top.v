//------------------------------
// Module name: ex19_top
// Function: top level module - pass audio input to output directly
// Creator:  Peter Cheung
// Version:  2.0
// Date:     10 Nov 2016
//------------------------------

module ex19_top (CLOCK_50, SW, HEX0, HEX1, HEX2, HEX3, HEX4,
					DAC_SDI, DAC_SCK, DAC_CS, DAC_LD,
					ADC_SDI, ADC_SCK, ADC_CS, ADC_SDO, PWM_OUT);

	input			CLOCK_50;		// DE0 50MHz system clock
	input [9:0]	SW;				// 10 slide switches to specify address to ROM
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4;
	output 		DAC_SDI;			//Serial data out to SDI of the DAC
	output 		DAC_SCK;				//Serial clock signal to both DAC and ADC
	output		DAC_CS;			//Chip select to the DAC, low active
	output 		DAC_LD;			//Load new data to DAC, low active	
	output 		ADC_SDI;			//Serial data out to SDI of the ADC
	output 		ADC_SCK;		// ADC Clock signal
	output		ADC_CS;			//Chip select to the ADC, low active
	input 		ADC_SDO;			//Converted serial data from ADC	
	output		PWM_OUT;			// PWM output to R channel
		
	wire			tick_10k;		// internal clock at 10kHz
	wire [9:0] 	data_in;		// converted data from ADC
	wire [9:0] 	data_out;	// processed data to DAC
	wire			data_valid;
	wire			DAC_SCK, ADC_SCK;
	wire [19:0]	delay_val;
	wire [3:0]  BCD_0, BCD_1, BCD_2, BCD_3,BCD_4;
	
	clktick_16  GEN_10K (CLOCK_50, 1'b1, 16'd4999, tick_10k);  	// generate 10KHz sampling clock ticks
	spi2dac SPI_DAC (CLOCK_50, data_out, tick_10k, 		// send processed sample to DAC
					DAC_SDI, DAC_CS, DAC_SCK, DAC_LD);		// order of signals matter
	pwm PWM_DC(CLOCK_50, data_out, tick_10k, PWM_OUT);		// output via PWM - R-channel
					
	spi2adc SPI_ADC (												// perform a A-to-D conversion
		.sysclk (CLOCK_50), 										// order of parameters do not matter
		.channel (1'b1), 											// use only CH1
		.start (tick_10k),
		.data_from_adc (data_in),
		.data_valid (data_valid),
		.sdata_to_adc (ADC_SDI),
		.adc_cs (ADC_CS),
		.adc_sck (ADC_SCK),
		.sdata_from_adc (ADC_SDO));		
					
	var_delay VARIABLE_DELAY (CLOCK_50, data_valid, SW[8:0], data_in, data_out);	// do some processing on the data
	
	
	assign delay_val = SW[8:0]*10'd1628;
	bin2bcd_16 (delay_val[19:9],BCD_0, BCD_1, BCD_2, BCD_3,BCD_4);
	
	hex_to_7seg		SEG0 (HEX0, BCD_0);			
	hex_to_7seg		SEG1 (HEX1, BCD_1);			
	hex_to_7seg		SEG2 (HEX2, BCD_2);			
	hex_to_7seg		SEG3 (HEX3, BCD_3);
	hex_to_7seg		SEG4 (HEX4, BCD_4);
endmodule


