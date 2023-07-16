module sync_tb;

// Inputs
reg clk;
reg d_i;

// Outputs
wire q_o;

sync DUT (
	.clk_i(clk),
	.d_i(d_i),
	.q_o(q_o)
);

// Create a 50Mhz clock
always #10 clk = !clk;  // every ten nanoseconds invert

initial begin
	clk = 1'b0;
	d_i = 1'b1;
end

initial begin
	#20;

	// Long press
	#16;
	d_i = 1'b0;
	#43;
	d_i = 1'b1;

	// Brief contact
	#46;
	d_i = 1'b0;
	#3;
	d_i = 1'b1;
	#20;
	
	// Long press after brief contact
	#16;
	d_i = 1'b0;
	#43;
	d_i = 1'b1;
	#100;

// Finish the Simulation
	#100;
	$finish;
end

endmodule
