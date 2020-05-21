module coll_det(x1, y1, x2, y2, vx1, vy1, vx2, vy2, r2, trial, clock, in_rdy,out_rdy);

input [15:0] x1, y1, x2, y2, vx1, vy1, vx2, vy2;
input [31:0] r2;
output trial;
input clock,in_rdy;			
output reg out_rdy;

reg [31:0] X1,Y1,X2,Y2,VX1,VY1,VX2,VY2,R2;    //input registers
reg trial; //output registers
reg [31:0] e,f,g,h,i,j;
reg [63:0] dot_sq,l,m,n;                               //intermediate registers
reg [31:0] a,b,c,d,r_sq,vab_sq,k,M0A,M0B,M1A,M1B,P0,Q0,P1,Q1,P2,Q2,P3,Q3,P4,Q4,P5,Q5,P6,Q6;
reg [63:0] C1,C2,P7,Q7;

wire [0:10] carry;

integer count=0;
wire C0;
wire[63:0] M0P,M1P,S7;
wire [31:0] S0,S1,S2,S3,S4,S5,S6;
//instantiations

multiplier_32bit mult0(M0P, M0A, M0B);
multiplier_32bit mult1(M1P, M1A, M1B);

adder_32bit add0(carry[0],S0,P0,Q0,1'b0);
adder_32bit add1(carry[1],S1,P1,Q1,1'b0);
adder_32bit add2(carry[2],S2,P2,Q2,1'b0);

subtractor_32bit sub0(carry[3],S3,P3,Q3,1'b1);
subtractor_32bit sub1(carry[4],S4,P4,Q4,1'b1);
subtractor_32bit sub2(carry[5],S5,P5,Q5,1'b1);
subtractor_32bit sub3(carry[6],S6,P6,Q6,1'b1);
subtractor_64bit sub4(carry[7],S7,P7,Q7,1'b1);
comparator comp1(C0,C1,C2);

assign out_rdy=output_rdy_reg;
always @(posedge clock)
 
 if(in_rdy)
  begin
 
  case(count)
  0: begin
 if(x1[15])
	begin
	X1[31:16]<=16'b1111111111111111;
	X1[15:0]<=x1;
	end
	else
	begin
	X1[31:16]<=16'b0;
	X1[15:0]<=x1;
	end

	if(y1[15])
	begin
	Y1[31:16]<=16'b1111111111111111;
	Y1[15:0]<=y1;
	end
	else
	begin
	Y1[31:16]<=16'b0;
	Y1[15:0]<=y1;
	end

	if(x2[15])
	begin
	X2[31:16]<=16'b1111111111111111;
	X2[15:0]<=x2;
	end
	else
	begin
	X2[31:16]<=16'b0;
	X2[15:0]<=x2;
	end

	if(y2[15])
	begin
	Y2[31:16]<=16'b1111111111111111;
	Y2[15:0]<=y2;
	end
	else
	begin
	Y2[31:16]<=16'b0;
	Y2[15:0]<=y2;
	end
	
	if(vx1[15])
	begin
	VX1[31:16]<=16'b1111111111111111;
	VX1[15:0]<=vx1;
	end
	else
	begin
	VX1[31:16]<=16'b0;
	VX1[15:0]<=vx1;
	end

	if(vy1[15])
	begin
	VY1[31:16]<=16'b1111111111111111;
	VY1[15:0]<=vy1;
	end
	else
	begin
	VY1[31:16]<=16'b0;
	VY1[15:0]<=vy1;
	end

	if(vx2[15])
	begin
	VX2[31:16]<=16'b1111111111111111;
	VX2[15:0]<=vx2;
	end
	else
	begin
	VX2[31:16]<=16'b0;
	VX2[15:0]<=vx2;
	end

	if(vy2[15])
	begin
	VY2[31:16]<=16'b1111111111111111;
	VY2[15:0]<=vy2;
	end
	else
	begin
	VY2[31:16]<=16'b0;
	VY2[15:0]<=vy2;
	end
	R2<=r2;     //input registers getting their values 
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
     P7<=l; Q7<=dot_sq;
     M0A<=vab_sq; M0B<=R2;
    end

   8:begin       
     m=S7;
     n=M0P;    
     C1<=m; C2<=n;
    end
     
   9:begin
      trial=C0;  
      count=-1;             //so that after updation it goes to 0
      output_rdy_reg=1'b1;
               //out_rdy signal is raised once all outputs are ready
      #10;
      trial=1'bX;
      output_rdy_reg=1'b0;
      
    end 
     
  endcase
 count=count+1;
 end
     
endmodule
