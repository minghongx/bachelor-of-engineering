module counter (
	input clk_i,
	input rst_ni,
	input updown_i,
	input enable_i,
	output [3:0] bcd_o,
	output reg rc_o  // ripple carry output
);

reg [3:0] state_d, state_q;
assign bcd_o = state_q;

parameter Start = 4'b0000;
parameter Stop  = 4'b1001;

always @(posedge clk_i, negedge rst_ni)
	if (~rst_ni)
		state_q <= Start;
	else
		state_q <= state_d;

always @(state_q, enable_i, updown_i) begin
	rc_o = 1'b0;
	state_d = state_q;  // default assignment next state is present state
	if (enable_i)
		if (updown_i)  // count up
			if (state_d == Stop) begin
				state_d = Start;
				rc_o = 1'b1;
			end else
				state_d = state_d + 1'b1;
		else  // count down
			if (state_d == Start)
				state_d = Start;
			else
				state_d = state_d - 1'b1;
end

endmodule
