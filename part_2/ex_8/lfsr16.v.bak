

module lfsr16 (clk, data_out);
	
	input clk;
	output [13:0] data_out; // 7-bit random output
	
	reg [15:0] sreg;
	
	initial sreg = 16'b1;
	
	always @ (posedge clk)
		sreg <= {sreg[14:0], sreg[0] ^ sreg[2] ^ sreg[11] ^ sreg[15] };
	
	assign data_out = sreg;
endmodule
