`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2022 16:57:38
// Design Name: 
// Module Name: order_detect
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


module order_detect_101101(
    input clk,
    input reset,
    input data,
    output q
    );
    
    localparam s0 = 3'b000;
    localparam s1 = 3'b001;
    localparam s10 = 3'b010;
    localparam s101 = 3'b011;
    localparam s1011 = 3'b100;
    localparam s10110 = 3'b101;
    
    reg[2:0] state, next_state;
    //mealy
    always@(posedge clk) begin 
        if(reset) 
            state <= s0;
        else
            state <= next_state;
    end
    
    always@(*) begin
        case (state)
            s0: if(data)
                    next_state = s1;
                else
                    next_state = s0;
            
            s1: if(data)
                    next_state = s0;
                 else
                    next_state = s10;
            
            s10: if(data)
                    next_state = s101;
                 else
                    next_state = s0;
           
            s101: if(data)
                    next_state = s1011;
                  else
                    next_state = s10;
            
            s1011: if(data)
                    next_state = s1;
                   else
                    next_state = s10110;
            
            s10110: next_state = s0;
            
            default: next_state = s0;
        endcase
    end
       
     assign q = (state == s10110 && data == 1) ? 1'd1 : 1'd0;
     
     
            
        
endmodule
