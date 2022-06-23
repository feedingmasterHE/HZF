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
    output[wsize-1:0] rdata
    );
    
    reg[wsize-1:0] ram[dsize-1:0];
    reg[wsize-1:0] waddr, raddr;
    reg[wsize:0] wbin, rbin, wbin_next, rbin_next;
    reg[wsize:0] wgrey, 
    
    //https://www.cnblogs.com/ylsm-kb/p/9068449.html
endmodule
