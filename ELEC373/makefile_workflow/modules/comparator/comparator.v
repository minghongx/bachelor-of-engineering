module comparator #(
	parameter bcd_digit_0 = 4'd2,
	parameter bcd_digit_1 = 4'd8,
	parameter bcd_digit_2 = 4'd0,
	parameter bcd_digit_3 = 4'd1
)(
	input enable_i,
	input [3:0] bcd_0_i,
	input [3:0] bcd_1_i,
	input [3:0] bcd_2_i,
	input [3:0] bcd_3_i,
	output equal_o
);

assign equal_o = &{
	enable_i,
	bcd_digit_0 == bcd_0_i,
	bcd_digit_1 == bcd_1_i,
	bcd_digit_2 == bcd_2_i,
	bcd_digit_3 == bcd_3_i
};

endmodule
