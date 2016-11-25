
module delay_16(
	clk,
	trigger,
	N,
	time_out
);

	input clk;
	input trigger;
	input [15:0] N;
	output time_out;
	
	reg triggered;
	initial triggered = 0;
	
	always @ (posedge clk)
		if (trigger==1'b1)
			triggered <= 1;
	
	modulo_counter_16 MOD_N(clk,triggered,0,N,time_out);

endmodule
