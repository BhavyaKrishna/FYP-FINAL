`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.04.2020 17:05:10
// Design Name: 
// Module Name: Integrator
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


module Integrator;

wire [15:0] x,y,vx,vy,ax,ay,t,x2,y2,vx2,vy2,UM_Vxin,UM_Vyin,CD_Vxin,CD_Vyin,CD_xin,CD_yin;
wire [15:0] xnew,ynew,vxnew,vynew; //confirm size of t

wire [31:0] R;

wire clock,UM_in_rdy,CD_in_rdy;			

wire UM_out_rdy;

wire CD_out_rdy;

wire trial;

wire [15:0] VS_Vxin,VS_Vyin,VS_Vxout,VS_Vyout;

wire VS_in_rdy;
wire VS_out_rdy;

reg [15:0] xnew_CD,ynew_CD,Vxnew_CD,Vynew_CD;

reg [15:0] Vxnew_UM,Vynew_UM;
reg [15:0] Vxnew_VS,Vynew_VS;

wire input_read;
wire output_in_rdy;

reg [15:0] ax_reg=16'd1024;
reg [15:0] ay_reg=16'd1024;
reg [31:0] R_reg=16'd451;

reg [15:0] vx1_WT,vy1_WT,vx2_WT,vy2_WT,vx3_WT,vy3_WT;
wire [15:0] WT_vx1,WT_vy1,WT_vx2,WT_vy2,WT_vx3,WT_vy3;
 
reg clock_reg;
reg input_CD=1'b0;
reg input_UM=1'b0;
reg input_VS=1'b0;

reg output_check_reg=1'b0;

wire output_written     =1'b0;

//To be deleted once all the bots are tied up
wire [15:0] UM_Vxin1,UM_Vyin1,xnew2,ynew2,vxnew2,vynew2;
reg  [15:0] xnew2_CD,ynew2_CD,Vxnew2_CD,Vynew2_CD;
wire [15:0] CD_Vxin2,CD_Vyin2,CD_xin2,CD_yin2;
wire UM_in_rdy2,UM_out_rdy2;
reg [15:0] Vxnew_UM2,Vynew_UM2;
reg input_UM2=1'b0;
assign UM_in_rdy2=input_UM2;
assign UM_Vxin1  =Vxnew_UM2;
assign UM_Vyin1 = Vynew_UM2;
assign CD_xin2=xnew2_CD;
assign CD_yin2=ynew2_CD;
assign CD_Vxin2=Vxnew2_CD;
assign CD_Vyin2=Vynew2_CD;
update_module UM21 (x2, y2, UM_Vxin1, UM_Vyin1, ax, ay ,t,clock, UM_in_rdy2,UM_out_rdy2,xnew2, ynew2, vxnew2, vynew2);
//Till here :)

update_module UM (x, y, UM_Vxin, UM_Vyin, ax, ay ,t,clock, UM_in_rdy,UM_out_rdy,xnew, ynew, vxnew, vynew);
Velocity_selector VS (VS_Vxin,VS_Vyin,clock,VS_in_rdy,VS_Vxout,VS_Vyout,VS_out_rdy);
coll_det CD(CD_xin,CD_yin,x2, y2, CD_Vxin, CD_Vyin, vx2, vy2, R, trial, clock, CD_in_rdy, CD_out_rdy);
read_test RT(x,y,vx,vy,x2,y2,vx2,vy2,input_read);
write_test WT(WT_vx1,WT_vy1,WT_vx2,WT_vy2,WT_vx3,WT_vy3,output_in_rdy,output_written);

 

assign R     = R_reg;
assign ax    = ax_reg;
assign ay    = ay_reg;
assign clock = clock_reg;
assign t = 16'd1000;         //Time should not b e scaled :) for LHS and RHS being okay.

assign CD_xin=xnew_CD;
assign CD_yin=ynew_CD;
assign CD_Vxin=Vxnew_CD;
assign CD_Vyin=Vynew_CD;

assign UM_Vxin=Vxnew_UM;
assign UM_Vyin=Vynew_UM;

assign VS_Vxin=Vxnew_VS;
assign VS_Vyin=Vynew_VS;

assign VS_in_rdy    = input_VS;
assign UM_in_rdy    = input_UM;
assign CD_in_rdy    = input_CD;

assign output_in_rdy =  output_check_reg;

assign WT_vx1        =  vx1_WT;
assign WT_vy1        =  vy1_WT;
assign WT_vx2        =  vx2_WT;
assign WT_vx2        =  vy2_WT;
assign WT_vx3        =  vx3_WT;
assign WT_vy3        =  vy3_WT;

always @(posedge input_read)   //Make input_check high for writing into UM from file
begin
        input_UM = 1'b1;
        Vxnew_UM = vx;
        Vynew_UM = vy;
        //To be deleted later
        input_UM2 = 1'b1;
        Vxnew_UM2 = vx2;
        Vynew_UM2 = vy2;//Till here
        #10;

end

always @(posedge UM_out_rdy)
begin
    input_CD = 1'b1;
    xnew_CD  = xnew;
    ynew_CD  = ynew;
    Vxnew_CD = vxnew;
    Vynew_CD = vynew;
    #10;
    input_UM = 1'b0;
end

always @(posedge UM_out_rdy)
begin
    xnew2_CD  = xnew2;
    ynew2_CD  = ynew2;
    Vxnew2_CD = vxnew2;
    Vynew2_CD = vynew2;
    #10;
    input_UM2 = 1'b0;
end

always @(posedge trial)   //Load only when collision exist
begin
    if(trial==1)
    begin
        input_VS = 1'b1;
        Vxnew_VS = UM_Vxin;
        Vynew_VS = UM_Vyin;
    end
end

always @(posedge CD_out_rdy)
begin   
    #10;
    input_CD = 1'b0;
end

always @(trial)
begin
    if(trial==0)
    begin
        output_check_reg=1'b1;
        vx1_WT=UM_Vxin;
        vy1_WT=UM_Vyin;
        #10;
        output_check_reg=1'b0;
    end
end

always @(posedge VS_out_rdy)
begin
    input_UM = 1'b1;
    Vxnew_UM = VS_Vxout;
    Vynew_UM = VS_Vyout;
    #10;                     //Delay necessary to copy the outputs before deactivating the module
    input_VS = 1'b0;        //To turn the module of once output is ready(simillarly with the rest);
end

always
    #50 clock_reg=~clock_reg;

initial
    clock_reg=0;

endmodule
