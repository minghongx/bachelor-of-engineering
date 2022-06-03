module GU_sec_cnt (input clk, output second);  
 
reg [27:0] new_count; 
 
//assign second = (new_count == 27'd49999999);
assign second = (new_count == 3'd5);
// Using a 50MHz clock. ADD takes one clock cycle. ADD 50M - 1 times takes one second.
	always @ (posedge clk) 
		begin 
			//if (new_count == 27'd49999999)
			if (new_count == 3'd5) 
				begin 
					new_count <= 0; 
				end 
			else 
				new_count <= new_count + 1; 
		end
endmodule