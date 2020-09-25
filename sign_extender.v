//Sign Extender for extending 12 bit immediate values to 32 bits
module sign_extender(out,in);
	input [11:0] in;
	output reg [31:0] out;
	always@(*)
	begin
	out[11:0] = in[11:0];	
    out[31:12] = {16{in[11]}}; //Copying the MSB to the remaining bits
	end
endmodule

