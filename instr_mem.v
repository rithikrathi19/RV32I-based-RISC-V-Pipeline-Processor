//Instruction Memory
module instr_mem(instruction,PCin,clk,rst);
 input [31:0]PCin; //Program Counter
 input clk;
 input rst;
 output reg[31:0]instruction; //32 bit instruction output
 
 reg [31:0]memloc[0:31]; //Size of memloc here depends on the no. of instructions required
 integer i;
 
 initial
 $readmemh("instructions.txt", memloc);// Reading the coded instructions to the memory
 always@(posedge clk,posedge rst)
 begin
 
	if(rst)
	begin
		instruction <= 32'dZ;
		for(i = 0; i < 32; i = i+1)
		memloc[i] <= 32'd0;
	end
	
	else
		instruction <= memloc[PCin];
 end

endmodule

 
