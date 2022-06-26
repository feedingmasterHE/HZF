`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.06.2022 17:52:56
// Design Name: 
// Module Name: fixed_priority_arbiter
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

/*module fixed_prio_arb
  (
       input [2:0]         req,
       
       output logic [2:0]  grant
   );
    
       always_comb begin
           //with this case mode we could check the request with priority.
           //req[0] will be checked firstly if it is 1. if not, req[1] will be checked
           case (1'b1)
              req[0]: grant = 3'b001;
              req[1]: grant = 3'b010;
              req[2]: grant = 3'b100;
              default:grant = 3'b000;
          endcase
      end
   
  endmodule: fixed_prio_arb*/

module fixed_priority_arbiter
#(parameter arbi_width = 16)
(  
    input[arbi_width - 1:0] req,
    output reg[arbi_width - 1:0] grant
    );
    
    reg[arbi_width-1:0] pre_req;
    integer i;
    always@(*) begin
        //将最低位赋给prereq和grant
        pre_req[0] = req[0];
        grant[0] = req[0];
        //通过for循环来生成grant序列,如果检测到req,则将此位的grant拉高
        //并拉高pre_req在此位后的所有位拉高，这样能保证此位后的grant全部为0
        //通过此种方法来实现固定优先级的仲裁
        for ( i = 1; i < arbi_width; i = i + 1) begin
          grant[i] = req[i] & !pre_req[i-1];  // current req & no higher priority request
          pre_req[i] = req[i] | pre_req[i-1]; // or all higher priority requests
        end
      end
endmodule
