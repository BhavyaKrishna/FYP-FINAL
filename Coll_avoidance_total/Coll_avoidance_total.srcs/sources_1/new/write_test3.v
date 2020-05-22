`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2020 18:25:36
// Design Name: 
// Module Name: write_test3
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


module write_test3(vx_bin,vy_bin,write_check,write_done) ;

input [15:0] vx_bin,vy_bin; 
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

real vx = 0, vy = 0.001;

assign write_done=write_done_reg; 

always @(posedge write_check)
  
    begin 
        vx=$signed(vx_bin)*(1.0/((2**11)*1.0));
        vy=$signed(vy_bin)*(1.0/((2**11)*1.0));
        file_id = $fopen("D:/Projects/FinalYearProject/bot33.txt","r");
        code=$fscanf(file_id, "%c",char1);
        $fclose(file_id);
        if(char1 =="r")
              begin
                  file_id = $fopen("D:/Projects/FinalYearProject/bot33.txt","w");
                  $fwrite(file_id, "w\n");
                  $fwrite(file_id,vx,"\n");
                  $fwrite(file_id,vy,"\n");
                  //$fwrite(file_id, "\n");
                  $display("bot 3 velocity updated", $time);
                  $fclose(file_id);
                  write_done_reg=1'b1;
               end
          #50 write_done_reg=1'b0;
    end

endmodule
