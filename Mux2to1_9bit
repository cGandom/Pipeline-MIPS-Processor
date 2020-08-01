module Mux2to1_9bit (inp0, inp1, sel, out);
input [8:0] inp0;
input [8:0] inp1;
input sel;
output [8:0] out;

	assign out = (sel == 1'b0)? inp0: 
			(sel == 1'b1)? inp1:
			9'bz;
endmodule
