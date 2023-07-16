module entry_indicator_tb;

// Inputs
reg clk;
reg rst_n;
reg entry_i;

// Outputs
wire entering_last_digit_o;

entry_indicator DUT (
	.clk_i(clk),
	.rst_ni(rst_n),
	.entry_i(entry_i),
	.entering_last_digit_o(entering_last_digit_o)
);

// Create a 50Mhz clock
always #10 clk = !clk;  // every ten nanoseconds invert

initial begin
	clk = 1'b0;
	rst_n = 1'b0;
   entry_i = 1'b0;
end

initial begin
	#20 rst_n = 1'b1;  // release reset

	repeat (6) begin
		@(posedge clk);
		entry_i = 1'b1;
		@(posedge clk);
		entry_i = 1'b0;
	end

	#40;
	
	$finish;
end

endmodule
