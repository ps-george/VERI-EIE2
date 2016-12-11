[Main readme](../readme.MD) | [Part one](../part_1) | [Part two](../part_2) | [Part three](../part_3) | [Part four](../part_4)

# Experiment 16 - Implement audio all-pass loop (and amplify by 4 loop)

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

# Experiment 17 - Echo synthesizer with fixed delay
* Changes from previous example:
  
  1. Added a FIFO block.
  2. Monitored the `.full` signal to detect when the FIFO was filled.
  3. Once the FIFO is filled, started to read from the FIFO.
  4. Shifted the output from the FIFO to the right by 1 and added it to the input

* This gives a single, fixed delay proportional to the length of the FIFO.
  
  * In this case, the FIFO was 8192x10-bit, so with the 10KHz sample frequency it gives a delay of 0.8192ms.
  
# Experiment 18 - Multiple echoes
* Feed output from the FIFO into input
* Why do we subtract instead of add?


# Experiment 19 - Echo Synthesizer with variable delay
