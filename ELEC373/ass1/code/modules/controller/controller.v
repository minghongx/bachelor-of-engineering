module controller (  // glue logic
	input clk_i,
	input rst_ni,
	input up_i,
	input down_i,
	input entry_i,
	input restart_i,
	input entering_last_digit_i,
	output reg enable_cntr_o,
	output reg updown_o,
	output reg enable_sft_o,
	output reg enable_lock_o,
	output reg rst_cntr_no,
	output reg rst_entry_indicator_no,
	output reg rst_sft_reg_no
);

reg [1:0] state_d, state_q;
parameter Idle = 2'b00;
parameter Entering = 2'b01;
parameter Entered  = 2'b10;

always @(posedge clk_i, negedge rst_ni)
	if (~rst_ni)
		state_q <= Idle;
	else
		state_q <= state_d;

always @(state_q, up_i, down_i, entry_i, restart_i) begin
	state_d = state_q;
	enable_cntr_o = 1'b0;
	updown_o = 1'b1;
	enable_sft_o = 1'b0;
	enable_lock_o = 1'b1;
	rst_cntr_no = 1'b1;
	rst_entry_indicator_no = 1'b1;
	rst_sft_reg_no = 1'b1;

	case (state_d)
		Idle: begin
			enable_lock_o = 1'b0;
			rst_cntr_no = 1'b0;
			rst_entry_indicator_no = 1'b0;
			rst_sft_reg_no = 1'b0;
			if (restart_i)
				state_d = Entering;
		end

		Entering: begin
			if (up_i) begin
				updown_o = 1'b1;
				enable_cntr_o = 1'b1;
			end else if (down_i) begin
				updown_o = 1'b0;
				enable_cntr_o = 1'b1;
			end

			if (entry_i)
				if (entering_last_digit_i)
					state_d = Entered;
				else
					enable_sft_o = 1'b1;
		end

		Entered:
			if (restart_i) begin
				state_d = Entering;
				rst_cntr_no = 1'b0;
				rst_entry_indicator_no = 1'b0;
				rst_sft_reg_no = 1'b0;
			end
	endcase
end

endmodule
