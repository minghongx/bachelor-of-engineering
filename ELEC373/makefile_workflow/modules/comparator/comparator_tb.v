module comparator_tb;

reg enable_i;
reg [3:0] bcd_0_i;
reg [3:0] bcd_1_i;
reg [3:0] bcd_2_i;
reg [3:0] bcd_3_i;

wire equal_o;

comparator DUT (
	.enable_i(enable_i),
	.bcd_0_i(bcd_0_i),
	.bcd_1_i(bcd_1_i),
	.bcd_2_i(bcd_2_i),
	.bcd_3_i(bcd_3_i),
	.equal_o(equal_o)
);

initial begin
	enable_i = 1'b0;
	bcd_0_i = 4'd0;
	bcd_1_i = 4'd0;
	bcd_2_i = 4'd0;
	bcd_3_i = 4'd0;
end

initial begin
	#100;

	bcd_0_i = 4'd2;
	bcd_1_i = 4'd8;
	bcd_2_i = 4'd0;
	bcd_3_i = 4'd1;
	#100;

	enable_i = 1'b1;
	#100;

	bcd_0_i = 4'd4;
	bcd_1_i = 4'd4;
	bcd_2_i = 4'd4;
	bcd_3_i = 4'd4;
	#100;

// Finish the Simulation
	#100;
	$finish;
end

endmodule
