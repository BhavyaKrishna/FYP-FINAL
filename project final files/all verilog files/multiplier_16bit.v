module multiplier_16bit(P, A, B);
    input [15:0]	A;
    input [15:0]	B;
    output [31:0]	P;

    wire [15:0]	w0,w1,w3,w4,w6,w7,w9,w10,w12,w13,w15,w16,w18,w19,w21,w22,w24,w25,w27,w28,w30,w31,w33,w34,w36,w37,w39,w40,w42,w43;
    wire [16:0]	w2,w5,w8,w11,w14,w17,w20,w23,w26,w29,w32,w35,w38,w41;

and(P[0],A[0],B[0]);
and(w0[0],A[1],B[0]);
and(w0[1],A[2],B[0]);
and(w0[2],A[3],B[0]);
and(w0[3],A[4],B[0]);
and(w0[4],A[5],B[0]);
and(w0[5],A[6],B[0]);
and(w0[6],A[7],B[0]);
and(w0[7],A[8],B[0]);
and(w0[8],A[9],B[0]);
and(w0[9],A[10],B[0]);
and(w0[10],A[11],B[0]);
and(w0[11],A[12],B[0]);
and(w0[12],A[13],B[0]);
and(w0[13],A[14],B[0]);
and(w0[14],A[15],B[0]);
and(w0[15],1'b0,1'b0);

and(w1[0],A[0],B[1]);
and(w1[1],A[1],B[1]);
and(w1[2],A[2],B[1]);
and(w1[3],A[3],B[1]);
and(w1[4],A[4],B[1]);
and(w1[5],A[5],B[1]);
and(w1[6],A[6],B[1]);
and(w1[7],A[7],B[1]);
and(w1[8],A[8],B[1]);
and(w1[9],A[9],B[1]);
and(w1[10],A[10],B[1]);
and(w1[11],A[11],B[1]);
and(w1[12],A[12],B[1]);
and(w1[13],A[13],B[1]);
and(w1[14],A[14],B[1]);
and(w1[15],A[15],B[1]);

and(w3[0],A[0],B[2]);
and(w3[1],A[1],B[2]);
and(w3[2],A[2],B[2]);
and(w3[3],A[3],B[2]);
and(w3[4],A[4],B[2]);
and(w3[5],A[5],B[2]);
and(w3[6],A[6],B[2]);
and(w3[7],A[7],B[2]);
and(w3[8],A[8],B[2]);
and(w3[9],A[9],B[2]);
and(w3[10],A[10],B[2]);
and(w3[11],A[11],B[2]);
and(w3[12],A[12],B[2]);
and(w3[13],A[13],B[2]);
and(w3[14],A[14],B[2]);
and(w3[15],A[15],B[2]);


and(w6[0],A[0],B[3]);
and(w6[1],A[1],B[3]);
and(w6[2],A[2],B[3]);
and(w6[3],A[3],B[3]);
and(w6[4],A[4],B[3]);
and(w6[5],A[5],B[3]);
and(w6[6],A[6],B[3]);
and(w6[7],A[7],B[3]);
and(w6[8],A[8],B[3]);
and(w6[9],A[9],B[3]);
and(w6[10],A[10],B[3]);
and(w6[11],A[11],B[3]);
and(w6[12],A[12],B[3]);
and(w6[13],A[13],B[3]);
and(w6[14],A[14],B[3]);
and(w6[15],A[15],B[3]);

and(w9[0],A[0],B[4]);
and(w9[1],A[1],B[4]);
and(w9[2],A[2],B[4]);
and(w9[3],A[3],B[4]);
and(w9[4],A[4],B[4]);
and(w9[5],A[5],B[4]);
and(w9[6],A[6],B[4]);
and(w9[7],A[7],B[4]);
and(w9[8],A[8],B[4]);
and(w9[9],A[9],B[4]);
and(w9[10],A[10],B[4]);
and(w9[11],A[11],B[4]);
and(w9[12],A[12],B[4]);
and(w9[13],A[13],B[4]);
and(w9[14],A[14],B[4]);
and(w9[15],A[15],B[4]);

and(w12[0],A[0],B[5]);
and(w12[1],A[1],B[5]);
and(w12[2],A[2],B[5]);
and(w12[3],A[3],B[5]);
and(w12[4],A[4],B[5]);
and(w12[5],A[5],B[5]);
and(w12[6],A[6],B[5]);
and(w12[7],A[7],B[5]);
and(w12[8],A[8],B[5]);
and(w12[9],A[9],B[5]);
and(w12[10],A[10],B[5]);
and(w12[11],A[11],B[5]);
and(w12[12],A[12],B[5]);
and(w12[13],A[13],B[5]);
and(w12[14],A[14],B[5]);
and(w12[15],A[15],B[5]);

and(w15[0],A[0],B[6]);
and(w15[1],A[1],B[6]);
and(w15[2],A[2],B[6]);
and(w15[3],A[3],B[6]);
and(w15[4],A[4],B[6]);
and(w15[5],A[5],B[6]);
and(w15[6],A[6],B[6]);
and(w15[7],A[7],B[6]);
and(w15[8],A[8],B[6]);
and(w15[9],A[9],B[6]);
and(w15[10],A[10],B[6]);
and(w15[11],A[11],B[6]);
and(w15[12],A[12],B[6]);
and(w15[13],A[13],B[6]);
and(w15[14],A[14],B[6]);
and(w15[15],A[15],B[6]);

and(w18[0],A[0],B[7]);
and(w18[1],A[1],B[7]);
and(w18[2],A[2],B[7]);
and(w18[3],A[3],B[7]);
and(w18[4],A[4],B[7]);
and(w18[5],A[5],B[7]);
and(w18[6],A[6],B[7]);
and(w18[7],A[7],B[7]);
and(w18[8],A[8],B[7]);
and(w18[9],A[9],B[7]);
and(w18[10],A[10],B[7]);
and(w18[11],A[11],B[7]);
and(w18[12],A[12],B[7]);
and(w18[13],A[13],B[7]);
and(w18[14],A[14],B[7]);
and(w18[15],A[15],B[7]);

and(w21[0],A[0],B[8]);
and(w21[1],A[1],B[8]);
and(w21[2],A[2],B[8]);
and(w21[3],A[3],B[8]);
and(w21[4],A[4],B[8]);
and(w21[5],A[5],B[8]);
and(w21[6],A[6],B[8]);
and(w21[7],A[7],B[8]);
and(w21[8],A[8],B[8]);
and(w21[9],A[9],B[8]);
and(w21[10],A[10],B[8]);
and(w21[11],A[11],B[8]);
and(w21[12],A[12],B[8]);
and(w21[13],A[13],B[8]);
and(w21[14],A[14],B[8]);
and(w21[15],A[15],B[8]);

and(w24[0],A[0],B[9]);
and(w24[1],A[1],B[9]);
and(w24[2],A[2],B[9]);
and(w24[3],A[3],B[9]);
and(w24[4],A[4],B[9]);
and(w24[5],A[5],B[9]);
and(w24[6],A[6],B[9]);
and(w24[7],A[7],B[9]);
and(w24[8],A[8],B[9]);
and(w24[9],A[9],B[9]);
and(w24[10],A[10],B[9]);
and(w24[11],A[11],B[9]);
and(w24[12],A[12],B[9]);
and(w24[13],A[13],B[9]);
and(w24[14],A[14],B[9]);
and(w24[15],A[15],B[9]);

and(w27[0],A[0],B[10]);
and(w27[1],A[1],B[10]);
and(w27[2],A[2],B[10]);
and(w27[3],A[3],B[10]);
and(w27[4],A[4],B[10]);
and(w27[5],A[5],B[10]);
and(w27[6],A[6],B[10]);
and(w27[7],A[7],B[10]);
and(w27[8],A[8],B[10]);
and(w27[9],A[9],B[10]);
and(w27[10],A[10],B[10]);
and(w27[11],A[11],B[10]);
and(w27[12],A[12],B[10]);
and(w27[13],A[13],B[10]);
and(w27[14],A[14],B[10]);
and(w27[15],A[15],B[10]);

and(w30[0],A[0],B[11]);
and(w30[1],A[1],B[11]);
and(w30[2],A[2],B[11]);
and(w30[3],A[3],B[11]);
and(w30[4],A[4],B[11]);
and(w30[5],A[5],B[11]);
and(w30[6],A[6],B[11]);
and(w30[7],A[7],B[11]);
and(w30[8],A[8],B[11]);
and(w30[9],A[9],B[11]);
and(w30[10],A[10],B[11]);
and(w30[11],A[11],B[11]);
and(w30[12],A[12],B[11]);
and(w30[13],A[13],B[11]);
and(w30[14],A[14],B[11]);
and(w30[15],A[15],B[11]);

and(w33[0],A[0],B[12]);
and(w33[1],A[1],B[12]);
and(w33[2],A[2],B[12]);
and(w33[3],A[3],B[12]);
and(w33[4],A[4],B[12]);
and(w33[5],A[5],B[12]);
and(w33[6],A[6],B[12]);
and(w33[7],A[7],B[12]);
and(w33[8],A[8],B[12]);
and(w33[9],A[9],B[12]);
and(w33[10],A[10],B[12]);
and(w33[11],A[11],B[12]);
and(w33[12],A[12],B[12]);
and(w33[13],A[13],B[12]);
and(w33[14],A[14],B[12]);
and(w33[15],A[15],B[12]);

and(w36[0],A[0],B[13]);
and(w36[1],A[1],B[13]);
and(w36[2],A[2],B[13]);
and(w36[3],A[3],B[13]);
and(w36[4],A[4],B[13]);
and(w36[5],A[5],B[13]);
and(w36[6],A[6],B[13]);
and(w36[7],A[7],B[13]);
and(w36[8],A[8],B[13]);
and(w36[9],A[9],B[13]);
and(w36[10],A[10],B[13]);
and(w36[11],A[11],B[13]);
and(w36[12],A[12],B[13]);
and(w36[13],A[13],B[13]);
and(w36[14],A[14],B[13]);
and(w36[15],A[15],B[13]);

and(w39[0],A[0],B[14]);
and(w39[1],A[1],B[14]);
and(w39[2],A[2],B[14]);
and(w39[3],A[3],B[14]);
and(w39[4],A[4],B[14]);
and(w39[5],A[5],B[14]);
and(w39[6],A[6],B[14]);
and(w39[7],A[7],B[14]);
and(w39[8],A[8],B[14]);
and(w39[9],A[9],B[14]);
and(w39[10],A[10],B[14]);
and(w39[11],A[11],B[14]);
and(w39[12],A[12],B[14]);
and(w39[13],A[13],B[14]);
and(w39[14],A[14],B[14]);
and(w39[15],A[15],B[14]);

and(w42[0],A[0],B[15]);
and(w42[1],A[1],B[15]);
and(w42[2],A[2],B[15]);
and(w42[3],A[3],B[15]);
and(w42[4],A[4],B[15]);
and(w42[5],A[5],B[15]);
and(w42[6],A[6],B[15]);
and(w42[7],A[7],B[15]);
and(w42[8],A[8],B[15]);
and(w42[9],A[9],B[15]);
and(w42[10],A[10],B[15]);
and(w42[11],A[11],B[15]);
and(w42[12],A[12],B[15]);
and(w42[13],A[13],B[15]);
and(w42[14],A[14],B[15]);
and(w42[15],A[15],B[15]);




assign P[1]= w2[0];
assign w4[14:0]=w2[15:1];
assign w4[15]=w2[16];

assign P[2]= w5[0];
assign w7[14:0]=w5[15:1];
assign w7[15]=w5[16];

assign P[3]= w8[0];
assign w10[14:0]=w8[15:1];
assign w10[15]=w8[16];

assign P[4]= w11[0];
assign w13[14:0]=w11[15:1];
assign w13[15]=w11[16];

assign P[5]= w14[0];
assign w16[14:0]=w14[15:1];
assign w16[15]=w14[16];

assign P[6]= w17[0];
assign w19[14:0]=w17[15:1];
assign w19[15]=w17[16];

assign P[7]= w20[0];
assign w22[14:0]=w20[15:1];
assign w22[15]=w20[16];

assign P[8]= w23[0];
assign w25[14:0]=w23[15:1];
assign w25[15]=w23[16];

assign P[9]= w26[0];
assign w28[14:0]=w26[15:1];
assign w28[15]=w26[16];

assign P[10]= w29[0];
assign w31[14:0]=w29[15:1];
assign w31[15]=w29[16];

assign P[11]= w32[0];
assign w34[14:0]=w32[15:1];
assign w34[15]=w32[16];

assign P[12]= w35[0];
assign w37[14:0]=w35[15:1];
assign w37[15]=w35[16];

assign P[13]= w38[0];
assign w40[14:0]=w38[15:1];
assign w40[15]=w38[16];

assign P[14]= w41[0];
assign w43[14:0]=w41[15:1];
assign w43[15]=w41[16];


adder_16bit add1(w2[16],w2[15:0],w1,w0,0);
adder_16bit add2(w5[16],w5[15:0],w4,w3,0);
adder_16bit add3(w8[16],w8[15:0],w7,w6,0);
adder_16bit add4(w11[16],w11[15:0],w10,w9,0);
adder_16bit add5(w14[16],w14[15:0],w13,w12,0);
adder_16bit add6(w17[16],w17[15:0],w16,w15,0);
adder_16bit add7(w20[16],w20[15:0],w19,w18,0);
adder_16bit add8(w23[16],w23[15:0],w22,w21,0);
adder_16bit add9(w26[16],w26[15:0],w25,w24,0);
adder_16bit add10(w29[16],w29[15:0],w28,w27,0);
adder_16bit add11(w32[16],w32[15:0],w31,w30,0);
adder_16bit add12(w35[16],w35[15:0],w34,w33,0);
adder_16bit add13(w38[16],w38[15:0],w37,w36,0);
adder_16bit add14(w41[16],w41[15:0],w40,w39,0);
adder_16bit add15(P[31],P[30:15],w43,w42,0);


endmodule
