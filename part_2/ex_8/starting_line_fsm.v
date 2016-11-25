module starting_line_fsm(
	clk,
	tick,
	trigger,
	time_out,
	lfsr_en,
	start_delay,
	ledr
);
	input clk,tick,trigger,time_out;
	output reg lfsr_en,start_delay;
	output reg [9:0] ledr;
	
	reg state;
	initial lfsr_en = 0;
	initial ledr = 10'b0;
	initial state = 4'b0;
	initial start_delay = 0;
	reg triggered;
	initial triggered = 0;
	
	always @ (trigger)
		if ((trigger==1) & (state==0)) begin
			lfsr_en <= 1;
			triggered <=1;
		end
	always @ (time_out)
		if ((time_out==1)&(state==12))
			state <= 13;
	
	
	
	always @ (posedge tick) begin
		if (triggered == 1)
			state <= 1;
			triggered <= 0;
		// If the state is 1-10, turn on an LED and increment state
		if (11 > state > 0) begin
			state <= state + 1;
			ledr[state-1] <= 1;
		end
		// pause lfsr and start delay timer
		if (state==11)
			lfsr_en<=0;
			// Never reset start_delay, should do that at some point..
			start_delay<=1;
			state <= state+1;
		if (state==12)
			start_delay<=0;
		if (state==13)
			ledr[9:0] = 0;
	end
		
endmodule
