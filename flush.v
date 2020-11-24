module flush(br,z,predadd,actadd,f);
input br,z; //Flushing operation incase of normal branch instruction
input [31:0]predadd,actadd; //predicted and actual address in branch prediction
output reg f; //This signal will be passed as rst of the pipo reg to flush

always@(*)
begin
    if(br==1 & z==1)
        f = 1;
    else if(predadd != actadd)
        f = 1;
    else
        f = 0;
end

endmodule