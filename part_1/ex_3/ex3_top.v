//-------------------------------
// Module name: ex3_top
// Function: top level module for this design
//           10-bit hex to one display
//--------------------------------

module ex3_top (
	SW,
	HEX0, HEX1, HEX2
);
	input [9:0] SW;
	output [6:0] HEX0;
	output [6:0] HEX1;
	output [6:0] HEX2;
	
	wire[3:0] SW0;
	wire[3:0] SW1;
	wire[3:0] SW2;
	
	assign SW0 = SW[3:0];
	assign SW1 = SW[7:4];
	assign SW2 = SW[9:8];
	
	hex_to_7seg SEG0 (HEX0, SW0);
	hex_to_7seg SEG1 (HEX1, SW1);
	hex_to_7seg SEG2 (HEX2, SW2);
endmodule
