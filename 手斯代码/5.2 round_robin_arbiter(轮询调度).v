//其基本思路是，当一个requestor 得到了grant许可之后，它的优先级在接下来的仲裁中就变成了最低，
//也就是说每个requestor的优先级不是固定的，而是会在最高（获得了grant)之后变为最低，
//并且根据其他requestor的许可情况进行相应的调整。这样当有多个requestor的时候，
//grant可以依次给每个requestor，即使之前高优先级的requestor再次有新的request，
//也会等前面的requestor都grant之后再轮到它。

module RR_arbiter (
    input clk,
    input rst,
    input[3:0] req,
    output reg [1:0] grant;
);

always@(posedge clk or negedge rst) begin
    if(!rst)
        grant <= 2'b00;
    else begin
        case(grant) begin
            2'b00 : begin
                case(req)
                4'b0000: grant <= 2'b00;
                4'b0001: grant <= 2'b00;
                4'b0010: grant <= 2'b01;
                4'b0011: grant <= 2'b01;
                4'b0100: grant <= 2'b10:
                4'b0101: grant <= 2'b10;
                4'b0110: grant <= 2'b01;
                4'b0111: grant <= 2'b01;
                4'b1000: grant <= 2'b11;
                4'b1001: grant <= 2'b11;
                4'b1010: grant <= 2'b01;
                4'b1011: grant <= 2'b01;
                4'b1100: grant <= 2'b10;
                4'b1101: grant <= 2'b10;
                4'b1110: grant <= 2'b01;
                4'b1111: grant <= 2'b01;
                default: grant <= 2'b00;
                endcase
            end
            // the rest cases are same as the aboved case
            2'b01: ....
            2'b10: ....
            2'b11: ....
            default: grant <= 2'b00;
        endcase
    end
end
    
endmodule