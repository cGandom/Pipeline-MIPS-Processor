module Reg_32bit_WithClear(clk, rst, clr, d, en, q);
input clk;
input rst;
input clr;
input [31:0] d;
input en;
output reg [31:0] q;
	
	always @(posedge clk or posedge rst or posedge clr) begin
		if (rst|clr) q <= 32'b0;
		else if (en) q <= d;
	end

endmodule 