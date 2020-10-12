//Data Memory
module data_mem(clk,r_enable,w_enable,address,wr_data,re_data);
 input clk;
 input w_enable;
 input r_enable;
 input [31:0]address; //for now, a 5bit wide address line as only 32 word memory considered
 input [31:0]wr_data;
 output reg[31:0]re_data;
 
 reg [31:0]dmem[0:31];//32 word data memory
 integer i;
 
 initial
 begin
	for(i = 0;i < 32;i = i+1)
	dmem[i] = i; //Loading memory with its corresponding address location
 end
 
 always@(posedge clk)
 begin
	if(w_enable)
		dmem[address] <= wr_data;
	if(r_enable)
		re_data <= dmem[address];
 end
 
endmodule
		
 
 
 
 
 
 
 
