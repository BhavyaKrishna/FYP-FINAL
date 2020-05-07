module subtractor_16bit(Cout, S, A, B, Cin);
   output [15:0] S;
   output 	Cout;
   input [15:0] A;
   input [15:0] B;
   input 	Cin;

   wire 	Ca0; 
   wire 	Ca1; 
   wire 	Ca2; 
   wire 	Ca3;
   wire [3:0] carry;
   
   xor(Ca0, carry[0], 1'b1);
   xor(Ca1, carry[1], 1'b1);
   xor(Ca2, carry[2], 1'b1);
   xor(Ca3, carry[3], 1'b1);
   xor(Cout, Ca3, 1'b1);

   subtractor_4bit su0(.Cout(carry[0]), .S(S[3:0]), .A(A[3:0]), .B(B[3:0]), .Cin(Cin));
   subtractor_4bit su1(carry[1], S[7:4], A[7:4], B[7:4], Ca0);
   subtractor_4bit su2(carry[2], S[11:8], A[11:8], B[11:8], Ca1);
   subtractor_4bit su3(carry[3], S[15:12], A[15:12], B[15:12], Ca2);

endmodule
