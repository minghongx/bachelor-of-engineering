module shift_reg #(
	parameter DataWidth = 4,
	parameter Depth = 3  // FIXME: Depth is actullay hard-coded
)(
	input clk_i,
	input rst_ni,
	input enable_i,
	input  [DataWidth-1:0] d_i,
	output [DataWidth-1:0] reg_0_o,
	output [DataWidth-1:0] reg_1_o,
	output [DataWidth-1:0] reg_2_o
);

reg [DataWidth-1:0] mem_d [0:Depth-1];
reg [DataWidth-1:0] mem_q [0:Depth-1];

// TODO: more flexible
assign reg_0_o = mem_q[0];
assign reg_1_o = mem_q[1];
assign reg_2_o = mem_q[2];

integer i;

always @(posedge clk_i, negedge rst_ni)
	if (!rst_ni)
		for(i = 0; i < Depth; i = i + 1)
			mem_q[i] <= 0;
		// For SystemVerilog, use array assignment pattern with the default keyword:
		// mem_q <= '{default: '0};
	else
		for(i = 0; i < Depth; i = i + 1)
			mem_q[i] <= mem_d[i];

always @(enable_i, mem_q) begin

	// default assignment next state is present state
	for(i = 0; i < Depth; i = i + 1)
		mem_d[i] = mem_q[i];

	if (enable_i) begin
	    for(i = Depth - 1; i > 0; i = i - 1)
          mem_d[i] = mem_d[i-1];
       mem_d[0] = d_i;
	end

end

endmodule
