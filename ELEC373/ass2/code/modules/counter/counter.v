module counter (
	input clk_i,
	input rst_ni,
	input ena_i,
	input updown_i,
	output reg [3:0] cnt_o
);

always @(posedge clk_i, negedge rst_ni)
	if (!rst_ni)
		cnt_o <= 4'b0;
	else if (!ena_i)
		cnt_o <= cnt_o;
	else
		if (updown_i)
			if (cnt_o == 4'd9)
				cnt_o <= 4'b0;
			else
				cnt_o <= cnt_o + 1'b1;
		else
			if (cnt_o == 4'd0)
				cnt_o <= 4'd9;
			else
				cnt_o <= cnt_o - 1'b1;

endmodule
