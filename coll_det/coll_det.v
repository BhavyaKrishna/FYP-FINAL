module coll_det(x1, y1, x2, y2, vx1, vy1, vx2, vy2, R, trial);
	
	input [15:0]	x1,y1,x2,y2,vx1,vx2,vy1,vy2;
        input [31:0]	R;
	output 		trial;
	
	wire [15:0]	D,E,F,G;
	wire [31:0]	H,I,J,K,L,M,N,r_sq, vab_sq;
	wire [63:0]	O,S,P,Q;
	wire [7:0]	carry;

	subtractor_16bit subtr1(carry[0], D, x1, x2, 1'b1);
	subtractor_16bit subtr2(carry[1], E, y1, y2, 1'b1);
	subtractor_16bit subtr3(carry[2], F, vx1, vx2, 1'b1);
	subtractor_16bit subtr4(carry[3], G, vy1, vy2, 1'b1);

	multiplier_16bit mult1(H, D, D);
	multiplier_16bit mult2(I, E, E);
	multiplier_16bit mult3(J, F, F);
	multiplier_16bit mult4(K, G, G);	
	multiplier_16bit mult5(L, D, F);
	multiplier_16bit mult6(M, E, G);

	adder_32bit adder321(carry[4], r_sq, H, I, 1'b0);
	adder_32bit adder322(carry[5], vab_sq, J, K, 1'b0);	
	adder_32bit adder323(carry[6], N, L, M, 1'b0);	

	multiplier_32bit mult7(O, r_sq, vab_sq);
	multiplier_32bit mult8(S, N, N);
	multiplier_32bit mult9(P, R, vab_sq);

	subtractor_64bit sub321(carry[7], Q, O, S, 1'b1);
	comparator comp1(trial, Q, P);

endmodule
  