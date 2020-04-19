module write_test ;

integer i;
integer file_id;
reg x1;
reg x2;
wire y;
integer j = 1;
integer char1, char2, char3;
//reg vx1 =, vy1 = 0.01d;
real vx1 = 0, vy1 = 0.01;
real vx2 = 0.03, vy2 = 0.04;
real vx3 = 0.06, vy3 = 0.08;
always
    begin 
        fork 
           begin
              #200 file_id = $fopen("C:/Users/sujan/Desktop/Suj/studies/Final year project/simultaneous_write/bot1.txt","r");
              $fscanf(file_id, "%c",char1);
              //$display("%c", char1);
              $fclose(file_id);
              vx1 = vx1 + 0.01;
              vy1 = vy1 + 0.01;
              if(char1 =="r")
              begin
              file_id = $fopen("C:/Users/sujan/Desktop/Suj/studies/Final year project/simultaneous_write/bot1.txt","w");
               $fwrite(file_id, "w\n");
               $fwrite(file_id,vx1,"\n");
               $fwrite(file_id,vy1,"\n");
               //$fwrite(file_id, "\n");
               $display("bot1", $time);
               $fclose(file_id);
               end
           end
           begin
              #300 file_id = $fopen("C:/Users/sujan/Desktop/Suj/studies/Final year project/simultaneous_write/bot2.txt","r");
               $fscanf(file_id, "%c",char2);
               //$display("%c", char1);
               $fclose(file_id);
               vx2 = vx2 + 0.01;
               vy2 = vy2 + 0.01;
               if(char1 =="r")
               file_id = $fopen("C:/Users/sujan/Desktop/Suj/studies/Final year project/simultaneous_write/bot2.txt","w");
               $fwrite(file_id, "w\n");
               $fwrite(file_id,vx2,"\n");
               $fwrite(file_id,vy2,"\n");
               //$fwrite(file_id, "\n");
               $display("bot2", $time);
               $fclose(file_id);
            end
           begin
              #100 file_id = $fopen("C:/Users/sujan/Desktop/Suj/studies/Final year project/simultaneous_write/bot3.txt","r");
              $fscanf(file_id, "%c",char3);
              //$display("%c", char1);
              $fclose(file_id);
              vx3 = vx3 + 0.01;
              vy3 = vy3 + 0.01;
              if(char3 =="r")
              file_id = $fopen("C:/Users/sujan/Desktop/Suj/studies/Final year project/simultaneous_write/bot3.txt","w");
              $fwrite(file_id, "w\n");
              $fwrite(file_id,vx3,"\n");
              $fwrite(file_id,vy3,"\n");
              //$fwrite(file_id, "\n");
              $display("bot3", $time);
              $fclose(file_id);
           end 
        join 
        //$display($time);
    end

endmodule