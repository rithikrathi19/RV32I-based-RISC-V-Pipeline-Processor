//Immediate Generator for extending 12 bit immediate values to 32 bits
module imm_gen(out,instr,op);
	input [31:0] instr;
	input [6:0] op;
	output reg [31:0] out;
	always@(*)
	begin
		case(op)
			7'b1100011://SB types -> beq,bne
			out = {{20{instr[31]}},instr[31],instr[7],instr[30:25],instr[11:8]};
			7'b0000011:// -> lb,lh,lw,ld,lbu,lhu,lwu
			out = {{20{instr[31]}},instr[31:20]};
			7'b0100011://->sd,sh,sw,sd
			out = {{20{instr[31]}},instr[31:25],instr[11:7]};
			7'b0010011://->addi,slli,srai,ori,andi..
			out = {{20{instr[31]}},instr[31:20]};
			default://default
			out = {{20{instr[31]}},instr[31:20]};
		endcase
	end
	
endmodule

