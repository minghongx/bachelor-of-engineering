module GU_dec_count (output reg[3:0] count, output rco, input clk, clr, enc, ent);  

//assign rco = ((count == 4'd9) && ent);
assign rco = ((count == 4'd11) && ent);

always @ (posedge clk)  
	begin 
		if (clr)    
			count <= 0;   
		//else if (enc && ent && count != 4'd9)
		else if (enc && ent && count != 4'd11)
			count <= count + 1;         
		//else if (enc && ent && count == 4'd9)
		else if (enc && ent && count == 4'd11)      
			count <= 0;
		else
			count <= count;
	end 
endmodule