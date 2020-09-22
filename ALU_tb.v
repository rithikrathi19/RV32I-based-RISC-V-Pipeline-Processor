module tb_ALU();
	reg [31:0] A, B;
	wire[31:0] result;
	reg[3:0] ALUop;
	reg clk;
	
	
	initial begin
	clk=1;
	forever #5 clk=~clk;
	end
	
	
	ALU alu_tb(clk, A[31:0], B[31:0], ALUop[3:0], result[31:0]);
	
	
	initial begin
	A=32'd1;
	B=32'd1;
	ALUop=3'b0000;

	#10
	A=32'd1;
	B=32'd1;
	ALUop=3'b0001;

	#10
	A=32'd2;
	B=32'd2;
	ALUop=3'b0010;

	#10
	A=32'd3;
	B=32'd3;
	ALUop=3'b0110;

	#10
	A=32'd4;
	B=32'd4;
	ALUop=3'b0010;
		
	#10
	A=32'd5;
	B=32'd12;
	ALUop=3'b0010;

	#10
	A=32'd6;
	B=32'd10;
	ALUop=3'b0010;

	#10
	A=32'd7;
	B=32'd17;
	ALUop=3'b0000;

	#10
	A=32'd8;
	B=32'd8;
	ALUop=3'b0010;
	
end
endmodule

