module Reg_5bit(clk, rst, d, en, q);
input clk;
input rst;
input [4:0] d;
input en;
output reg [4:0] q;
	
	always @(posedge clk or posedge rst) begin
		if (rst) q <= 5'b0;
		else if (en) q <= d;
	end

endmodule 
