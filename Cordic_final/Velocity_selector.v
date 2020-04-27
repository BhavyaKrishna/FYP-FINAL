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


module Velocity_selector(x_real,y_real,theta_real,mag_real);
input [15:0]x_real;
input [15:0]y_real;
input [15:0]theta_real;
input [15:0]mag_real;
wire [15:0]mag;
wire [15:0]phase;
wire [15:0]x_rot;
wire [15:0]y_rot;
parameter p=1;
 generate
    if (p == 0)
      Rect_to_polar RP(x_real,y_real,mag,phase);
     else
      Polar_to_rect PR(mag_real,theta_real,x_rot,y_rot);
   endgenerate   
   always
   begin
   #1000;
   end
endmodule
