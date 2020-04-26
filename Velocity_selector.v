`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2020 19:25:35
// Design Name: 
// Module Name: Velocity_selector
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


module Velocity_selector;
parameter p=1;
 generate
    if (p == 0)
      Rect_to_polar RP();
     else
      Polar_to_rect PR();
   endgenerate   
endmodule
