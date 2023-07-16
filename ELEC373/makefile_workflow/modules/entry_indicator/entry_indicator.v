module entry_indicator (
	input clk_i,
	input rst_ni,
	input entry_i,
	output entering_last_digit_o
);

reg [2:0] state_d, state_q;
parameter EnteringLastDigit = 3'd3;

assign entering_last_digit_o = state_q == EnteringLastDigit;

always @(posedge clk_i, negedge rst_ni)
	if (~rst_ni)
		state_q <= 3'd0;
	else
		state_q <= state_d;

always @(state_q, entry_i) begin
	state_d = state_q;  // default assignment next state is present state
	if (entry_i)
		if (state_d == EnteringLastDigit)
			state_d = EnteringLastDigit;
		else
			state_d = state_d + 1'b1;
end

endmodule
