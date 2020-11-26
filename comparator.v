//comparator
module comparator(input rst,
                  input [31:0]PredictedAdd,BranchAdd,
                  input predict,branch_taken,
                  input [31:0]PC_4,
                  output reg [31:0]Actual_Target, PredictedAdd_Update,
                  output reg branch_final);
always@(rst)
begin
    if (rst) begin
        branch_final = 1'b0;
        Actual_Target = 32'd0;
        PredictedAdd_Update = 32'd0;    
    end
    
end
always@(*)
begin
    if((PredictedAdd != BranchAdd) || (predict != branch_taken)) begin
       
        if(branch_taken) begin
            Actual_Target = BranchAdd;
            PredictedAdd_Update = BranchAdd;
            branch_final = 1'b1;  
        end
        else if (predict) begin
            Actual_Target = PC_4;
            PredictedAdd_Update = PredictedAdd;
            branch_final = 1'b1;
        end
        else begin
            Actual_Target = 32'd0;
            PredictedAdd_Update = PredictedAdd; 
            branch_final = 1'b0;

        end
    end
    else begin
        branch_final = 1'b0;
        Actual_Target = 32'd0;
        PredictedAdd_Update = PredictedAdd; 
    end
end
endmodule