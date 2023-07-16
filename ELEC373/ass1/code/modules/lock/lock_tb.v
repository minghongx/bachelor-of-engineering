module lock_tb;

// Inputs
reg enable_i;
reg unlock_i;

// Outputs
wire ledr_o;
wire ledg_o;

lock DUT (
	.enable_i(enable_i),
	.unlock_i(unlock_i),
	.ledr_o(ledr_o),
	.ledg_o(ledg_o)
);

initial begin
	enable_i = 1'b0;  // disabled
	unlock_i = 1'b0;  // locked
end

initial begin
	#20;

	unlock_i = 1'b1;
	#20;
	unlock_i = 1'b0;
	#20;

	enable_i = 1'b1;  // enabled
	unlock_i = 1'b1;
	#20;
	unlock_i = 1'b0;
	#40;

// Finish the Simulation
	#100;
	$finish;
end

endmodule
