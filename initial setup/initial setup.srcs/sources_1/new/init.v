`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.04.2020 21:01:10
// Design Name: 
// Module Name: init
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


module init(vx1,vy1,x1,y1,vx2,vy2,x2,y2,vx3,vy3,x3,y3,tx1,ty1,tx2,ty2,tx3,ty3);

output [15:0] vx1,vy1,x1,y1,vx2,vy2,x2,y2,vx3,vy3,x3,y3,tx1,ty1,tx2,ty2,tx3,ty3;


//the numbers have to be checked if they are multiplied first and then taken 2's compliment


assign x1=-16'd20480;  //-10  
assign y1=-16'd20480;  //-10

assign tx1=16'd20480;  //10
assign ty1=16'd20480;  //10

assign x2=-16'd0;// 0
assign y2=-16'd20480;  //-10

assign tx2=-16'd10240;// -5
assign ty2=16'd20480;  //10

assign x3=16'd20480;  //10
assign y3=16'd0; //0

assign tx3=-16'd20480;  //-10
assign ty3=16'd10240; //5

assign vx1=(tx1-x1)/16'd50;
assign vy1=(ty1-y1)/16'd50;

assign vx2=(tx2-x2)/16'd50;
assign vy2=(ty2-y2)/16'd50;

assign vx3=(tx3-x3)/16'd50;
assign vy3=(ty3-y3)/16'd50;


endmodule
