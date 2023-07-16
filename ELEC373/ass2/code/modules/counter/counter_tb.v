module counter_tb;

// Inputs
reg clk;
reg rst_n;
reg ena_i;
reg updown_i;

// Outputs
wire [3:0] cnt_o;

counter DUT (
	.clk_i(clk),
	.rst_ni(rst_n),
	.ena_i(ena_i),
	.updown_i(updown_i),
	.cnt_o(cnt_o)
);

// Create a 50Mhz clock
always #10 clk = !clk;  // every ten nanoseconds invert

initial begin
	clk = 1'b0;
	rst_n = 1'b0;
	ena_i = 1'b0;  // disabled
	updown_i = 1'b1;  // count up
end

initial begin
	#20 rst_n = 1'b1;  // release reset

	// Test 0 -> 9
	@(posedge clk);
	ena_i = 1'b1;
	@(posedge clk);
	ena_i = 1'b0;
	updown_i = 1'b0;
	@(posedge clk);
	ena_i = 1'b1;
	@(posedge clk);
	ena_i = 1'b0;
	@(posedge clk);
	ena_i = 1'b1;
	@(posedge clk);
	ena_i = 1'b0;
	
	// Test 9 -> 0
	updown_i = 1'b1;
	@(posedge clk);
	ena_i = 1'b1;
	@(posedge clk);
	ena_i = 1'b0;
	@(posedge clk);
	ena_i = 1'b1;
	@(posedge clk);
	ena_i = 1'b0;

	// Test reset
	@(posedge clk);
	ena_i = 1'b1;
	@(posedge clk);
	ena_i = 1'b0;
	@(posedge clk);
	ena_i = 1'b1;
	@(posedge clk);
	ena_i = 1'b0;
	@(posedge clk);
	rst_n = 1'b0;
	@(posedge clk);
	rst_n = 1'b1;

// Finish the Simulation
	#100;
	$finish;
end

endmodule
