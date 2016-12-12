[Main readme](../readme.MD) | [Part one](../part_1) | [Part two](../part_2) | [Part three](../part_3) | [Part four](../part_4)

# Experiment 5 - Designing a counter (and testing using Quartus Simulation Tools)
* Created new project and [counter_8.v](./ex_5/counter_8.v)
`add wave clock enable
add wave -hexadecimal count
force clock 0 0ns, 1 10ns -repeat 20ns
force enable 1
run 100ns
...`

# Experiment 6 - Implementing the counter on DE0 (and cascading counters to make it human-detectable)
* [links to source code]
* error with compiler needed space after .sdc code

`create_clock -name "CLOCK_50" -period 20.000ns [get_ports {CLOCK_50}]`

## TimeQuest Timing Analyzer - Maximum clock frequency
1. What are the predicted maximum frequencies for this circuit under the highest and lowest temperatures?

  * Lowest temperature: 422.65 MHz
  * Highest temperature: 444.84 MHz

2. What are the other interesting timing data that you can discover with these reports?
  
  * Worst-case Setup and Hold time slack details
  * Metastability Summary
  * Minimum Pulse Width
  * Input Transition Times

3. Why is the TimeQuest entry red, indicating that there may be a problem?

  * The entry is red because data specifying timing constraints it not available for a number of the user-specified inputs.

## FPGA resources
### Explain results:

|Metric|Numbers|
|---|---|
Logic utilization (in ALMs)|37/32,070 (< 1%)
Total registers|0
Total pins|38/457 (8%)
Total block memory bits|0/4,065,280 (0%)
Total DSP blocks|0/87 (0%)
Total PLLS|0
Total DLLS|0

# Experiment 7 - Creating a PRBS (Pseudo-Random Bit Sequence) using a LFSR (Linear Feedback Shift Register)
* Manual calculation of the first 10 numbers in the 7-bit LFSR implementing polynomial `1 + X^3 + X^7`

|Q6|Q5|Q4|Q3|Q2|Q1|Q0|count|
|---|---|---|---|---|---|---|---|
0|0|0|0|0|0|1|1
0|0|0|0|0|1|1|3
0|0|0|0|1|1|1|7
0|0|0|1|1|1|1|15
0|0|1|1|1|1|1|31
0|1|1|1|1|1|1|63
1|1|1|1|1|1|1|(1)27
1|1|1|1|1|1|0|(1)26
1|1|1|1|1|0|1|(1)25
1|1|1|1|0|1|0|(1)22

VIDEO

# Experiment 8 - Creating a starting line delay circuit
Default: Turn on another LED, increment state

|State descr|State|Input required for next state|Output|
|---|---|---|---|
|Wait| 0  | trigger=0 (active low)  | en_lfsr = 1, state = 1 |
|Start delay| 11 | tick_hs | en_lfsr = 0, start_delay = 1 |
|Wait delay| 12 | timeout=1 | start_delay = 0 |
|LED OFF| 13 | tick_hs | LEDR[9:0] = 0 |

VIDEO

## Second clock divider should divide by 500 instead of 2500
- 50MHz / 50000 = 1000Hz (1ms period)
- 1000Hz / 2500 = 0.4Hz (2.5s period)
- 1000Hz / 500 = 2Hz (0.5s period)

# Experiment 9 - Modify experiment 8 to create a Reaction Meter
- Create a new module named timer_16 clocked with 1ms clock
- Modify FSM to add a new output to start the timing
- Display timer_16 output on HEX diplay when it has been stopped

VIDEO




