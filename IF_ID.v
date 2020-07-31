module IF_ID(clk, rst, IF_ID_Write, aclr, PCPlusIn, PCPlusOut, InstIn, InstOut);
input clk;
input rst;
input IF_ID_Write;
input aclr;
input [31:0] PCPlusIn;
input [31:0] InstIn;
output [31:0] PCPlusOut;
output [31:0] InstOut;

	assign asyncRst = rst | aclr;

	Reg_32bit PCPlusReg(
		.clk(clk),
		.rst(asyncRst),
		.d(PCPlusIn),
		.en(IF_ID_Write),
		.q(PCPlusOut)
		);

	Reg_32bit InstReg(
		.clk(clk),
		.rst(asyncRst),
		.d(InstIn),
		.en(IF_ID_Write),
		.q(InstOut)
		);

endmodule 
