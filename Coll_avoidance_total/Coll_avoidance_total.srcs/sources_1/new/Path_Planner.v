`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.05.2020 18:46:45
// Design Name: 
// Module Name: Path_Planner
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


module Path_Planner(vx,vy,x,y,tx,ty,vx_out,vy_out,clock,in_rdy,out_rdy);
input [15:0] vx,vy,x,y,tx,ty;
output [15:0] vx_out,vy_out;
input in_rdy,clock;
output out_rdy;
integer count=-1;
reg [15:0] vx_reg,vy_reg;
reg out_rdy_reg;

assign vx_out=vx_reg;
assign vy_out=vy_reg;
assign out_rdy=out_rdy_reg;

always @(posedge clock)
begin
    if(in_rdy)
    begin
     case(count)
          1:begin
                vx_reg=(tx-x)/(16'd25);
                vy_reg=(ty-y)/(16'd25);
             end   
          2:begin
                out_rdy_reg=1'b1;
                #10;
                out_rdy_reg=1'b0;
             end 
         endcase
         count=count+1;
     end
 end

endmodule
