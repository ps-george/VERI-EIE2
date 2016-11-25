`timescale 1ns / 100ps    // Unit time is 1ns, resolution 100ps
//-----------------------------------------------------------
// Design Name: counter_16
// Function: a 16-bit synchronous counter with enable input
//-----------------------------------------------------------

module counter_16 (
	clock, // clock input
	enable, // high enable counting
	sreset, // Synchronous reset
	count // count value
	
);

//------- Declare ports -------//

	parameter BIT_SZ = 16;
	input clock;
	input enable;
	input sreset;
	output [BIT_SZ-1:0] count;
	
// count needs to be declared as a reg
	reg [BIT_SZ-1:0] count;
	
//----- always initialise storage elements such as D-FF
	initial count = 0;
	
//----- Main body of the module
	
	always @ (posedge clock) begin
		if (sreset == 1'b1) begin
			count <= 1'b0;
		end
		if (enable == 1'b1) begin
			count <= count + 1'b1;
		end
	end
endmodule // end of module
