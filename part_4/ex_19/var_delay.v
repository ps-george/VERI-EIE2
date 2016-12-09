//------------------------------
// Module name: multiple echo processor
// Function: Simply to pass input to output delayed by 0.8192ms, and attenuated
//------------------------------

module var_delay (sysclk, valid, rdelay, data_in, data_out);
	input [8:0]		rdelay;
	input 			valid; 
	input				sysclk;		// system clock
	input [9:0]		data_in;		// 10-bit input data
	output [9:0] 	data_out;	// 10-bit output data

	wire				sysclk;
	wire [9:0]		data_in;
	reg [9:0] 		data_out;
	wire [9:0]		x,y;
	wire [8:0] 		q;

	parameter 		ADC_OFFSET = 10'h181;
	parameter 		DAC_OFFSET = 10'h200;

	wire PLS;
	reg [12:0] COUNT;
	initial COUNT = 13'b0;
	assign x = data_in[9:0] - ADC_OFFSET;		// x is input in 2's complement
	
	// This part should include your own processing hardware 
	// ... that takes x to produce y
	// ... In this case, it is ALL PASS.
	pulse_gen PULSE (.pulse(PLS), .in(valid), .clk(sysclk));

	
	always @ (negedge valid) begin
		COUNT <= COUNT + 1'b1;
	end
	
	delay_ram DELAY(
	.clock(sysclk),
	.data(y[9:1]),
	.rdaddress(COUNT),
	.rden(PLS),
	.wraddress(COUNT + {rdelay,4'b0}),
	.wren(PLS),
	.q(q)
	);
	
	assign y = x-{q[8],q[8:0]};
	
	//  Now clock y output with system clock
	always @(posedge sysclk)
		if (rdelay == 0)
			data_out <= x + DAC_OFFSET;
		else
			data_out <=  y + DAC_OFFSET;
		
endmodule
	