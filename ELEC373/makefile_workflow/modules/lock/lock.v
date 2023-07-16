module lock (
	input enable_i,
	input unlock_i,
	output reg ledr_o,
	output reg ledg_o
);

always @(enable_i, unlock_i) begin
	ledr_o = 1'b0;
	ledg_o = 1'b0;
	if (enable_i)
		if (unlock_i)
			ledg_o = 1'b1;
		else
			ledr_o = 1'b1;
end

endmodule
