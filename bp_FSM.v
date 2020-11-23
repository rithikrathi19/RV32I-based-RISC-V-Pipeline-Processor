//4 state Moore FSM for branch prediction
module bp_FSM(ip_state,b_res,clk,rst,op_state,pred);
input [1:0]ip_state;
input b_res; //Actual result of branch
input clk;
input rst;
output reg [1:0]op_state; //Output state after verifying actual result
output reg pred; //predicted operation for branch

localparam strong_nt = 2'b00,weak_nt = 2'b01, weak_t =2'b10,strong_t =2'b11;
reg [1:0]curr,next;

//State Assigment
always@(posedge clk,posedge rst)
begin
    if(rst)
    curr <= strong_nt;
    else
    next <= curr;
end

//Output and Next state computation
//Same always block as we have considered Moore machine
always@(*)
begin
    case(curr)
    strong_nt: //00
    begin
        pred <= 1'b0;
        if(b_res)
        next <= weak_nt; //00-->01
        else
        next <= strong_nt; //00-->00
    end
    weak_nt: //01
    begin
        pred <= 1'b0;
        if(b_res)
        next <= strong_t; //01-->11
        else
        next <= strong_nt; //01-->00
    end
    weak_t: //10
    begin
        pred <= 1'b1;
        if(b_res)
        next <= strong_t; //10-->11
        else
        next <= strong_nt; //10-->00
    end
    strong_t: //11
    begin
        pred <= 1'b1;
        if(b_res)
        next <= strong_t; //11-->11
        else
        next <= weak_t; //11-->10
    end
    default:
    begin
        pred <= 1'b0;
        next <= strong_nt;
    end
    endcase
    op_state = next;
end
endmodule

//Branch history table
module btb_input(rst,btb,index,PredictedTarget,curr_state,mux_predict);

input rst;
input [34:0]btb[0:31]
input [4:0]index;
output reg [1:0]curr_state;
output reg [31:0]PredictedTarget;
output mux_predict;

reg i;
initial
begin
    for(i = 0; i < 32; i = i+1)
	btable[i] <= 35'd0;
end
always@(index,rst)
begin
    if(rst) begin
        for(i = 0; i < 32; i = i+1)
		btable[i] <= 35'd0;
    end
    else 
        {PredictedTarget,curr_state,mux_predict} = btable[index]; 
end
endmodule

module btb_update(btb,index,TargetAddress,next_state,predict_bit);
input [34:0]btb[0:31];
input [4:0]index;
input [32:0]TargetAddress;
input [1:0] next_state;
input predict_bit;

always@(*)
begin 
    btb[index] = {TargetAddress, next_state, predict_bit}; 
end

endmodule




