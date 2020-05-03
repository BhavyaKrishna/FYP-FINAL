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

    
    module read_test(output_check,x1_bin,y1_bin,vx1_bin,vy1_bin,x2_bin,y2_bin,vx2_bin,vy2_bin,read_done) ;
    input output_check;
    output [15:0] x1_bin,y1_bin,vx1_bin,vy1_bin,x2_bin,y2_bin,vx2_bin,vy2_bin;
    output read_done;
    integer i,code,k,l,m,n;
    integer file_id;
    wire y;
    integer j = 1;
    integer char1, char2, char3;
    //reg vx1 =, vy1 = 0.01d;
    real vx1, vy1, x1, y1;
    real vx2, vy2, x2, y2;
    real vx3, vy3, x3, y3;
    reg [15:0] x1_bin_reg,y1_bin_reg,vx1_bin_reg,vy1_bin_reg,x2_bin_reg,y2_bin_reg,vx2_bin_reg,vy2_bin_reg;
    reg read_done_reg=1'b0;
    reg en_reg = 1'b1;
    //reg enable;
    
    //assign en_reg = en;
    
    assign x1_bin    = x1_bin_reg;
    assign x2_bin    = x2_bin_reg;
    assign y1_bin    = y1_bin_reg;
    assign y2_bin    = y2_bin_reg;
    assign vx1_bin   = vx1_bin_reg;
    assign vy1_bin   = vy1_bin_reg;
    assign vx2_bin   = vx2_bin_reg;
    assign vy2_bin   = vy2_bin_reg;
    assign read_done = read_done_reg;
    
    /*initial 
    begin
    $display(en_reg);
    end*/

    always@(en_reg)
      
        begin 
            //$display("enable = %b", en_reg);
            //read_done_reg    = 1'b0;
            //if (en_reg ==1)
            //begin
            fork 
               begin
                  #300 file_id = $fopen("C:/Users/sujan/Desktop/project final files/textfiles/bot1_read.txt","r");
                  code=$fscanf(file_id, "%c\n",char1);
                  //$display("%c", char1);
                  //$fclose(file_id);
                  if(char1 =="w")
                  begin
                      //file_id = $fopen("C:/Users/sujan/Desktop/project final files/textfiles/bot1_read.txt","r");
                      k = $fscanf(file_id, "%f\n",vx1);
                      //$display(vx1);
                      l = $fscanf(file_id, "%f\n",vy1);
                     //$display(vy1);
                     m = $fscanf(file_id, "%f\n",x1);
                     n = $fscanf(file_id, "%f\n",y1);
                      $fclose(file_id);
                      //$fwrite(file_id, "\n");
                      file_id = $fopen("C:/Users/sujan/Desktop/project final files/textfiles/bot1_read.txt","w");
                      $fseek(file_id, 0, 0);
                      $fwrite(file_id, "r\n");
                      $display("bot 1 velocity read", $time);
                      $fclose(file_id);
                   end
               end
               begin
                   #200 file_id = $fopen("C:/Users/sujan/Desktop/project final files/textfiles/bot2_read.txt","r");
                   code=$fscanf(file_id, "%c\n",char2);
                   //$display("%c", char1);
                   //$fclose(file_id);
                   if(char2 =="w")
                   begin
                      //file_id = $fopen("C:/Users/sujan/Desktop/project final files/textfiles/bot2_read.txt","r");
                      k = $fscanf(file_id, "%f\n",vx2);
                      //$display(vx2);
                      l = $fscanf(file_id, "%f\n",vy2);
                      //$display(vy2);
                      m = $fscanf(file_id, "%f\n",x2);
                      n = $fscanf(file_id, "%f\n",y2);
                      $fclose(file_id);
                      file_id = $fopen("C:/Users/sujan/Desktop/project final files/textfiles/bot2_read.txt","w");
                      $fseek(file_id, 0, 0);
                      $fwrite(file_id, "r\n");
                      $display("bot 2 velocity read", $time);
                      $fclose(file_id);
                   end
                end
               begin
                  #400 file_id = $fopen("C:/Users/sujan/Desktop/project final files/textfiles/bot3_read.txt","r");
                  code=$fscanf(file_id, "%c\n",char3);
                  //$display("%c", char1);
                  //$fclose(file_id);
                  if(char3 =="w")
                  begin
                    //file_id = $fopen("C:/Users/sujan/Desktop/project final files/textfiles/bot3_read.txt","r");
                      k = $fscanf(file_id, "%f\n",vx3);
                      //$display(vx3);
                      l = $fscanf(file_id, "%f\n",vy3);
                      //$display(vy3);
                      m = $fscanf(file_id, "%f\n",x3);
                      n = $fscanf(file_id, "%f\n",y3);
                      $fclose(file_id);
                      file_id = $fopen("C:/Users/sujan/Desktop/project final files/textfiles/bot3_read.txt","w");
                      $fseek(file_id, 0, 0);
                      $fwrite(file_id, "r\n");
                      $display("bot 3 velocity read", $time);
                      $fclose(file_id);
                      read_done_reg    = 1'b1;
                      #100;
                      //assign read_done = read_done_reg;
                      //$display("%b", read_done_reg);
                     en_reg = 1'b0;
                     $display("disabled ");
                  end
               end 
            join 
            x1_bin_reg   = x1  * 2**(11);
            y1_bin_reg   = y1  * 2**(11);
            vx1_bin_reg  = vx1 * 2**(11);
            vy1_bin_reg  = vy1 * 2**(11);
            x2_bin_reg   = x2  * 2**(11);
            y2_bin_reg   = y2  * 2**(11);
            vx2_bin_reg  = vx2 * 2**(11);
            vy2_bin_reg  = vy2 * 2**(11);
            #100;
            //$display("Sujana %b", read_done);
            read_done_reg    = 1'b0;
            
            //end
        end
    always@(posedge output_check)
    begin
    en_reg = 1'b1;
    $display("enabled");
    end
    endmodule
