module entry_indicator_tb;

// Inputs
reg rst_n;
reg entry_i;

// Outputs
wire entering_last_digit_o;

entry_indicator DUT (
	.rst_ni(rst_n),
	.entry_i(entry_i),
	.entering_last_digit_o(entering_last_digit_o)
);

initial begin
	rst_n = 1'b0;
   entry_i = 1'b0;
end

initial begin
	#20 rst_n = 1'b1;  // release reset

	

	$finish;
end

endmodule
