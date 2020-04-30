`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.04.2020 16:39:03
// Design Name: 
// Module Name: shifter
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


module shifter(input[15:0] in,output[15:0] ou);




buf b0(ou[0],in[1]);
buf b1(ou[1],in[2]);
buf b2(ou[2],in[3]);
buf b3(ou[3],in[4]);
buf b4(ou[4],in[5]);
buf b5(ou[5],in[6]);
buf b6(ou[6],in[7]);
buf b7(ou[7],in[8]);
buf b8(ou[8],in[9]);
buf b9(ou[9],in[10]);
buf b10(ou[10],in[11]);
buf b11(ou[11],in[12]);
buf b12(ou[12],in[13]);
buf b13(ou[13],in[14]);
buf b14(ou[14],in[15]);
buf b15(ou[15],0);
endmodule
