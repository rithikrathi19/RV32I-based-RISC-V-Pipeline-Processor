//N:1 multiplexer assuming data width to be 32 bits
module mux #(parameter N=2) (out,in,sel);
	input [31:0][0:N-1]in;//input to the module to be fed as a combined N 32bits input
	input [$clog2(N)-1:0]sel; //clog2() is an inbuilt verilog function to find log to base 2
	output reg[31:0]out;

	always@(*)
	begin
		out = in[sel];//Based on the select line, the output is set
	end
endmodule
	

