module ALUcontrol(ALUop, funct_7, funct_3, operation);
	input [1:0] ALUop;
	input [6:0] funct_7;
	input [2:0] funct_3;
	output reg [3:0] operation;

	always @(*) begin
		if((ALUop == 0) | ((ALUop[1] == 1'b1) & (funct_7 == 7'd0) & (funct_3 == 3'd0)))
			operation = 4'd2;
		else if((ALUop[0] == 1'b1) | ((ALUop[1] == 1'b1) & (funct_7 == 7'd32) & (funct_3 == 3'd0)))
			operation = 4'd6;
		else if (((ALUop[1] == 1'b1) & (funct_7 == 7'd0) & (funct_3 == 3'd7)))
			operation = 4'd0;
		else if(((ALUop[1] == 1'b1) & (funct_7 == 7'd0) & (funct_3 == 3'd6)))
			operation = 4'd1;
		end
endmodule

