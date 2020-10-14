// Test bench
`timescale 1ns/1ns
module tb_top();
reg rst,clk;
top pipeline(rst,clk);

initial
    begin
        $dumpfile("tb.vcd");
        $dumpvars;
    end

initial 
    begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

initial
    begin
    rst = 1'b1;
    #10 rst = 1'b0;
    #500 $finish;
    end
endmodule