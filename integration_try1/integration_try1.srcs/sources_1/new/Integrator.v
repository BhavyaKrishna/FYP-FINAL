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
wire input_check;
wire output_check;
reg [15:0] ax_reg=1,ay_reg=1;
reg [31:0] R_reg=1;
reg [15:0] vx1_WT,vy1_WT,vx2_WT,vy2_WT,vx3_WT,vy3_WT;
wire [15:0] WT_vx1,WT_vy1,WT_vx2,WT_vy2,WT_vx3,WT_vy3;
 
reg clock_reg;
reg input_CD=1'b0;
reg input_UM=1'b0;
reg input_VS=1'b0;

reg output_check_reg=1'b0;

update_module UM (x, y, UM_Vxin, UM_Vyin, ax, ay ,t,clock, UM_in_rdy,UM_out_rdy,xnew, ynew, vxnew, vynew);
Velocity_selector VS (VS_Vxin,VS_Vyin,clock,VS_in_rdy,VS_Vxout,VS_Vyout,VS_out_rdy);
coll_det CD(CD_xin,CD_yin,x2, y2, CD_Vxin, CD_Vyin, vx2, vy2, R, trial, clock, CD_in_rdy, CD_out_rdy);
read_test RT(x,y,vx,vy,x2,y2,vx2,vy2,input_check);
write_test WT(WT_vx1,WT_vy1,WT_vx2,WT_vy2,WT_vx3,WT_vy3,output_check) ;

assign R     = R_reg;
assign ax    = ax_reg;
assign ay    = ay_reg;
assign clock = clock_reg;
assign t = 1'b1;

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

assign output_check  =  output_check_reg;
assign WT_vx1        =  vx1_WT;
assign WT_vy1        =  vy1_WT;
assign WT_vx2        =  vx2_WT;
assign WT_vx2        =  vy2_WT;
assign WT_vx3        =  vx3_WT;
assign WT_vy3        =  vy3_WT;

always @(posedge input_check)   //Make input_check high for writing into UM from file
begin
        input_UM = 1'b1;
        Vxnew_UM = vx;
        Vynew_UM = vy;
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

always @(posedge trial)   //Load only when collision exist
begin
    input_VS = 1'b1;
    Vxnew_VS = CD_Vxin;
    Vynew_VS = CD_Vyin;
end

always @(posedge CD_out_rdy)
begin   
    #10;
    input_CD = 1'b0;
end

always @(negedge trial)
begin
    output_check_reg=1'b1;
    vx1_WT=CD_Vxin;
    vy1_WT=CD_Vyin;
    #10;
    output_check_reg=1'b0;
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
