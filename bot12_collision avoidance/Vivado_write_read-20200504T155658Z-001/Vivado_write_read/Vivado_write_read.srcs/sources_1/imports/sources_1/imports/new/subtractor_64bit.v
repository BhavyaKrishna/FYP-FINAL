module subtractor_64bit(Cout, S, A, B, Cin);
   output [63:0] S;
   output 	Cout;
   input [63:0] A;
   input [63:0] B;
   input 	Cin;

   wire 	Ca0; 
   wire		Ca1;
   wire		Ca2;
   wire		Ca3;
   wire [3:0] carry;
   
   xor(Ca0, carry[0], 1'b1);
   xor(Ca1, carry[1], 1'b1);
   xor(Ca2, carry[2], 1'b1);
   xor(Ca3, carry[3], 1'b1);
   xor(Cout, Ca3, 1'b1);

   subtractor_16bit subtrac0(carry[0], S[15:0], A[15:0], B[15:0], Cin);
   subtractor_16bit subtrac1(carry[1], S[31:16], A[31:16], B[31:16], Ca0);
   subtractor_16bit subtrac2(carry[2], S[47:32], A[47:32], B[47:32], Ca1);
   subtractor_16bit subtrac3(carry[3], S[63:48], A[63:48], B[63:48], Ca2);

endmodule
