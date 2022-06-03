module GU_single_pulser (
	input  clock,
	input  push,
	output reg single_pulse);

	// pushbutton state decoding (one-hot encoding)
   parameter UNPUSHED = 3'b001;
   parameter PUSHED   = 3'b010;
   parameter HELD     = 3'b100;

   // machine variable
   reg [2:0] present_state;
   reg [2:0] next_state;
	
	// sequential
   // state transfer
   always @(posedge clock)
		present_state <= next_state;
	
	// combinational
	// state switching and output logic
	// Using block assignment for combinational logic.
	always @(present_state) begin
		case (present_state)
			UNPUSHED: begin
				single_pulse = 1'b0;
				if (push == 1)
					next_state = PUSHED;
				else
					next_state = UNPUSHED;
			end
			PUSHED: begin
				single_pulse = 1'b1;
				if (push == 1)
					next_state = HELD;
				else
					next_state = UNPUSHED;
			end
			HELD: begin
				single_pulse = 1'b0;
				if (push == 1)
					next_state = HELD;
				else
					next_state = UNPUSHED;
			end
		endcase
	end
endmodule

/* Ref
https://www.runoob.com/w3cnote/verilog-fsm.html
http://courses.csail.mit.edu/6.111/f2007/handouts/L07.pdf
https://www.chipverify.com/verilog/verilog-positive-edge-detector
*/