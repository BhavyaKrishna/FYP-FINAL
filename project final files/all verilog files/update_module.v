`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.04.2020 22:35:37
// Design Name: 
// Module Name: update_module
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


module update_module(x, y, vx, vy, ax, ay ,t,clock, in_rdy,out_rdy,xnew, ynew, vxnew, vynew);

input [15:0] x,y,vx,vy,ax,ay,t;
output [15:0] xnew,ynew,vxnew,vynew; //confirm size of t
input clock,in_rdy;			
output reg out_rdy;

reg [15:0] X,Y,VX,VY,AX,AY,T;    //input registers

reg [15:0] xnew,ynew,vxnew,vynew; //output registers
reg [31:0] a,b,c,d,i,j;                               //intermediate registers
reg [15:0] e,f,g,h,k,l,M0A,M0B,M1A,M1B,P0,Q0,P1,Q1,SHI,SFI;
wire [0:10] carry;
integer count=0;
wire[31:0] M0P,M1P;
wire [15:0] S0,S1,SHO,SFO;
//instantiations

multiplier_16bit mult0(M0P, M0A, M0B);
multiplier_16bit mult1(M1P, M1A,M1B);

adder_16bit add0(carry[0],S0,P0,Q0,1'b0);
adder_16bit add1(carry[1],S1,P1,Q1,1'b0);

shifter shift0(SHI,SHO);
shifter shift1(SFI,SFO);  

always @(posedge clock)
 
 if(in_rdy)
  begin
 
  case(count)
  0: begin
      X<=x; Y<=y; VX<=vx; VY<=vy; AX<=ax; AY<=ay; T<=t;     //input registers getting their values 
     end
     
  1:begin  
     M0A<=AX; M0B<=T;
     M1A<=AY; M1B<=T;
    end
  2:begin
     a=M0P;
     b=M1P;
     M0A<=VX; M0B<=T;
     M1A<=VY; M1B<=T;
     P0<=VX; Q0<=a;
     P1<=VY; Q1<=b;
    end
  3:begin
     c=M0P;
     d=M1P;
     k=S0;
     l=S1;
     P0<=X; Q0<=c;
     P1<=Y; Q1<=d;  
     SHI=a;
     SFI=b; 
     vxnew=k;
     vynew=l;
    end
   4:begin
      g=SHO;
      h=SFO;
      e=S0;
      f=S1;
      M0A<=g; M0B=T;
      M1A<=h; M1B=T;
     end       
   5:begin       
      i=M0P;
      j=M1P;    
      P0<=e; Q0<=i;            
      P1<=f; Q1<=j;
    end        
   6:begin
      xnew=S0;  
      ynew=S1;
      count=-1;             //so that after updation it goes to 0
      out_rdy = 1'b1;
      #5
      out_rdy=1'b0;         //out_rdy signal is raised once all outputs are ready
    end 
     
  endcase
 count=count+1;
 end
     
endmodule

	