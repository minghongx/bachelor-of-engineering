module shift_reg_tb;

parameter DataWidth = 5;

// Inputs
reg clk;
reg rst_n;
reg enable_i;
reg [DataWidth-1:0] d_i;

// Outputs
wire [DataWidth-1:0] reg_0_o;
wire [DataWidth-1:0] reg_1_o;
wire [DataWidth-1:0] reg_2_o;

shift_reg #(
	.DataWidth(DataWidth)
) DUT (
	.clk_i(clk),
	.rst_ni(rst_n),
	.enable_i(enable_i),
	.d_i(d_i),
	.reg_0_o(reg_0_o),
	.reg_1_o(reg_1_o),
	.reg_2_o(reg_2_o)
);

// Create a 50Mhz clock
always #10 clk = !clk;  // every ten nanoseconds invert

initial begin
	clk = 1'b0;
	rst_n = 1'b0;
	enable_i = 1'b0;
	d_i = 5'd4;
end

initial begin
	#20 rst_n = 1'b1;  // release reset

	// Shift a same value multiple times
	repeat (4) begin
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

	// Shift
	d_i = 5'd7;
	@(posedge clk);
	enable_i = 1'b1;
	@(posedge clk);
	enable_i = 1'b0;

// Finish the Simulation
	#100;
	$finish;
end

endmodule
