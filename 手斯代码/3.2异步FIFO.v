`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/23 21:54:07
// Design Name: 
// Module Name: Asychron_FIFO
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


module Asychron_FIFO
#(
  parameter wsize = 8,
  parameter dsize = 32
  )
(
    input clk_wr,
    input clk_rd,
    input rst,
    input[wsize-1:0] wdata,
    input we,
    input re,
    output full,
    output empty,
    output reg [wsize-1:0] rdata
    );
    
    reg[wsize-1:0] ram[dsize-1:0];
    wire[wsize-1:0] waddr, raddr;
    reg[wsize:0] waddr_bin, raddr_bin;
    wire[wsize:0] waddr_grey;
    reg[wsize:0] waddr_grey_d1, waddr_grey_d2;
    wire[wsize:0] raddr_grey;
    reg[wsize:0] raddr_grey_d1, raddr_grey_d2;
    
    //生成二进制写指针, 通过将MSB-1到0位地址赋给地址来写入数据
    always@(posedge clk_wr or negedge rst) begin
        if(!rst)
            waddr_bin <= 'h0;
        else if(we && !full)
            waddr_bin <= waddr_bin + 1;
        else
            waddr_bin <= waddr_bin;
     end
     
     always@(posedge clk_wr) begin
        if(we && !full)
            ram[waddr] <= wdata;
        else
            ram[waddr] <= ram[waddr];
     end
     
     assign waddr = waddr_bin[wsize-1:0];
     
     //生成二进制读指针,通过将MSB-1到0位地址赋给读地址来读出数据
     always@(posedge clk_rd or negedge rst) begin
        if(!rst)
            raddr_bin <= 'h0;
        else if(!empty && re)
            raddr_bin <= raddr_bin + 1;
        else
            raddr_bin <= raddr_bin;
     end
     
     always@(posedge clk_rd) begin
        if(!empty && re)
            rdata <= ram[raddr];
        else
            rdata <= 'h0;
     end
     
     assign raddr = raddr_bin[wsize-1:0];
     
     //将二进制地址转换到格雷码并同步到读写时钟域来做比较产生空满信号
     assign waddr_grey = (waddr_bin >> 1) ^ waddr_bin;
     assign raddr_grey = (raddr_bin >> 1) ^ raddr_bin;
     
     always@(posedge clk_rd) begin
        waddr_grey_d1 <= waddr_grey;
        waddr_grey_d2 <= waddr_grey_d1;
     end
     
     always@(posedge clk_wr) begin
        raddr_grey_d1 <= raddr_grey;
        raddr_grey_d2 <= raddr_grey_d1;
     end
     //高两位不同，其余位都相同
     assign full = (waddr_grey == {~raddr_grey_d2[wsize : wsize-1], raddr_grey_d2[wsize-2:0]});
     //所有位都相同
     assign empty = (raddr_grey == waddr_grey_d2);
 
        
          
     
     
   
endmodule
