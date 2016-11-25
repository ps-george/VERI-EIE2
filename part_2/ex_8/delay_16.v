
module delay_16(
	clk,
	trigger,
	N,
	time_out
);

	input clk;
	input trigger;
	input [15:0] N;
	output reg time_out;
	
	wire out;
	reg state;
	initial state = 0;
	// clk, enable, reset, N, out
	modulo_counter_16 MOD_N(clk,state,0,N,out);
	
	always @ (posedge clk) begin
		if (trigger == 1'b1) begin
			state <= 1;
			time_out <= out;
		end
		if (out == 1) begin
			state <= 0;
		end
	end
endmodule
