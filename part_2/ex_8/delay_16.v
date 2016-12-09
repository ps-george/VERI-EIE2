
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
		if (trigger == 1'b1)
			state <= 1;
		if (out == 1) begin
			time_out <= 1;
			state <= 0;
		end
		else
			time_out <= 0;
	end
endmodule
