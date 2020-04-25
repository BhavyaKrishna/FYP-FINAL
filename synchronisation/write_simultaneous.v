module write_test ;

integer i,code;
integer file_id;
reg x1;
reg x2;
wire y;
integer j = 1;
integer char1, char2, char3;
//reg vx1 =, vy1 = 0.01d;
real vx1 = 0, vy1 = 0.001;
real vx2 = 0.003, vy2 = 0.004;
real vx3 = 0.006, vy3 = 0.008;
always
  
    begin 
        fork 
           begin
              #300 file_id = $fopen("F:/FYP-FINAL/synchronisation/bot1.txt","r");
              code=$fscanf(file_id, "%c",char1);
              //$display("%c", char1);
              $fclose(file_id);
              if(char1 =="r")
              begin
                  vx1 = -vx1;
                  vy1 = -vy1 ;
                  file_id = $fopen("F:/FYP-FINAL/synchronisation/bot1.txt","w");
                  $fwrite(file_id, "w\n");
                  $fwrite(file_id,vx1,"\n");
                  $fwrite(file_id,vy1,"\n");
                  //$fwrite(file_id, "\n");
                  $display("bot 1 velocity updated", $time);
                  $fclose(file_id);
               end
           end
           begin
               #300 file_id = $fopen("F:/FYP-FINAL/synchronisation/bot2.txt","r");
               code=$fscanf(file_id, "%c",char2);
               //$display("%c", char1);
               $fclose(file_id);
               if(char1 =="r")
               begin
                   vx2 = -vx2;
                   vy2 = -vy2;
                   file_id = $fopen("F:/FYP-FINAL/synchronisation/bot2.txt","w");
                   $fwrite(file_id, "w\n");
                   $fwrite(file_id,vx2,"\n");
                   $fwrite(file_id,vy2,"\n");
                   //$fwrite(file_id, "\n");
                   $display("bot 2 velocity updated", $time);
                   $fclose(file_id);
               end
            end
           begin
              #300 file_id = $fopen("F:/FYP-FINAL/synchronisation/bot3.txt","r");
              code=$fscanf(file_id, "%c",char3);
              //$display("%c", char1);
              $fclose(file_id);
              if(char3 =="r")
              begin
                  vx3 = -vx3;
                  vy3 = -vy3;
                  file_id = $fopen("F:/FYP-FINAL/synchronisation/bot3.txt","w");
                  $fwrite(file_id, "w\n");
                  $fwrite(file_id,vx3,"\n");
                  $fwrite(file_id,vy3,"\n");
                  //$fwrite(file_id, "\n");
                  $display("bot 3 velocity updated", $time);
                  $fclose(file_id);
              end
           end 
        join 
        //$display($time);
    end

endmodule