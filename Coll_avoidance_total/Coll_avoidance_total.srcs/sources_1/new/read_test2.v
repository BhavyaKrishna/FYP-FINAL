`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.05.2020 14:59:21
// Design Name: 
// Module Name: read_test2
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


module read_test2(x2_bin,y2_bin,vx2_bin,vy2_bin,read_done2);
 output [15:0] x2_bin,y2_bin,vx2_bin,vy2_bin;
 output read_done2;
 
 integer i,code,k,l,m,n;
 integer file_id;
 wire y;
 integer j = 1;
 integer char2;
     //reg vx1 =, vy1 = 0.01d;
 real vx2, vy2, x2, y2;
 reg [15:0] x2_bin_reg,y2_bin_reg,vx2_bin_reg,vy2_bin_reg;
 reg read_done_reg2=1'b0;
 assign x2_bin    = x2_bin_reg;
 assign y2_bin    = y2_bin_reg;
 assign read_done2 = read_done_reg2;
 assign vx2_bin   = vx2_bin_reg;
 assign vy2_bin   = vy2_bin_reg;
 
 always 
     begin 
         #300 file_id = $fopen("F:/FYP-FINAL/synchronisation/bot2.txt","r");
         code=$fscanf(file_id, "%c\n",char2);
         $fclose(file_id);
         //$display("%c", char1);
         if(char2 =="w")
         begin
         file_id = $fopen("F:/FYP-FINAL/synchronisation/bot2.txt","r");
         code=$fscanf(file_id, "%c\n",char2);                              
         k = $fscanf(file_id, "%f\n",vx2);
         //$display(vx1);
         l = $fscanf(file_id, "%f\n",vy2);
         //$display(vy1);
         m = $fscanf(file_id, "%f\n",x2);
         n = $fscanf(file_id, "%f\n",y2);
         $fclose(file_id);
         //$fwrite(file_id, "\n");
         file_id = $fopen("F:/FYP-FINAL/synchronisation/bot2.txt","w");
         $fseek(file_id, 0, 0);
         $fwrite(file_id, "r\n");
         $display("bot 2 velocity read", $time);
         $fclose(file_id);
         end
          x2_bin_reg  <= x2  * 2**(11);
          y2_bin_reg  <= y2  * 2**(11);
          vx2_bin_reg <= vx2 * 2**(11);
          vy2_bin_reg <= vy2 * 2**(11);
 end
      always @(x2_bin or y2_bin or vx2_bin or vy2_bin)
      begin
              #10;
              read_done_reg2=1'b1;
              #100;
              read_done_reg2=1'b0;
          end
endmodule
