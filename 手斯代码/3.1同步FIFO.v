`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/23 21:05:08
// Design Name: 
// Module Name: sychron_FIFO
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sychron_FIFO
#(parameter DW = 8, AW=4)
    (
    input clk,   //??
    input reset, //??
    input we,    //???
    input re,    //???
    input[DW-1:0] wdata,
    output[DW-1:0] rdata,
    output full,
    output empty
);

localparam Depth = 1 << AW; //?????????????
reg[AW-1:0] wp, rp;   //?????????
reg[AW:0] cnt;        //?????
reg[DW-1:0] ram [0:Depth-1];  //??????
reg[DW-1:0] dout;

//cnt??????????
always@(posedge clk or negedge reset) begin
    if(!reset)
        cnt <= 8'd0;
    else begin
        if(!full && we)
            cnt <= cnt + 1;
        else if(!empty && re)
            cnt <= cnt - 1;
        else 
            cnt <= cnt;
    end
end  
 
//?????
always@(posedge clk or negedge reset) begin
    if(!reset)
        wp <= 4'd0;
    else begin
        if(!full && we)
            wp <= wp + 1'b1;
        else
            wp <= wp;
    end
end

//?????
always@(posedge clk or negedge reset) begin
    if(!reset)
        rp <= 4'd0;
    else begin
        if(!empty && re)
            rp <= rp + 1'b1;
        else
            rp <= rp;
    end
end

//????FIFO
always@(posedge clk) begin
    if(!full && we)
        ram[wp] <= wdata;
    else
        ram[wp] <= ram[wp];
end

//????FIFO
always@(posedge clk or negedge reset) begin
    if(!reset)
        dout <= 8'd0;
    else begin
        if(!empty && re)
            dout <= ram[rp];
        else
            dout <= dout;
    end
end

assign rdata = dout;
//????cnt??????????
assign full = (cnt==Depth-1) ? 1'b1 : 1'b0;
assign empty = (cnt == 0) ? 1'b1 : 1'b0;
endmodule
