# ex16

ex16_top
- Data into spi2adc via sdata_to_adc
- Data out via wire data_in
- data_in into processor, data_out post-processing
- data_out into spi2dac which sends processed signal to DAC

spi2adc
- 10k tick into spi2adc starts data reading
- spi2adc sends adc_cs (active low) to adc and configuration bits
- Takes serial input and shifts into a parallel output per sample
- Two internal state machines: 
- One detects start and end of conversion acting on the 10k tick
- The other sends signals to interface with ADC,
then enables shifting of input bits into bus

allpass.v
- Subtracts offset of 385 from data_in
- Processes data (no processing done in allpass)
- Adds offset of 512 and outputs data