module Comparator_32bit(A, B, equal);
input [31:0] A;
input [31:0] B;
output equal;

	assign equal = (A == B)? 1'b1: 1'b0;

endmodule 