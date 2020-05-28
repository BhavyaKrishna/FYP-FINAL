module read_test3(x3_bin,y3_bin,vx3_bin,vy3_bin,read_done3);
 output [15:0] x3_bin,y3_bin,vx3_bin,vy3_bin;
 output read_done3;
 
 integer i,code,k,l,m,n;
 integer file_id;
 wire y;
 integer j = 1;
 integer char3;
     //reg vx1 =, vy1 = 0.01d;
 real vx3, vy3, x3, y3;
 reg [15:0] x3_bin_reg,y3_bin_reg,vx3_bin_reg,vy3_bin_reg;
 reg read_done_reg3=1'b0;
 assign x3_bin    = x3_bin_reg;
 assign y3_bin    = y3_bin_reg;
 assign read_done3 = read_done_reg3;
 assign vx3_bin   = vx3_bin_reg;
 assign vy3_bin   = vy3_bin_reg;
 
 always 
     begin 
         #300 file_id = $fopen("F:/FYP-FINAL/synchronisation/bot3.txt","r");
         code=$fscanf(file_id, "%c\n",char3);
         $fclose(file_id);
         //$display("%c", char1);
         if(char3 =="w")
         begin
         file_id = $fopen("F:/FYP-FINAL/synchronisation/bot3.txt","r");
         code=$fscanf(file_id, "%c\n",char3);                              
         k = $fscanf(file_id, "%f\n",vx3);
         //$display(vx1);
         l = $fscanf(file_id, "%f\n",vy3);
         //$display(vy1);
         m = $fscanf(file_id, "%f\n",x3);
         n = $fscanf(file_id, "%f\n",y3);
         $fclose(file_id);
         //$fwrite(file_id, "\n");
         file_id = $fopen("F:/FYP-FINAL/synchronisation/bot3.txt","w");
         $fseek(file_id, 0, 0);
         $fwrite(file_id, "r\n");
         $display("bot 3 velocity read", $time);
         $fclose(file_id);
         end
          x3_bin_reg  <= x3  * 2**(11);
          y3_bin_reg  <= y3  * 2**(11);
          vx3_bin_reg <= vx3 * 2**(11);
          vy3_bin_reg <= vy3 * 2**(11);
 end
      always @(x3_bin or y3_bin or vx3_bin or vy3_bin)
      begin
              #10;
              read_done_reg3=1'b1;
              #100;
              read_done_reg3=1'b0;
          end
endmodule
