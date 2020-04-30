module write_test(vx1_bin,vy1_bin,vx2_bin,vy2_bin,vx3_bin,vy3_bin,write_check) ;

input [15:0] vx1_bin,vy1_bin,vx2_bin,vy2_bin,vx3_bin,vy3_bin; 
input write_check;

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

always @(posedge write_check)
  
    begin 
        vx1=vx1_bin*(1.0/((2**11)*1.0));
        vy1=vy1_bin*(1.0/((2**11)*1.0));
        vx2=vx2_bin*(1.0/((2**11)*1.0));
        vy2=vy2_bin*(1.0/((2**11)*1.0));
        vx3=vx3_bin*(1.0/((2**11)*1.0));
        vy3=vy3_bin*(1.0/((2**11)*1.0));
        fork 
           begin
              #300 file_id = $fopen("F:/FYP-FINAL/synchronisation/bot11.txt","r");
              code=$fscanf(file_id, "%c",char1);
              //$display("%c", char1);
              $fclose(file_id);
              if(char1 =="r")
              begin
                  file_id = $fopen("F:/FYP-FINAL/synchronisation/bot11.txt","w");
                  $fwrite(file_id, "w\n");
                  $fwrite(file_id,vx1,"\n");
                  $fwrite(file_id,vy1,"\n");
                  //$fwrite(file_id, "\n");
                  $display("bot 1 velocity updated", $time);
                  $fclose(file_id);
               end
           end
           begin
               #300 file_id = $fopen("F:/FYP-FINAL/synchronisation/bot22.txt","r");
               code=$fscanf(file_id, "%c",char2);
               //$display("%c", char1);
               $fclose(file_id);
               if(char1 =="r")
               begin
                   file_id = $fopen("F:/FYP-FINAL/synchronisation/bot22.txt","w");
                   $fwrite(file_id, "w\n");
                   $fwrite(file_id,vx2,"\n");
                   $fwrite(file_id,vy2,"\n");
                   //$fwrite(file_id, "\n");
                   $display("bot 2 velocity updated", $time);
                   $fclose(file_id);
               end
            end
           begin
              #300 file_id = $fopen("F:/FYP-FINAL/synchronisation/bot33.txt","r");
              code=$fscanf(file_id, "%c",char3);
              //$display("%c", char1);
              $fclose(file_id);
              if(char3 =="r")
              begin
                  file_id = $fopen("F:/FYP-FINAL/synchronisation/bot33.txt","w");
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