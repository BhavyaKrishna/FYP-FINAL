module read_test1(x1_bin,y1_bin,vx1_bin,vy1_bin,read_done1);
 output [15:0] x1_bin,y1_bin,vx1_bin,vy1_bin;
 output read_done1;
 
 integer i,code,k,l,m,n;
 integer file_id;
 wire y;
 integer j = 1;
 integer char1;
     //reg vx1 =, vy1 = 0.01d;
 real vx1, vy1, x1, y1;
 reg [15:0] x1_bin_reg,y1_bin_reg,vx1_bin_reg,vy1_bin_reg;
 reg read_done_reg1=1'b0;
 assign x1_bin    = x1_bin_reg;
 assign y1_bin    = y1_bin_reg;
 assign read_done1 = read_done_reg1;
 assign vx1_bin   = vx1_bin_reg;
 assign vy1_bin   = vy1_bin_reg;
 
 always 
     begin 
         #300 file_id = $fopen("F:/FYP-FINAL/synchronisation/bot1.txt","r");
         code=$fscanf(file_id, "%c\n",char1);
         $fclose(file_id);
         //$display("%c", char1);
         if(char1 =="w")
         begin
         file_id = $fopen("F:/FYP-FINAL/synchronisation/bot1.txt","r");
         code=$fscanf(file_id, "%c\n",char1);                              
         k = $fscanf(file_id, "%f\n",vx1);
         //$display(vx1);
         l = $fscanf(file_id, "%f\n",vy1);
         //$display(vy1);
         m = $fscanf(file_id, "%f\n",x1);
         n = $fscanf(file_id, "%f\n",y1);
         $fclose(file_id);
         //$fwrite(file_id, "\n");
         file_id = $fopen("F:/FYP-FINAL/synchronisation/bot1.txt","w");
         $fseek(file_id, 0, 0);
         $fwrite(file_id, "r\n");
         $display("bot 1 velocity read", $time);
         $fclose(file_id);
         end
          x1_bin_reg  <= x1  * 2**(11);
          y1_bin_reg  <= y1  * 2**(11);
          vx1_bin_reg <= vx1 * 2**(11);
          vy1_bin_reg <= vy1 * 2**(11);
 end
      always @(x1_bin or y1_bin or vx1_bin or vy1_bin)
      begin
              #10;
              read_done_reg1=1'b1;
              #100;
              read_done_reg1=1'b0;
          end
endmodule
