module branch_table(rst,r_address,w_address,wr_data,re_data);
 input rst;
 input [4:0]r_address,w_address; //for now, a 5bit wide address line as only 32 word memory considered
 input [34:0]wr_data;
 output reg[34:0]re_data;
 
 reg [34:0]btb[0:31];//32 word data memory
 integer i;
 
 initial
 begin
	for(i = 0;i < 32;i = i+1)
	btb[i] = 35'd0; //Loading memory with its corresponding address location
 end
 
 always@(rst)
 begin
    if (rst) begin
        for(i = 0;i < 32;i = i+1)
	    btb[i] = 35'd0; 
    end
end

always@(r_address)
begin
	re_data <= btb[r_address];
end

always@(*)
begin

    btb[w_address] <= wr_data;
	
end
 
endmodule