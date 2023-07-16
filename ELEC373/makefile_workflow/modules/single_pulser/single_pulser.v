module single_pulser (
	input clk_i,
	input rst_ni,
	input key_ni,
	output reg pulse_o
);

reg [1:0] state_d, state_q;
parameter WaitPressing = 2'b00;
parameter Pressed = 2'b01;
parameter WaitReleasing = 2'b10;

always @(posedge clk_i, negedge rst_ni)
	if (!rst_ni)
		state_q <= WaitPressing;
	else
		state_q <= state_d;

always @(state_q, key_ni) begin
	pulse_o = 1'b0;
	state_d = state_q;

	case (state_d)
		WaitPressing:
			if (!key_ni)
				state_d = Pressed;

		Pressed:
			if (!key_ni) begin
				pulse_o = 1'b1;
				state_d = WaitReleasing;
			end else
				state_d = WaitPressing;

		WaitReleasing:
			if (key_ni)
				state_d = WaitPressing;
	endcase
end

endmodule
