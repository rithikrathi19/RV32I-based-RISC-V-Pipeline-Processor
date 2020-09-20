//N-bit parallel in parallel out registers as pipeline-reg.
//Register size is parameterized with N and can be changed while instantiating.
module pipo_reg #(parameter N=32) (out,in,clk,rst);
 input [N-1:0]in;
 input clk;
 input rst;
 output reg [N-1:0]out;
 
 always@(posedge clk, posedge rst) // Asynchronous reset is used for the registers.
 begin
	if(rst)
		out <= 0;
	else
		out <= in;
 end

endmodule
	
  
