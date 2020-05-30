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


module init(tx1,ty1,tx2,ty2,tx3,ty3);

output [15:0] tx1,ty1,tx2,ty2,tx3,ty3;


//the values can be read from a target file instead of hardcoding
assign tx1=-16'd8192;  //-4
assign ty1=16'd6144;  //3


assign tx2=16'd0;// 0
assign ty2=16'd10240;  //5



assign tx3=-16'd10240;  //-5
assign ty3=16'd0; //0




endmodule
