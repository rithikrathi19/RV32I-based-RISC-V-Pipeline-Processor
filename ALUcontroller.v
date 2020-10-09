module ALUcontrol(ALUop, funct_7, funct_3, operation);
	input [1:0] ALUop;
	input [6:0] funct_7;
	input [2:0] funct_3;
	output reg [3:0] operation;

	always @(*) begin
		if(((ALUop == 2'b10) && (funct_7 == 7'd0) && (funct_3 == 3'd0)) || ((ALUop == 2'b11) && (funct_3 == 3'd0)) || (ALUop == 2'b00)) 
			operation = 4'd2; //ADD
		else if((ALUop == 2'b01) || ((ALUop == 2'b10) && (funct_7 == 7'd32) && (funct_3 == 3'd0)))
			operation = 4'd6; //SUBTRACT
		else if (((ALUop == 2'b10) && (funct_7 == 7'd0) && (funct_3 == 3'd7)) || ((ALUop == 2'b11) && (funct_3 == 3'd7)))
			operation = 4'd0; //AND
		else if(((ALUop == 2'b10) && (funct_7 == 7'd0) && (funct_3 == 3'd6)) || ((ALUop == 2'b11) && (funct_3 == 3'd6)))
			operation = 4'd1; //OR
		else if(((ALUop == 2'b10) && (funct_7 == 7'd0) && (funct_3 == 3'd4)) || ((ALUop == 2'b11) && (funct_3 == 3'd4)))
			operation = 4'd3; //XOR
		else if((ALUop[1] == 1'b1) && (funct_7 == 7'd0) && (funct_3 == 3'd1))
			operation = 4'd4; //Shift Left
		else if((ALUop[1] == 1'b1) && (funct_7 == 7'd0) && (funct_3 == 3'd5))
			operation = 4'd5; //Shift Right
		else if(((ALUop[1] == 1'b1) && (funct_7 == 7'd32) && (funct_3 == 3'd5)))
			operation = 4'd7; //Arithmetic Shift
		end
endmodule

