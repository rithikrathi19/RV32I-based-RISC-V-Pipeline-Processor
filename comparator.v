//comparator
module comparator(
    input address1,
    input address2,
    output reg compare_bar
);
always@(*)
begin
    if(address1 != address2)
        compare_bar = 1;
    else
        compare_bar = 0;
end
endmodule