`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.04.2020 12:00:52
// Design Name: 
// Module Name: Binary to decimal
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


module Binary_to_decimal(
    input [31:0]bin,
    output integer dec
    );
    integer i,k;
    
    always @(bin)
        begin
        k=0;
        for (i=0; i < 32; i= i+1)
            begin 
            k = k + bin[i]*2**(i);
            assign dec = k;
            $display ("%d", dec);
            end
        end
endmodule

