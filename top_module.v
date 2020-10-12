module top(rst,clk);
	input rst,clk;
	
	//Before the IF-ID Pipeline register
	wire [31:0]PCin,PCout; //Program Counter
	wire [31:0]instruction; //instruction from memory
	wire [31:0]newPC; //PC <- PC + 4
	wire [63:0]IFIDin = {newPC,instruction};
	
	
	adder #(.N(32)) add1(newPC,PCout,32'd4); //Full adder for incrementing PC
	instr_mem imem(instruction,PCout,clk,rst); //Instr Memory
	
	
	//Between IF-ID and ID-EX Pipeline registers
	wire [63:0]IFIDout;
	wire [31:0]IFID_PC_out;
	wire [31:0]IFID_instr_out;
	wire [6:0]opcode;
	wire [2:0]funct3;
	wire [6:0]funct7;
	wire [4:0]Rs1,Rs2,Rd;
	wire [31:0]immgen_out,Rs1data,Rs2data;
	
	wire [150:0]IDEXin;
	
	wire [1:0]ALUop;
	wire ALUsrc,MtoR,regwrite,memread,memwrite,branch;
	wire [7:0]controlsig = {ALUop,ALUsrc,MtoR,regwrite,memread,memwrite,branch};//control signals
	
	assign IFID_PC_out = IFIDout[63:32];
	assign IFID_instr_out = IFIDout[31:0];
	assign opcode = IFIDout[6:0];
	assign funct3 = IFIDout[14:12];
	assign funct7 = IFIDout[31:25];
	assign Rs1 = IFIDout[19:15];
	assign Rs2 = IFIDout[24:20];
	assign Rd = IFIDout[11:7];
	assign IDEXin = {IFID_PC_out,Rs1data,Rs2data,immgen_out,funct7,funct3,Rd,controlsig};//Signals to be passed to EX stage
	
	pipo_reg #(.N(64)) IFID(IFIDout,IFIDin,clk,rst); //Program Counter
	controlunit CU(opcode,ALUop,ALUsrc,MtoR,regwrite,memread,memwrite,branch);//Main Control Unit
	imm_gen IG(immgen_out,IFID_instr_out,opcode);//Immediate generator depending on instruction type
	
	
	//Between ID-EX and EX-MEM Pipeline registers
	wire [150:0]IDEXout;
	wire [2:0]funct3_EX;
	wire [6:0]funct7_EX;
	wire [4:0]Rd_EX;
	wire [31:0]Rs1data_EX,Rs2data_EX,immgen_out_EX,ALUsrcb;
	wire [31:0]IDEX_PC_out;
	wire [7:0]controlsig_EX;
	wire [31:0]BRadd;
	wire [3:0]ALUoperation;
	wire [31:0]result;
	wire zeroflag;
	
	wire [106:0]EXMEMin;
	
	assign IDEX_PC_out = IDEXout[150:119];
	assign Rs1data_EX = IDEXout[118:87];
	assign Rs2data_EX = IDEXout[86:55];
	assign immgen_out_EX = IDEXout[54:23];
	assign funct7_EX = IDEXout[22:16];
	assign funct3_EX = IDEXout[15:13];
	assign Rd_EX = IDEXout[12:8];
	assign controlsig_EX = IDEXout[7:0];
	
	assign EXMEMin = {controlsig_EX[4:0],BRadd,zeroflag,result,Rs2data_EX,Rd_EX};
	
	pipo_reg #(.N(151)) IDEX(IDEXout,IDEXin,clk,rst); 
	ALUcontrol ALUC(controlsig_EX[7:6], funct7_EX, funct3_EX, ALUoperation);
	ALU A1(clk, Rs1data_EX, ALUsrcb, ALUoperation, result, zeroflag);
	mux #(.N(2)) m1(ALUsrcb,{Rs2data_EX,immgen_out_EX},controlsig_EX[5]); 
	adder #(.N(32)) add2(BRadd,IDEX_PC_out,{immgen_out_EX[30:0],1'b0}); //Full adder PC+offset
	
	//Between EX-MEM and MEM-WB Pipeline registers
	wire [106:0]EXMEMout;
	wire [4:0]controlsig_MEM;
	wire [31:0]PCsrcB;
	wire PCsrc;
	wire [31:0]dmemaddr,dmemdata;
	wire [31:0]re_data;
	wire [4:0]Rd_MEM;
	wire zero_br;

	wire [70:0]MEMWBin;
	
	assign PCsrc = zero_br & controlsig_MEM[0];
	assign Rd_MEM = EXMEMout[4:0];
	assign dmemdata = EXMEMout[36:5];
	assign dmemaddr = EXMEMout[68:37];
	assign zero_br = EXMEMout[69];
	assign PCsrcB = EXMEMout[101:70];
	assign controlsig_MEM = EXMEMout[106:102];
	
	assign MEMWBin = {controlsig_MEM[4:3],re_data,dmemaddr,Rd_MEM};
	
	pipo_reg #(.N(107)) EXMEM(EXMEMout,EXMEMin,clk,rst); 
	data_mem dmem(clk,controlsig_MEM[2],controlsig_MEM[1],dmemaddr,dmemdata,re_data);
	
	//After MEM-WB Pipeline Register
	wire [70:0]MEMWBout;
	wire [31:0]WBsrcA,WBsrcB;
	wire [1:0]controlsig_WB;
	wire [4:0]Rd_WB;
	wire [31:0]writedata;
	
	assign Rd_WB = MEMWBout[4:0];
	assign WBsrcB = MEMWBout[36:5];
	assign WBsrcA = MEMWBout[68:37];
	assign controlsig_WB = MEMWBout[70:69];
	
	pipo_reg #(.N(71)) MEMWB(MEMWBout,MEMWBin,clk,rst);
	mux #(.N(2)) M3(writedata,{WBsrcA,WBsrcB},controlsig_WB[1]);
	regfile Rfile(Rs1,Rs2,Rd,writedata,controlsig_WB[0],clk,rst,Rs1data,Rs2data);//Register File
	pipo_reg #(.N(32)) PC(PCout,PCin,clk,rst); //Program Counter
	mux #(.N(2)) M1(PCin,{newPC,PCsrcB},PCsrc); //Mux for Program Counter
	
	
endmodule
	
	
