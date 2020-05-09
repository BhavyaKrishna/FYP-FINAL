module write_test1(vx1_bin,vy1_bin,write_check,write_done) ;

input [15:0] vx1_bin,vy1_bin; 
input write_check;
output write_done;

integer i,code;
integer file_id;
reg x1;
reg x2;
wire y;
integer j = 1;
integer char1, char2, char3;
//reg vx1 =, vy1 = 0.01d;
reg write_done_reg=1'b0;

real vx1 = 0, vy1 = 0.001;

assign write_done=write_done_reg; 

always @(posedge write_check)
  
    begin 
        vx1=$signed(vx1_bin)*(1.0/((2**11)*1.0));
        vy1=$signed(vy1_bin)*(1.0/((2**11)*1.0));
        file_id = $fopen("D:/Projects/FinalYearProject/bot11.txt","r");
        code=$fscanf(file_id, "%c",char1);
        $fclose(file_id);
        if(char1 =="r")
              begin
                  file_id = $fopen("D:/Projects/FinalYearProject/bot11.txt","w");
                  $fwrite(file_id, "w\n");
                  $fwrite(file_id,vx1,"\n");
                  $fwrite(file_id,vy1,"\n");
                  //$fwrite(file_id, "\n");
                  $display("bot 1 velocity updated", $time);
                  $fclose(file_id);
                  write_done_reg=1'b1;
               end
          #50 write_done_reg=1'b0;
    end

endmodule