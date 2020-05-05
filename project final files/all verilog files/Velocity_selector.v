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


module Velocity_selector(x_real,y_real,clock,active,x_rot,y_rot,vs_done);
    
    input  [15:0]x_real;
    input  [15:0]y_real;
    input  clock;
    input  active;
    output [15:0]x_rot;
    output [15:0]y_rot;
    output vs_done;
    
    wire [15:0]theta_real;
    wire [15:0]mag_real;
    wire [15:0]mag;
    wire [15:0]phase;
    reg  [15:0]mag1;
    reg  [15:0]phase1;
    wire [15:0] x_real_nm,y_real_nm,x_rot_nm,y_rot_nm;
    reg  [15:0]step=16'b1;
    reg  done=1'b0;
    
    integer count=-1;
    
    Rect_to_polar RP(x_real_nm,y_real_nm,mag,phase);
    Polar_to_rect PR(mag_real,theta_real,x_rot_nm,y_rot_nm);
    
    assign vs_done=done;
    assign mag_real=mag1;
    assign theta_real=phase;
    
    assign x_real_nm =(x_real<<3);       //To make it compatible with overall Fixed point representation
    assign y_real_nm =(y_real<<3);
    assign x_rot     =(x_rot_nm>>3);
    assign y_rot     =(y_rot_nm>>3);
    
    always @(posedge clock)
    begin
        if(active)
        begin
         case(count)
              30: begin
                    done <=1'b0;
                   assign mag1 =mag;
                 end   
              35:begin
                  assign  mag1 = mag1-1;
                 end
              60:begin
                    count=-1;             //so that after updation it goes to 0
                    done =1'b1;
                    #10;
                    done=1'b0;
                 end 
             endcase
             count=count+1;
         end
     end
endmodule
