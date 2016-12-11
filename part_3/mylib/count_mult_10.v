`timescale 1ns / 100ps    // Unit time is 1ns, resolution 100ps
//-----------------------------------------------------------
// Design Name: counter_mult_10
// Function: an 10-bit synchronous counter with enable input and an input to determine what multiple to count in
//-----------------------------------------------------------

module counter_mult_10 (
	clock, // clock input
	enable, // high enable counting
	multiple, // count in these multiples
	count // count value
);

//------- Declare ports -------//

	parameter BIT_SZ = 10;
	input clock;
	input enable;
	input [9:0] multiple;
	output [BIT_SZ-1:0] count;
	
// count needs to be declared as a reg
	reg [BIT_SZ-1:0] count;
	
//----- always initialise storage elements such as D-FF
	initial count = 0;
	
//----- Main body of the module
	
	always @ (posedge clock)
		if (enable == 1'b1)
			count <= count + multiple;
endmodule // end of module
