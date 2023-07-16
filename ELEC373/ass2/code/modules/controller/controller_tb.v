module controller_tb;

// Inputs
reg clk;
reg rst_n;
reg up_i;
reg down_i;
reg entry_i;
reg restart_i;
reg entering_last_digit_i;

// Outputs
wire enable_cntr_o;
wire updown_o;
wire enable_sft_o;
wire enable_lock_o;
wire rst_cntr_no;
wire rst_entry_indicator_no;
wire rst_sft_reg_no;

controller DUT (
	.clk_i(clk),
	.rst_ni(rst_n),
	.up_i(up_i),
	.down_i(down_i),
	.entry_i(entry_i),
	.restart_i(restart_i),
	.entering_last_digit_i(entering_last_digit_i),
	.enable_cntr_o(enable_cntr_o),
	.updown_o(updown_o),
	.enable_sft_o(enable_sft_o),
	.enable_lock_o(enable_lock_o),
	.rst_cntr_no(rst_cntr_no),
	.rst_entry_indicator_no(rst_entry_indicator_no),
	.rst_sft_reg_no(rst_sft_reg_no)
);

// Create a 50Mhz clock
always #10 clk = !clk;  // every ten nanoseconds invert

initial begin
	clk = 1'b0;  // at time 0
	rst_n = 1'b0;  // reset is active
	up_i = 1'b0;
	down_i = 1'b0;
	entry_i = 1'b0;
	restart_i = 1'b0;
	entering_last_digit_i = 1'b0;
end

initial begin
	#20 rst_n = 1'b1;  // release reset

// State: Idle

	// Move to State Entering
	@(posedge clk);
	restart_i = 1'b1;
	@(posedge clk);
	restart_i = 1'b0;	

// State: Entering

	@(posedge clk);
	up_i = 1'b1;
	@(posedge clk);
	up_i = 1'b0;

	@(posedge clk);
	down_i = 1'b1;
	@(posedge clk);
	down_i = 1'b0;

	@(posedge clk);
	entry_i = 1'b1;
	@(posedge clk);
	entry_i = 1'b0;

	// Move to State Entered
	entering_last_digit_i = 1'b1;
	@(posedge clk);
	entry_i = 1'b1;
	@(posedge clk);
	entry_i = 1'b0;

// State: Entered

	@(posedge clk);
	up_i = 1'b1;
	@(posedge clk);
	up_i = 1'b0;

	@(posedge clk);
	down_i = 1'b1;
	@(posedge clk);
	down_i = 1'b0;

	@(posedge clk);
	entry_i = 1'b1;
	@(posedge clk);
	entry_i = 1'b0;

	// Move to State Entering
	@(posedge clk);
	restart_i = 1'b1;
	@(posedge clk);
	restart_i = 1'b0;	
	entering_last_digit_i = 1'b0;

// State: Entering

	@(posedge clk);
	up_i = 1'b1;
	@(posedge clk);
	up_i = 1'b0;

	@(posedge clk);
	down_i = 1'b1;
	@(posedge clk);
	down_i = 1'b0;

	@(posedge clk);
	entry_i = 1'b1;
	@(posedge clk);
	entry_i = 1'b0;

// Reset

	#20 rst_n = 1'b0;

// Finish the Simulation
	#100;
	$finish;
end

endmodule
