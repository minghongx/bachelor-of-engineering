module single_pulser_tb;

// Inputs
reg clk;
reg rst_n;
reg key_ni;

// Outputs
wire pulse_o;

single_pulser DUT (
	.clk_i(clk),
	.rst_ni(rst_n),
	.key_ni(key_ni),
	.pulse_o(pulse_o)
);

// Create a 50Mhz clock
always #10 clk = !clk;  // every ten nanoseconds invert

initial begin
	clk = 1'b0;
	rst_n = 1'b0;
	key_ni = 1'b1;
end

initial begin
	#20 rst_n = 1'b1;  // release reset

	// Long press
	#16;
	key_ni = 1'b0;
	#43;
	key_ni = 1'b1;

	// Brief contact
	#26;
	key_ni = 1'b0;
	#3;
	key_ni = 1'b1;
	#20;
	
	// Long press after brief contact
	#16;
	key_ni = 1'b0;
	#43;
	key_ni = 1'b1;

// Finish the Simulation
	#100;
	$finish;
end

endmodule
