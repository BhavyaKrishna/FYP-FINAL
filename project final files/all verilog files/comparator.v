module comparator(O, A, B);   
   input [63:0] 	A;   
   input [63:0] 	B;      
   output		O;
   wire [63:0]		Bnot,S;
   wire			Cout;
 
   xor(Bnot[0], B[0], 1'b1);
   xor(Bnot[1], B[1], 1'b1);
   xor(Bnot[2], B[2], 1'b1);
   xor(Bnot[3], B[3], 1'b1);
   xor(Bnot[4], B[4], 1'b1);
   xor(Bnot[5], B[5], 1'b1);
   xor(Bnot[6], B[6], 1'b1);
   xor(Bnot[7], B[7], 1'b1);
   xor(Bnot[8], B[8], 1'b1);
   xor(Bnot[9], B[9], 1'b1);
   xor(Bnot[10], B[10], 1'b1);
   xor(Bnot[11], B[11], 1'b1);
   xor(Bnot[12], B[12], 1'b1);
   xor(Bnot[13], B[13], 1'b1);
   xor(Bnot[14], B[14], 1'b1);
   xor(Bnot[15], B[15], 1'b1);
   xor(Bnot[16], B[16], 1'b1);
   xor(Bnot[17], B[17], 1'b1);
   xor(Bnot[18], B[18], 1'b1);
   xor(Bnot[19], B[19], 1'b1);
   xor(Bnot[20], B[20], 1'b1);
   xor(Bnot[21], B[21], 1'b1);
   xor(Bnot[22], B[22], 1'b1);
   xor(Bnot[23], B[23], 1'b1);
   xor(Bnot[24], B[24], 1'b1);
   xor(Bnot[25], B[25], 1'b1);
   xor(Bnot[26], B[26], 1'b1);
   xor(Bnot[27], B[27], 1'b1);
   xor(Bnot[28], B[28], 1'b1);
   xor(Bnot[29], B[29], 1'b1);
   xor(Bnot[30], B[30], 1'b1);
   xor(Bnot[31], B[31], 1'b1);
   xor(Bnot[32], B[32], 1'b1);
   xor(Bnot[33], B[33], 1'b1);
   xor(Bnot[34], B[34], 1'b1);
   xor(Bnot[35], B[35], 1'b1);
   xor(Bnot[36], B[36], 1'b1);
   xor(Bnot[37], B[37], 1'b1);
   xor(Bnot[38], B[38], 1'b1);
   xor(Bnot[39], B[39], 1'b1);
   xor(Bnot[40], B[40], 1'b1);
   xor(Bnot[41], B[41], 1'b1);
   xor(Bnot[42], B[42], 1'b1);
   xor(Bnot[43], B[43], 1'b1);
   xor(Bnot[44], B[44], 1'b1);
   xor(Bnot[45], B[45], 1'b1);
   xor(Bnot[46], B[46], 1'b1);
   xor(Bnot[47], B[47], 1'b1);
   xor(Bnot[48], B[48], 1'b1);
   xor(Bnot[49], B[49], 1'b1);
   xor(Bnot[50], B[50], 1'b1);
   xor(Bnot[51], B[51], 1'b1);
   xor(Bnot[52], B[52], 1'b1);
   xor(Bnot[53], B[53], 1'b1);
   xor(Bnot[54], B[54], 1'b1);
   xor(Bnot[55], B[55], 1'b1);
   xor(Bnot[56], B[56], 1'b1);
   xor(Bnot[57], B[57], 1'b1);
   xor(Bnot[58], B[58], 1'b1);
   xor(Bnot[59], B[59], 1'b1);
   xor(Bnot[60], B[60], 1'b1);
   xor(Bnot[61], B[61], 1'b1);
   xor(Bnot[62], B[62], 1'b1);
   xor(Bnot[63], B[63], 1'b1); 
   
   adder_64bit adder64c(Cout, S, A, Bnot, 1'b1);

   assign O= Cout?1'b1:1'b0;
	

endmodule 


