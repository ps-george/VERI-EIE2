#Exercise 5
*Created new project and [./ex_5/counter_8.v](counter_8.v)
`add wave clock enable
add wave -hexadecimal count
force clock 0 0ns, 1 10ns -repeat 20ns
force enable 1
run 100ns
...`

#Exercise 6
*[links to source code]
*error with compiler needed space after .sdc code
## TimeQuest Timing Analyzer - Maximum clock frequency
1) What are the predicted maximum frequencies for this circuit under the highest and lowest temperatures?
Lowest temperature: 422.65 MHz
Highest temperature: 444.84 MHz
2) What are the other interesting timing data that you can discover with these reports?
* Worst-case Setup and Hold time slack details
* Metastability Summary
* Minimum Pulse Width
* Input Transition Times
3) Why is the TimeQuest entry red, indicating that there may be a problem?
The entry is red because data specifying timing constraints it not available for a number of the user-specified inputs.

##FPGA resources
*Explain results:
1)
2)
3)

#Exercise 7
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

#Exercise 8

