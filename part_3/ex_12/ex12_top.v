/* Top level design entity for testing DAC
*  ex12_top.v
*/


module ex12_top(
	SW,
	CLOCK_50,
	HEX0,HEX1,HEX2
);
	input [9:0] SW;
	input CLOCK_50;
	output [6:0] HEX0,HEX1,HEX2;
	
	wire [9:0] data;
	ROM ROM1(SW, CLOCK_50, data);
	hex_to_7seg SEG0(data[3:0], HEX0);
	hex_to_7seg SEG1(data[7:4],HEX1);
	hex_to_7seg SEG2({2'b0,data[9:8]},HEX2);
	
endmodule
