`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2020 13:53:37
// Design Name: 
// Module Name: top
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


module top;

wire clock;
reg clock_reg;
assign clock=clock_reg;

wire [15:0] x1,y1,vx1,vy1,ax,ay,t,x2,y2,vx2,vy2,x3,y3,vx3,vy3;

//Read test
wire input_read;
read_test RT(x1,y1,vx1,vy1,x2,y2,vx2,vy2,x3,y3,vx3,vy3,input_read);

//Assign values
reg [15:0] ax_reg,ay_reg;
assign ax    = 16'd1024;
assign ay    = 16'd1024;
assign t = 16'd1;   

//UM1 variables and instantiations
wire [15:0] UM_Vxin1,UM_Vyin1,xnew1,ynew1,vxnew1,vynew1;
wire UM_out_rdy1;
reg [15:0] Vxnew_UM1,Vynew_UM1;
wire UM_in_rdy1;
reg input_UM1 =1'b0;
assign UM_in_rdy1= input_UM1;
assign UM_Vxin1  = Vxnew_UM1;
assign UM_Vyin1  = Vynew_UM1;
update_module UM1 (x1, y1, UM_Vxin1, UM_Vyin1, ax, ay ,t,clock, UM_in_rdy1,UM_out_rdy1,xnew1, ynew1, vxnew1, vynew1);

//UM2 variables and instantiations
wire [15:0] UM_Vxin2,UM_Vyin2,xnew2,ynew2,vxnew2,vynew2;
wire UM_out_rdy2;
reg [15:0] Vxnew_UM2,Vynew_UM2;
wire UM_in_rdy2;
reg input_UM2 =1'b0;
assign UM_in_rdy2 = input_UM2;
assign UM_Vxin2   = Vxnew_UM2;
assign UM_Vyin2   = Vynew_UM2;
update_module UM2 (x2, y2, UM_Vxin2, UM_Vyin2, ax, ay ,t,clock, UM_in_rdy2,UM_out_rdy2,xnew2, ynew2, vxnew2, vynew2);

//UM3 variables and instantiations
wire [15:0] UM_Vxin3,UM_Vyin3,xnew3,ynew3,vxnew3,vynew3;
wire UM_out_rdy3;
reg [15:0] Vxnew_UM3,Vynew_UM3;
wire UM_in_rdy3;
reg input_UM3 =1'b0;
assign UM_in_rdy3 = input_UM3;
assign UM_Vxin3  =Vxnew_UM3;
assign UM_Vyin3 = Vynew_UM3;
update_module UM3 (x3, y3, UM_Vxin3, UM_Vyin3, ax, ay ,t,clock, UM_in_rdy3,UM_out_rdy3,xnew3, ynew3, vxnew3, vynew3);

reg  UM1_done,UM2_done,UM3_done;
wire UM_all_done;
assign UM_all_done=UM1_done & UM2_done & UM3_done;
//IG1 variables and instantiation
wire IG_in_rdy1,IG_out_rdy1;
reg IG_in_reg1;
assign IG_in_rdy1=IG_in_reg1;
Integrator I1(vx1,vy1,xnew1,ynew1,vxnew1,vynew1,xnew2,ynew2,vxnew2,vynew2,xnew3,ynew3,vxnew3,vynew3,IG_in_rdy1,clock,IG_out_rdy1);

wire IG_in_rdy2,IG_out_rdy2;
reg IG_in_reg2;
assign IG_in_rdy2=IG_in_reg2;
Integrator1 I2(vx2,vy2,xnew2,ynew2,vxnew2,vynew2,xnew1,ynew1,vxnew1,vynew1,xnew3,ynew3,vxnew3,vynew3,IG_in_rdy2,clock,IG_out_rdy2);

wire IG_in_rdy3,IG_out_rdy3;
reg IG_in_reg3;
assign IG_in_rdy3=IG_in_reg3;
Integrator2 I3(vx3,vy3,xnew3,ynew3,vxnew3,vynew3,xnew2,ynew2,vxnew2,vynew2,xnew1,ynew1,vxnew1,vynew1,IG_in_rdy3,clock,IG_out_rdy3);


always @(posedge input_read)   //Make input_check high for writing into UM from file
begin
        
        input_UM1 = 1'b1;
        Vxnew_UM1 = vx1;
        Vynew_UM1 = vy1;
        
        input_UM2 = 1'b1;
        Vxnew_UM2 = vx2;
        Vynew_UM2 = vy2;
 
        input_UM3 = 1'b1;
        Vxnew_UM3 = vx3;
        Vynew_UM3 = vy3;
        

end

always @(posedge UM_out_rdy1)
begin
    UM1_done  = 1'b1;
    #10;
    input_UM1 = 1'b0;
    UM1_done  = 1'b0;
end

always @(posedge UM_out_rdy2)
begin
    UM2_done  = 1'b1;
    #10;
    input_UM2 = 1'b0;
    UM2_done  = 1'b0;
    
end
always @(posedge UM_out_rdy3)
begin
    UM3_done  = 1'b1;
    #10;
    input_UM3 = 1'b0;
    UM3_done  = 1'b0;
end
always @(posedge UM_all_done)
begin
    IG_in_reg1=1'b1;
    IG_in_reg2=1'b1;
    IG_in_reg3=1'b1;
end    

always @(posedge IG_out_rdy1)
begin
IG_in_reg1=1'b0;
end

always @(posedge IG_out_rdy2)
begin
IG_in_reg2=1'b0;
end

always @(posedge IG_out_rdy3)
begin
IG_in_reg3=1'b0;
end

always
    #50 clock_reg=~clock_reg;

initial
    clock_reg=0;


endmodule
