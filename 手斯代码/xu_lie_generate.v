`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2022 16:26:57
// Design Name: 
// Module Name: xu_lie_generate
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


module xu_lie_generate(
    
    input clk,
    input reset,
    input[9:0] in,
    output q

    );
    reg dout;
    reg[9:0] temp;
    //synchron clock
    always@(posedge clk) begin
        if(reset) 
            temp <= in;
        else begin
            // last bit will be output
            dout <= temp[9];
            // left shift and feedback loop of the queue to generate periodic queue
            temp <= {temp[8:0], temp[9]};
        end
    end   
    
    assign q = dout;
    
endmodule
