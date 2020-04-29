module coll_det(x1, y1, x2, y2, vx1, vy1, vx2, vy2, r2, trial, clock, in_rdy,out_rdy);

input [15:0] x1, y1, x2, y2, vx1, vy1, vx2, vy2, r2;
output trial;
input clock,in_rdy;			
output out_rdy;

reg [15:0] X1,Y1,X2,Y2,VX1,VY1,VX2,VY2,R2;    //input registers
reg trial; //output registers
reg [31:0] e,f,g,h,i,j,l,n,dot_sq;                               //intermediate registers
reg [15:0] a,b,c,d,r_sq,vab_sq,k,m,M0A,M0B,M1A,M1B,P0,Q0,P1,Q1,P2,Q2,P3,Q3,P4,Q4,P5,Q5,P6,Q6;
reg [63:0] C1,C2;
wire [0:10] carry;
reg output_ready=1'b0;

integer count=0;
wire C0;
wire[31:0] M0P,M1P;
wire [15:0] S0,S1,S2,S3,S4,S5,S6;
//instantiations

multiplier_16bit mult0(M0P, M0A, M0B);
multiplier_16bit mult1(M1P, M1A, M1B);

adder_16bit add0(carry[0],S0,P0,Q0,1'b0);
adder_16bit add1(carry[1],S1,P1,Q1,1'b0);
adder_16bit add2(carry[2],S2,P2,Q2,1'b0);

subtractor_16bit sub0(carry[3],S3,P3,Q3,1'b1);
subtractor_16bit sub1(carry[4],S4,P4,Q4,1'b1);
subtractor_16bit sub2(carry[5],S5,P5,Q5,1'b1);
subtractor_16bit sub3(carry[6],S6,P6,Q6,1'b1);
 
comparator comp1(C0,C1,C2);

assign out_rdy=output_ready;

always @(posedge clock)
 
 if(in_rdy)
  begin
 
  case(count)
  0: begin
      X1<=x1; Y1<=y1; X2<=x2; Y2<=y2; VX1<=vx1; VY1<=vy1; VX2<=vx2; VY2<=vy2; R2<=r2;     //input registers getting their values 
     end
     
  1:begin  
     P3<=X1; Q3<=X2;
     P4<=Y1; Q4<=Y2;
     P5<=VX1; Q5<=VX2;
     P6<=VY1; Q6<=VY2;
    end

  2:begin
     a=S3;
     b=S4;
     c=S5;
     d=S6;
     
     M0A<=a; M0B<=a;
     M1A<=b; M1B<=b;
    end

  3:begin
     e=M0P;
     f=M1P;
     M0A<=c; M0B<=c;
     M1A<=d; M1B<=d;
    end

   4:begin
     g=M0P;
     h=M1P;
     M0A<=a; M0B<=c;
     M1A<=b; M1B<=d;
     end
       
   5:begin       
     i=M0P;
     j=M1P;    
     P0<=e; Q0<=f;            
     P1<=g; Q1<=h;
     P2<=i; Q2<=j;
    end

   6:begin       
     r_sq=S0;
     vab_sq=S1;
     k=S2;    
     M0A<=k; M0B<=k;
     M1A<=r_sq; M1B<=vab_sq;     
    end

   7:begin       
     dot_sq=M0P;
     l=M1P;    
     P3<=l; Q3<=dot_sq;
     M0A<=vab_sq; M0B<=R2;
    end

   8:begin     
     m=S3;
     n=M0P;    
     C1<=m; C2<=n;
    end
     
   9:begin
      trial=C0;  
      count=-1;             //so that after updation it goes to 0
      output_ready=1'b1;         //out_rdy signal is raised once all outputs are ready 
      #5;
      output_ready=1'b0;  //Should be given as a pulse
    end 
     
  endcase
 count=count+1;
 end
     
endmodule
