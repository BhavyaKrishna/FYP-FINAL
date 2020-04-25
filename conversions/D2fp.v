module D2fp(input a);
    reg [11:0]bin;
    wire [4:0]a;
    real b;
    always
    begin
        #200;
        bin=b*(2**a);
    end 
endmodule