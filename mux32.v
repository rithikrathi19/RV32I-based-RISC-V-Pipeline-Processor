module mux32( output [31:0] out, input [31:0] in0, in1, input sel);

assign out[31:0]=sel?in1[31:0]:in0[31:0];

endmodule