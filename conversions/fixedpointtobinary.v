`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.04.2020 13:52:08
// Design Name: 
// Module Name: fixedpointtobinary
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


module fixedpointtobinary;
reg [9:0] fp;
reg [9:0] fp2;
reg [17:0] fp1;
reg [31:0]bin;
real r,s,t;
integer i,k,j,z;
    initial
       begin
       fp= 10'b0010110101;
       fp2 = fp1;
       r = fp[8];
       if(fp[0] == 1)
           begin
           fp2[8] = fp[8];
           fp2[9] = fp[9];
            for(j=0; j<8; j= j+1)
                begin
                fp2[j] = ~fp[j];
                end
             fp2 = fp2 + 'b1;
            r = r*-1;
           end
       fp1 = fp2<<<8;
       k=0;
       for (i=0; i < 16; i= i+1)
       begin 
       k = k + fp1[i]*2**(i);
       assign s = k;
       //$display ("%r", s);
       end
               
       r = r + s/(2**(16));
       z = r*1000;
        j = z;
              for(i=0; i<32; i=i+1)
              begin
                  bin[i] = j%2;
                  j=j/2;
              end
           $display("%b", bin);
     end
endmodule

