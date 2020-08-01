module Mux2to1_7bit (inp0, inp1, sel, out);
input [6:0] inp0;
input [6:0] inp1;
input sel;
output [6:0] out;

	assign out = (sel == 1'b0)? inp0: 
			(sel == 1'b1)? inp1:
			5'bz;
endmodule