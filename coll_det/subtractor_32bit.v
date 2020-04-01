module subtractor_32bit(Cout, S, A, B, Cin);
   output [31:0] S;
   output 	Cout;
   input [31:0] A;
   input [31:0] B;
   input 	Cin;

   wire 	Ca0; 
   wire		Ca1;
   wire [1:0] carry;
   
   xor(Ca0, carry[0], 1'b1);
   xor(Ca1, carry[1], 1'b1);
   xor(Cout, Ca1, 1'b1);

   subtractor_16bit subt0(carry[0], S[15:0], A[15:0], B[15:0], Cin);
   subtractor_16bit subt1(carry[1], S[31:16], A[31:16], B[31:16], Ca0);

endmodule
