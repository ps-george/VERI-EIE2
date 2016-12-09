

module lfsr16 (clk,en, data_out);
	input clk;
	input en;
	output [13:0] data_out; // 7-bit random output
	reg [13:0] data_out;
	reg [15:0] sreg;
	
	initial sreg = 16'b1;
	
	always @ (posedge clk) begin
		if (en==1'b1) begin
			sreg <= {sreg[14:0], sreg[0] ^ sreg[2] ^ sreg[11] ^ sreg[15] };
			data_out <= 0;
		end
		if (en==1'b0)
			data_out <= sreg;
	end
endmodule
