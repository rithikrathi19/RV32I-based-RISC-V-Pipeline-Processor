//4 state Moore FSM for branch prediction
module bp_FSM(ip_state,b_res,op_state,pred);
input [1:0]ip_state;
input b_res; //Actual result of branch
output reg [1:0]op_state; //Output state after verifying actual result
output reg pred; //predicted operation for branch

localparam strong_nt = 2'b00,weak_nt = 2'b01, weak_t =2'b10,strong_t =2'b11;
reg [1:0]next;
//Output and Next state computation
//Same always block as we have considered Moore machine
always@(*)
begin
    case(ip_state)
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
        if(b_res) begin
            next <= strong_t; //01-->11
            pred <= 1'b1;   
        end
        else begin
            next <= strong_nt; //01-->00
            pred <= 1'b0;    
        end
        
    end
    weak_t: //10
    begin
        if(b_res) begin
            next <= strong_t; //10-->11
            pred <= 1'b1;
        end
        else begin
            next <= strong_nt; //10-->00
            pred <= 1'b0;
        end
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

