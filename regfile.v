// RISC V Reg File
module regfile(
    input [4:0]readregA,
    input [4:0]readregB,
    input [4:0]writereg,
    input [31:0]writedata,
    input RegWrite,
    input clk,
    input rst,
    input printr,
    output reg [31:0]readdataA,
    output reg [31:0]readdataB);

    reg [31:0]regs[0:31];
    always@(posedge rst) 
        $readmemh("regfile.txt",regs);
    
    integer f,j;
    always @ (posedge printr)
    begin
        f = $fopen("Result.txt", "w");
            if (f)  $display("File was opened successfully : %0d", f);
            else    $display("File was NOT opened successfully : %0d", f);		
            for(j = 0; j < 32; j = j+1)
                $fwrite(f, "%h\n", regs[j]);
            $fclose(f);
    end

    always@(readregA,readregB)
    begin
        readdataA <= regs[readregA];
        readdataB <= regs[readregB];
    end

    always@(negedge clk)
    begin
        if(RegWrite==1)
        regs[writereg] <= writedata;
    end
endmodule