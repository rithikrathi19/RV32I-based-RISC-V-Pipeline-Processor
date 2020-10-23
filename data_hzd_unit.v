// DATA FORWARD UNIT

module fwdunit(
    input  [4:0]idex_rs1,
    input [4:0]idex_rs2,
    input exmem_RegWrite,
    input [4:0]exmem_rd,
    input memwb_RegWrite,
    input [4:0]memwb_rd,
    output reg[1:0] forwardA,
    output reg[1:0] forwardB);

//Limitations of the module
//    1. It assumes all instruction R type, cases of hazard having other types not included yet.

//---- Function ----
//#Two signals forwardA & forwardB decide the input to ALU. 
//#If EX hazard exist value from exmem is put in ALU
//#If MEM hazard exist value from memwb is put in ALU
//#If both exist EX given priority over MEM

always@(*)
begin
    //assign forwardA signal 
    if(exmem_RegWrite == 1'b1 && exmem_rd != 5'b0 && exmem_rd == idex_rs1)
        forwardA = 2'b10;
    else if(memwb_RegWrite == 1'b1 && memwb_rd != 5'b0 && memwb_rd == idex_rs1)
            forwardA = 2'b01;
    else
        forwardA = 2'b00;

    //assign forwardB signal
    if(exmem_RegWrite == 1'b1 && exmem_rd != 5'b0 && exmem_rd == idex_rs2)
        forwardB = 2'b10;
    else if(memwb_RegWrite == 1'b1 && memwb_rd != 5'b0 && memwb_rd == idex_rs2)
            forwardB  = 2'b01;
    else
        forwardB = 2'b00;

end
endmodule

module hzdunit(
    input [4:0]ifid_rs1,
    input [4:0]ifid_rs2, 
    input idex_MemRead,
    input [4:0]idex_rd,
    output reg PCWrite,ifidWrite,stall    
);

//---- Function ----
//#Two signals PCWrite & ifidWrite control if values will be written in PC and IFID resp. 
//#stall controls a mux to choose b/w hard ground or CU outputs
//#Detects WB hazard i.e in case of load followed by R type

always@(*)
begin
    if(idex_MemRead == 1'b1)
    begin
        if(idex_rd == ifid_rs1 || idex_rd == ifid_rs2)
            begin
            stall = 1'b0;
            PCWrite = 1'b0;
            ifidWrite = 1'b0;
            end
    end
    else
    begin
        stall = 1'b1;
        PCWrite = 1'b1;
        ifidWrite = 1'b1;
    end
end
endmodule