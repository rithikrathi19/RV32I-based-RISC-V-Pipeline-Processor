//Data Memory
module data_mem(clk,rw_enable,address,wr_data,re_data);
 input clk;
 input rw_enable; // 1 for write and 0 for read
 input [4:0]address; //for now, a 5bit wide address line as only 32 word memory considered
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
	if(rw_enable)
		dmem[address] <= wr_data;
	else
		re_data = dmem[address];
	//Here even if data mem is not used by an instruction, still we have a re_data output, which is managed by next stage Mux.
 end
 
endmodule
		
 
 
 
 
 
 
 
