module sync (
	input clk_i,
	input d_i,
	output q_o
);

reg [1:0] sft_reg;

always@(posedge clk_i)
	sft_reg <= {sft_reg[0], d_i};

assign q_o = sft_reg[1];

endmodule
