module Adder_32bit(A, B, co, Result);
input [31:0] A;
input [31:0] B;
input co;
output [31:0] Result;

	assign {co, Result} = A + B;

endmodule 