module assignment1 (
	input clk_i, 
	input rst_ni,
	input key_up_ni,
	input key_down_ni,
	input key_entry_ni,
	input key_restart_ni,
	output [6:0] sevenseg_0_o,
	output [6:0] sevenseg_1_o,
	output [6:0] sevenseg_2_o,
	output [6:0] sevenseg_3_o,
	output ledr_o,
	output ledg_o
);

wire key_up_syncin_n;
wire key_down_syncin_n;
wire key_entry_syncin_n;
wire key_restart_syncin_n;
wire up;
wire down;
wire entry;
wire restart;

wire enable_cntr;
wire updown;
wire enable_sft;
wire enable_lock;
wire entering_last_digit;
wire rst_cntr_n;
wire rst_entry_indicator_n;
wire rst_sft_reg_n;
wire equal;
wire [3:0] bcd_0;
wire [3:0] bcd_1;
wire [3:0] bcd_2;
wire [3:0] bcd_3;

sync sync_0 (
	.clk_i(clk_i),
	.d_i(key_restart_ni),
	.q_o(key_restart_syncin_n)
);
sync sync_1 (
	.clk_i(clk_i),
	.d_i(key_up_ni),
	.q_o(key_up_syncin_n)
);
sync sync_2 (
	.clk_i(clk_i),
	.d_i(key_down_ni),
	.q_o(key_down_syncin_n)
);
sync sync_3 (
	.clk_i(clk_i),
	.d_i(key_entry_ni),
	.q_o(key_entry_syncin_n)
);
single_pulser single_pulser_0 (
	.clk_i(clk_i),
	.rst_ni(rst_ni),
	.key_ni(key_restart_syncin_n),
	.pulse_o(restart)
);
single_pulser single_pulser_1 (
	.clk_i(clk_i),
	.rst_ni(rst_ni),
	.key_ni(key_up_syncin_n),
	.pulse_o(up)
);
single_pulser single_pulser_2 (
	.clk_i(clk_i),
	.rst_ni(rst_ni),
	.key_ni(key_down_syncin_n),
	.pulse_o(down)
);
single_pulser single_pulser_3 (
	.clk_i(clk_i),
	.rst_ni(rst_ni),
	.key_ni(key_entry_syncin_n),
	.pulse_o(entry)
);

entry_indicator entry_indicator_0 (
	.rst_ni(rst_entry_indicator_n),
	.entry_i(entry),
	.entering_last_digit_o(entering_last_digit)
);

controller controller_0 (
	.clk_i(clk_i),
	.rst_ni(rst_ni),
	.up_i(up),
	.down_i(down),
	.entry_i(entry),
	.restart_i(restart),
	.entering_last_digit_i(entering_last_digit),
	.enable_cntr_o(enable_cntr),
	.updown_o(updown),
	.enable_sft_o(enable_sft),
	.enable_lock_o(enable_lock),
	.rst_cntr_no(rst_cntr_n),
	.rst_entry_indicator_no(rst_entry_indicator_n),
	.rst_sft_reg_no(rst_sft_reg_n)
);

counter counter_0 (
	.clk_i(clk_i),
	.rst_ni(rst_cntr_n),
	.updown_i(updown),
	.enable_i(enable_cntr),
	.bcd_o(bcd_0)
);

shift_reg shift_reg_0 (
	.clk_i(clk_i),
	.rst_ni(rst_sft_reg_n),
	.enable_i(enable_sft),
	.d_i(bcd_0),
	.reg_0_o(bcd_1),
	.reg_1_o(bcd_2),
	.reg_2_o(bcd_3)
);

comparator comparator_0 (
	.bcd_0_i(bcd_0),
	.bcd_1_i(bcd_1),
	.bcd_2_i(bcd_2),
	.bcd_3_i(bcd_3),
	.equal_o(equal)
);

lock lock_0 (
	.enable_i(enable_lock),
	.unlock_i(equal),
	.ledr_o(ledr_o),
	.ledg_o(ledg_o)
);

seven_seg_dec seven_seg_dec_0 (
	.bcd_i(bcd_0),
	.out_o(sevenseg_0_o)
);
seven_seg_dec seven_seg_dec_1 (
	.bcd_i(bcd_1),
	.out_o(sevenseg_1_o)
);
seven_seg_dec seven_seg_dec_2 (
	.bcd_i(bcd_2),
	.out_o(sevenseg_2_o)
);
seven_seg_dec seven_seg_dec_3 (
	.bcd_i(bcd_3),
	.out_o(sevenseg_3_o)
);

endmodule
