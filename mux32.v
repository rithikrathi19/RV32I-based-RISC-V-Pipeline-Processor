module mux32 #(parameter N=32) ( output [N-1:0] out, input [N-1:0] in0, in1, input sel);

assign out[N-1:0]=sel?in1[N-1:0]:in0[N-1:0];

endmodule