module ALU(clk, A, B, ALUcontrol, result);
	input clk;
	input [31:0] A, B;
	input [3:0] ALUcontrol;
	output reg[31:0] result;
		
	always@(posedge clk)
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
		default: begin	
				result<= 32'd0;
				end
		endcase
	end
endmodule
