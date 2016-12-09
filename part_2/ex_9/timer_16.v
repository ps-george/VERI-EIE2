

module timer_16(
	sysclk,
	clock,  // clock input
	sreset, // Synchronous reset
	start,
	stop,
	out   // out
);

//------- Declare ports -------//

	parameter BIT_SZ = 16;
	input sysclk;
	input clock;
	input sreset;
	input stop;
	input start;
	output reg [BIT_SZ-1:0] out;
	wire start;
	wire stop;
	reg [BIT_SZ-1:0] count;
//----- always initialise storage elements such as D-FF
	initial count = 0;
//----- Main body of the module
	reg state;
	always @ (posedge sysclk) begin			
		if (start)
			state <= 1;
		if (stop)
			state <= 0;
	end
	
	always @ (posedge clock) begin
		if (sreset == 1'b1)
			count <= 1'b0;
		if (state) begin
			count <= count + 1;
		end
		
		out <= count;
	end
endmodule
