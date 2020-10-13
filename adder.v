//N bit parameterized adder
module adder #(parameter N=32)(out,ip1,ip2);
 input [N-1:0]ip1,ip2; //N bit inputs
 output reg[N-1:0]out;

 always@(*)
 begin
	out = ip1+ip2;
 end
 
endmodule
 
