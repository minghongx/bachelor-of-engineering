module assignment1_tb;

// Inputs
reg clk;
reg rst_n;
reg key_up_ni;
reg key_down_ni;
reg key_entry_ni;
reg key_restart_ni;

// Outputs
wire [6:0] sevenseg_0;
wire [6:0] sevenseg_1;
wire [6:0] sevenseg_2;
wire [6:0] sevenseg_3;
wire ledr_o;
wire ledg_o;

assignment1 DUT (
	.clk_i(clk),
	.rst_ni(rst_n),
	.key_up_ni(key_up_ni),
	.key_down_ni(key_down_ni),
	.key_entry_ni(key_entry_ni),
	.key_restart_ni(key_restart_ni),
	.sevenseg_0_o(sevenseg_0),
	.sevenseg_1_o(sevenseg_1),
	.sevenseg_2_o(sevenseg_2),
	.sevenseg_3_o(sevenseg_3),
	.ledr_o(ledr_o),
	.ledg_o(ledg_o)
);

// Create a 50Mhz clock
always #10 clk = !clk;  // every ten nanoseconds invert

initial begin
	clk = 1'b0;
	rst_n = 1'b0;
   key_up_ni = 1'b1;
   key_down_ni = 1'b1;
   key_entry_ni = 1'b1;
	key_restart_ni = 1'b1;
end

initial begin
	#20 rst_n = 1'b1;  // release reset

	

	$finish;
end

endmodule
