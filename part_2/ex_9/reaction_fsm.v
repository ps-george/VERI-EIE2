module reaction_fsm(
	clk,
	tick,
	trigger,
	time_out,
	lfsr_en,
	start_delay,
	start_timer,
	ledr
);
	input clk,tick,trigger,time_out;
	output reg lfsr_en,start_delay;
	output reg [9:0] ledr;
	output reg start_timer;
	
	reg [3:0] state;
	initial lfsr_en = 0;
	initial ledr = 10'b0;
	initial state = 4'b0;
	initial start_delay = 0;
	reg timeout;
	initial timeout = 0;
	reg triggered;
	initial triggered = 0;
	
	
	always @ (posedge clk) begin
		if (state == 12) begin
			if (time_out==1) begin
				timeout <= 1;
			end
		end
		else
			timeout <= 0;
		if (~state)
			if (trigger == 0)
				triggered <= 1;
		else
			triggered <= 0;
	end
	
	always @ (posedge tick) begin
		start_timer <= 0;
		case(state)
		0: begin
			if (triggered) begin
				state <= 1;
				lfsr_en <= 1;
			end
		end
		
		// pause lfsr and start delay timer
		11: begin
			lfsr_en<=0;
			start_delay<=1;
			state <= state+1;
		end
		12: begin
			start_delay<=0;
			if (timeout)
				state <= state + 1;
		end
		13: begin
			start_timer <= 1;
			ledr[9:0] = 0;
			state <= 0;
		end
		default: begin
		// If the state is 1-10, turn on an LED and increment state
			state <= state + 1;
			ledr[state-1] <= 1;
		end
		endcase
	end
		
endmodule
