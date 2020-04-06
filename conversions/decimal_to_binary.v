`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2020 12:07:54
// Design Name: 
// Module Name: decimal_to_binary
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


module decimal_to_binary(
    input [31:0] dec,
    output reg [31:0]bin
    );
    integer  i;
    reg [31:0]j ;
    always@(dec)
    begin
        j = dec;
        for(i=0; i<32; i=i+1)
        begin
            bin[i] = j%2;
            j=j/2;
        end
     $display("%b", bin);
    end
        
endmodule
