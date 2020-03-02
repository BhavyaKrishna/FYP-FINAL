`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.02.2020 20:54:58
// Design Name: 
// Module Name: write_test
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


module write_test ;

integer i;
integer file_id;
reg x1;
reg x2;
wire y;


AND_2 andgate(y,x1,x2);


always
    begin
    $display("checkpoint 1");
    #10
   // file_id = $fopen("writtenfile.dat","w+");
    #10
    /*for(i=0;i<10;i=i+1)
    begin
    $fwrite(file_id,"%02h",i);
    end*/
    

 
   
   x1=0;
   x2=0;
   #200
   file_id = $fopen("writtenfile.txt","a");
   $fwrite(file_id,"%b",y);
   $fclose(file_id);
   
   
   x1=1;
   x2=0;
   #200
   //$fwrite(file_id,"%b",y);
   file_id = $fopen("writtenfile.txt","a");
   $fwrite(file_id,"%b",y);
   $fclose(file_id);
   
   
   x1=0;
   x2=1;
   #200
  // $fwrite(file_id,"%b",y);
   file_id = $fopen("writtenfile.txt","a");
   $fwrite(file_id,"%b",y);
   $fclose(file_id);   
   
   
   x1=1;
   x2=1;
   #200
 //  $fwrite(file_id,"%b",y);
    file_id = $fopen("writtenfile.txt","a");
   $fwrite(file_id,"%b",y);
   $fclose(file_id);

       
end

//always 
//$monitor ($time, " Output y = %d" , y) ;



endmodule
