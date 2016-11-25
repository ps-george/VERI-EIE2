

module lfsr7 (clk, data_out);
	
	input clk;
	output [6:0] data_out; // 7-bit random output
	
	reg [6:0] sreg;
	
	initial sreg = 7'b1;
	
	always @ (posedge clk)
		sreg <= {sreg[5:0], sreg[6] ^ sreg[0]};
	
	assign data_out = sreg;
endmodule
