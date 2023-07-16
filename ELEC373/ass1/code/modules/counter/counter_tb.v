module counter_tb;

// Inputs
reg clk;
reg rst_n;
reg updown_i;
reg enable_i;

// Outputs
wire [3:0] cnt_o;
wire ripple_carry_o;

counter DUT (
	.clk_i(clk),
	.rst_ni(rst_n),
	.updown_i(updown_i),
	.enable_i(enable_i),
	.bcd_o(cnt_o),
	.rc_o(ripple_carry_o)
);

// Create a 50Mhz clock
always #10 clk = !clk;  // every ten nanoseconds invert

initial begin
	clk = 1'b0;
	rst_n = 1'b0;
	enable_i = 1'b0;  // disabled
	updown_i = 1'b1;  // count up
end

initial begin
	#20 rst_n = 1'b1;  // release reset

	// Test count up and ripple carry generation
	repeat (11) begin
		@(posedge clk);
		enable_i = 1'b1;
		@(posedge clk);
		enable_i = 1'b0;
	end

	// Reset
	@(negedge clk);
	rst_n = 1'b0;
	@(negedge clk);
	rst_n = 1'b1;

	// Test count down
	repeat (9) begin
		@(posedge clk);
		enable_i = 1'b1;
		@(posedge clk);
		enable_i = 1'b0;
	end
	//updown_i = 1'b0;  // count down
	repeat (10) begin
		@(posedge clk);
		enable_i = 1'b1;
		updown_i = 1'b0;
		@(posedge clk);
		enable_i = 1'b0;
		updown_i = 1'b1;
	end

// Finish the Simulation
	#100;
	$finish;
end

endmodule
