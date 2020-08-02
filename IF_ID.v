module IF_ID(clk, rst, IF_ID_Write, aclr, PCPlusIn, PCPlusOut, InstIn, InstOut);
input clk;
input rst;
input IF_ID_Write;
input aclr;
input [31:0] PCPlusIn;
input [31:0] InstIn;
output [31:0] PCPlusOut;
output [31:0] InstOut;

	Reg_32bit_WithClear PCPlusReg(
		.clk(clk),
		.rst(rst),
		.clr(1'b0),
		.d(PCPlusIn),
		.en(IF_ID_Write),
		.q(PCPlusOut)
		);

	Reg_32bit_WithClear InstReg(
		.clk(clk),
		.rst(rst),
		.clr(aclr),
		.d(InstIn),
		.en(IF_ID_Write),
		.q(InstOut)
		);

endmodule 
