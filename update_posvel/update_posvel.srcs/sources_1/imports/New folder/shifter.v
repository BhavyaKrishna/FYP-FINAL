`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2020 14:02:53
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


module shifter(in, out);

input[15:0] in;
output[15:0] out;

buf b0(out[0],in[1]);
buf b1(out[1],in[2]);
buf b2(out[2],in[3]);
buf b3(out[3],in[4]);
buf b4(out[4],in[5]);
buf b5(out[5],in[6]);
buf b6(out[6],in[7]);
buf b7(out[7],in[8]);
buf b8(out[8],in[9]);
buf b9(out[9],in[10]);
buf b10(out[10],in[11]);
buf b11(out[11],in[12]);
buf b12(out[12],in[13]);
buf b13(out[13],in[14]);
buf b14(out[14],in[15]);
buf b15(out[15],1'b0);
endmodule
