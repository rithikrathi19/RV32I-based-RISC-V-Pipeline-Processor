//N bit parameterized adder
module adder #(parameter N=32)(out,in1,in2);
 input [N-1:0]in1,in2; //N bit inputs
 output reg[N-1:0]out;
 
 always@(*)
 begin
	out = in1+in2;
 end
 
endmodule
 
