//Control Unit

module controlunt(
input [6:0]opcode,
input clk,
output [1:0]ALUop  

);
always@(*)
begin
    case(opcode)
        7'b0110011://few R types -> add,sub,slt,sltu,sll,xor,srl,sra,or,and
            begin
                ALUop = 2'b10;
            end
        7'b1100011://SB types -> beq,bne,blt,bge,bltu,bgeu
            begin
                ALUop = 2'b01;
            end
        7'b0000011:// -> lb,lh,lw,ld,lbu,lhu,lwu
            begin
                ALUop = 2'b00;
            end
        7'b0100011://->sd,sh,sw,sd
            begin
                ALUop = 2'b00;    
            end
        
    endcase

end
    
