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


module Integrator1(tx1,ty1,x1_not_update,y1_not_update, vx_not_update,vy_not_update,x1,y1,vx1,vy1,x2,y2,vx2,vy2,x3,y3,vx3,vy3,ax,ay,input_rdy,clock,ig_done);

input [15:0] tx1,ty1,x1_not_update,y1_not_update,vx_not_update,vy_not_update,x1,y1,vx1,vy1,x2,y2,vx2,vx3,vy2,x3,y3,vy3,ax,ay;
input input_rdy,clock;
output ig_done;

reg ig_done_reg=1'b0;
assign ig_done=ig_done_reg;
reg [15:0] count1=0;
reg [15:0] diffx,diffy;
wire [15:0] t;
wire [31:0] R;
reg [31:0] R_reg=32'd203004;

reg [15:0] vx1_WT,vy1_WT;
wire [15:0] WT_vx1,WT_vy1;
 
reg input_CD1=1'b0;
reg input_CD2=1'b0;
reg input_UM=1'b0;
reg input_VS=1'b0;

reg output_check_reg=1'b0;
reg input_check_reg=1'b1;

wire output_in_rdy;
wire output_written;
wire input_in_rdy;

reg vs_ip_sel=1'b0;// One from file else from UM

//Update module Variables
wire [15:0] UM_Vxin,UM_Vyin,xnew,ynew,vxnew,vynew;
wire UM_in_rdy,UM_out_rdy;
reg [15:0] Vxnew_UM,Vynew_UM;
update_module UM (x1, y1, UM_Vxin, UM_Vyin, ax, ay ,t,clock, UM_in_rdy,UM_out_rdy,xnew, ynew, vxnew, vynew);

//Velocity Selector Variables
wire [15:0] VS_Vxin,VS_Vyin,VS_Vxout,VS_Vyout;
wire VS_in_rdy,VS_out_rdy;
reg  [15:0] Vxnew_VS,Vynew_VS;
Velocity_selector VS (VS_Vxin,VS_Vyin,clock,VS_in_rdy,VS_Vxout,VS_Vyout,VS_out_rdy);

//Update module Variables
wire [15:0] CD_Vxin,CD_Vyin,CD_xin,CD_yin;
wire CD1_in_rdy,CD1_out_rdy;
wire CD2_in_rdy,CD2_out_rdy;
reg [15:0] Vxnew_CD,Vynew_CD,xnew_CD,ynew_CD;
wire coll_detect1,coll_detect2;
coll_det CD1(CD_xin,CD_yin,x2, y2, CD_Vxin, CD_Vyin, vx2, vy2, R, coll_detect1, clock, CD1_in_rdy, CD1_out_rdy);
coll_det CD2(CD_xin,CD_yin,x3, y3, CD_Vxin, CD_Vyin, vx3, vy3, R, coll_detect2, clock, CD2_in_rdy, CD2_out_rdy);

//Write Test for bot1 
write_test2 WT(WT_vx1,WT_vy1,output_in_rdy,output_written);

assign R     = R_reg;
assign t = 16'd1;         //Time should not be scaled :) for LHS and RHS being okay.

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
assign CD1_in_rdy    = input_CD1;
assign CD2_in_rdy    = input_CD2;

assign output_in_rdy =  output_check_reg;
assign input_in_rdy  =  input_check_reg;

assign WT_vx1        =  vx1_WT;
assign WT_vy1        =  vy1_WT;

always @(posedge input_rdy)   //Make input_check high for writing into UM from file
begin
        input_CD1 = 1'b1;
        input_CD2 = 1'b1;
        Vxnew_CD  =  vx1;
        Vynew_CD  =  vy1;
        xnew_CD   =  x1;
        ynew_CD   =  y1;
        vs_ip_sel = 1'b0; //from file

end
always @(posedge CD1_out_rdy)
begin   
    #10;
    input_CD1 = 1'b0;
end
always @(posedge CD2_out_rdy)
begin   
    #10;
    input_CD2 = 1'b0;
end

always @(posedge UM_out_rdy)
begin
    input_CD1 = 1'b1;
    input_CD2=  1'b1;
    xnew_CD  = xnew;
    ynew_CD  = ynew;
    Vxnew_CD = vxnew;
    Vynew_CD = vynew;
    #10;
    input_UM = 1'b0;
end

always @(coll_detect1 | coll_detect2 )   //Load only when collision exist
begin
    if((coll_detect1==1)||(coll_detect2 ==1))
        begin
        count1=1'b0;
        input_VS = 1'b1;
        case(vs_ip_sel)
            0:begin
                Vxnew_VS = vx_not_update;
                Vynew_VS = vy_not_update;
              end
            1:begin
                Vxnew_VS  = UM_Vxin;
                Vynew_VS  = UM_Vyin;
              end
        endcase
    end
    
    if((coll_detect1==0)&&(coll_detect2 ==0))
    begin
        count1=count1+1'd1;
        output_check_reg=1'b1;
        $display("count2 : ", count1);
        if(count1>=4'd8)
        begin
            diffx = tx1-x1_not_update;
            diffy = ty1-y1_not_update;
            if ($signed(diffx)<$signed(16'd2048)&&$signed(diffx)>$signed(-16'd2048)&&$signed(diffy)<$signed(16'd2048)&&$signed(diffy)>$signed(-16'd2048))
            begin
            vx1_WT  =$signed(diffx)*(1.0/(2.0));
            vy1_WT =$signed(diffy)*(1.0/(2.0));;
            end
            else
            begin
            vx1_WT  =$signed(diffx)*(1.0/(10.0));
            vy1_WT =$signed(diffy)*(1.0/(10.0));;
            end
            $display("No collision for long so moving towars target", $time);
        end
        else
        begin
            case(vs_ip_sel)
                0:begin
                    vx1_WT = vx_not_update;
                    vy1_WT = vy_not_update;
                  end
                1:begin
                    vx1_WT  = UM_Vxin;
                    vy1_WT  = UM_Vyin;
                  end
            endcase
        end
        #10;
        output_check_reg=1'b0;
        ig_done_reg=1'b1;
        #10;
        ig_done_reg=1'b0;
    end
end
  
  
//path planner attempt






always @(posedge VS_out_rdy)
begin
    input_UM = 1'b1;
    Vxnew_UM = VS_Vxout;
    Vynew_UM = VS_Vyout;
    vs_ip_sel= 1'b1;
    #10;                     //Delay necessary to copy the outputs before deactivating the module
    input_VS = 1'b0;        //To turn the module of once output is ready(simillarly with the rest);
end

endmodule
