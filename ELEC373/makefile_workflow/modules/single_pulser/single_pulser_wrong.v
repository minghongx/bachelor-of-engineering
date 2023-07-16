module single_pulser_wrong (
	input clk_i,
	input rst_ni,
	input key_ni,
	output reg pulse_o
);

reg [1:0] state_d, state_q;
parameter WaitPressing = 1'b0;
parameter WaitReleasing = 1'b1;

always @(posedge clk_i, negedge rst_ni)
	if (~rst_ni)
		state_q <= WaitPressing;
	else
		state_q <= state_d;

always @(state_q, key_ni) begin
	pulse_o = 1'b0;
	state_d = state_q;
	case (state_d)
		WaitPressing:
			if (~key_ni) begin
				state_d = WaitReleasing;
				pulse_o = 1'b1;  // WRONG!!! Generated pulse is not sync w/ the clk
			end
		WaitReleasing:
			if (key_ni)
				state_d = WaitPressing;
	endcase
end

endmodule
