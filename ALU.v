module ALU(clk, A, B, ALUcontrol, result, zeroflag);
	input clk;
	input [31:0] A, B;
	input [3:0] ALUcontrol; //Deciding the ALU Operation
	output reg[31:0] result;
	output reg zeroflag;
		
	always@(*)
	begin
		case(ALUcontrol)
		4'b0000: begin
				result = A&B;
				end
		4'b0001: begin
				result = A|B;
				end
		4'b0010: begin
				result = A + B;
				end
		4'b0110: begin
				result = A-B;
				end
		4'b0011: begin
				result = A^B;
				end
		4'b0101: begin
				result = A>>B;
				end
		4'b0100: begin
				result = A<<B;
				end
		4'b0111: begin
			result = {A[31],A>>B};
				end
		default: begin	
				result<= 32'd0;
				end
		endcase
		if (result == 32'd0) begin
					zeroflag = 1'b1;
		end else begin
					zeroflag = 1'b0;
			end
	end
endmodule
