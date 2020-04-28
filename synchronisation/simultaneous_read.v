`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.04.2020 14:24:22
// Design Name: 
// Module Name: simultaneous_read
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

    
    module read_test ;
    
    integer i,code,k,l,m,n;
    integer file_id;
    wire y;
    integer j = 1;
    integer char1, char2, char3;
    //reg vx1 =, vy1 = 0.01d;
    real vx1, vy1, x1, y1;
    real vx2, vy2, x2, y2;
    real vx3, vy3, x3, y3;
    always
      
        begin 
            fork 
               begin
                  #300 file_id = $fopen("C:/Users/sujan/Desktop/Suj/studies/Final year project/simultaneous_read/bot1.txt","r");
                  code=$fscanf(file_id, "%c\n",char1);
                  //$display("%c", char1);
                  if(char1 =="w")
                  begin
                      k = $fscanf(file_id, "%f\n",vx1);
                      //$display(vx1);
                      l = $fscanf(file_id, "%f\n",vy1);
                     //$display(vy1);
                     m = $fscanf(file_id, "%f\n",x1);
                     n = $fscanf(file_id, "%f\n",y1);
                      $fclose(file_id);
                      //$fwrite(file_id, "\n");
                      file_id = $fopen("C:/Users/sujan/Desktop/Suj/studies/Final year project/simultaneous_read/bot1.txt","w");
                      $fseek(file_id, 0, 0);
                      $fwrite(file_id, "r\n");
                      $display("bot 1 velocity read", $time);
                      $fclose(file_id);
                   end
               end
               begin
                   #200 file_id = $fopen("C:/Users/sujan/Desktop/Suj/studies/Final year project/simultaneous_read/bot2.txt","r");
                   code=$fscanf(file_id, "%c\n",char2);
                   //$display("%c", char1);
                   if(char2 =="w")
                   begin
                      k = $fscanf(file_id, "%f\n",vx2);
                      //$display(vx2);
                      l = $fscanf(file_id, "%f\n",vy2);
                      //$display(vy2);
                      m = $fscanf(file_id, "%f\n",x2);
                      n = $fscanf(file_id, "%f\n",y2);
                      $fclose(file_id);
                      file_id = $fopen("C:/Users/sujan/Desktop/Suj/studies/Final year project/simultaneous_read/bot2.txt","w");
                      $fseek(file_id, 0, 0);
                      $fwrite(file_id, "r\n");
                      $display("bot 2 velocity read", $time);
                      $fclose(file_id);
                   end
                end
               begin
                  #400 file_id = $fopen("C:/Users/sujan/Desktop/Suj/studies/Final year project/simultaneous_read/bot3.txt","r");
                  code=$fscanf(file_id, "%c\n",char3);
                  //$display("%c", char1);
                  if(char3 =="w")
                  begin
                      k = $fscanf(file_id, "%f\n",vx3);
                      //$display(vx3);
                      l = $fscanf(file_id, "%f\n",vy3);
                      //$display(vy3);
                      m = $fscanf(file_id, "%f\n",x3);
                      n = $fscanf(file_id, "%f\n",y3);
                      $fclose(file_id);
                      file_id = $fopen("C:/Users/sujan/Desktop/Suj/studies/Final year project/simultaneous_read/bot3.txt","w");
                      $fseek(file_id, 0, 0);
                      $fwrite(file_id, "r\n");
                      $display("bot 3 velocity read", $time);
                      $fclose(file_id);
                  end
               end 
            join 
            //$display($time);
        end
    
    endmodule
