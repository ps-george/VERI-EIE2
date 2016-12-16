[Main readme](../readme.MD) | [Part one](../part_1) | [Part two](../part_2) | [Part three](../part_3) | [Part four](../part_4)

# Objective of Lab

* Learn how to use the ADC and DAC with the FPGA in a practical audio processing system.
* Create a real-time echo chamber effect.

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

### Demonstration Video
https://youtu.be/YxDPZpT5f70

# Experiment 17 - Echo synthesizer with fixed delay
* Changes from previous example:
  
  1. Added a FIFO block.
  2. Monitored the `.full` signal to detect when the FIFO was filled.
  3. Once the FIFO is filled, started to read from the FIFO.
  4. Shifted the output from the FIFO to the right by 1 and added it to the input

* This gives a single, fixed delay proportional to the length of the FIFO.
  
  * In this case, the FIFO was 8192x10-bit, so with the 10KHz sample frequency it gives a delay of 0.8192ms.
  * Used attenuation factor of 1/2.
  
# Experiment 18 - Multiple echoes
* Feed output from the FIFO subtracted from x into input of the FIFO.

### Demonstration Video
https://youtu.be/2h9hjTysqWM

* Why do we subtract instead of add?
  
  * To avoid positive feedback.

# Experiment 19 - Echo Synthesizer with variable delay
* Changes from previous example:
  1. Replaced the FIFO block with a RAM block.
  2. Created a 13-bit address counter.
  3. The gap between the read address and the write address is determined by the value of the switches.
  4. The delay value determined by the switches, in ms, is displayed on the LED display.
  
### Demonstration Video
https://youtu.be/fw2YzHBKjQY

 * Why are 13 bits used for the counter?

  * To ensure a suitable and audible range of variable delays when using the 9 bits provided from SW[8:0] left shifted by 4 bits as the delay value and a 10KHz rate of incrementation.
  
 * Why is the value of SW[8:0] multiplied by 1638 and why is the most significant 10 bits of the product the delay in milliseconds?

  * To get the delay value in milliseconds, the decimal value of the switches must be multiplied by 1.6. Multiplying by 1638 and taking the most significant 10 bits only (therefore dividing by 1024) is equivalent to this. This is done to avoid performing direct division within the design.
  

  
