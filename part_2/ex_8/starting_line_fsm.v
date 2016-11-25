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
	output lfsr_en,start_delay;
	output [9:0] ledr;
	
	reg lfsr_en;
	reg ledr;
	reg state;
	initial lfsr_en = 0;
	initial ledr = 10'b0;
	initial state = 4'b0;
	
	always @ (trigger)
		if (trigger==1) begin
			state <= 1;
			lfsr_en <= 1;
		end
	always @ (time_out)
		if ((time_out==1)&(state==11))
			state <= 12;
	
	always @ (posedge tick) begin
		// If the state is 1-10, turn on an LED and increment state
		if (11 > state > 0) begin
			state <= state + 1;
			ledr[state-1] <= 1;
		end
		// pause lfsr at some point
		if (state==11) begin
			lfsr_en<=0;
		end
		if (state==12) begin
			ledr[9:0] = 0;
		end
	end	
		
endmodule
