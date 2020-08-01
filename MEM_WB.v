module MEM_WB(clk, rst, MemToRegIn, RegWriteIn,
		MemToRegOut, RegWriteOut,
		ReadDataIn, ALUResultIn, DestinationRegIn,
		ReadDataOut, ALUResultOut, DestinationRegOut);
input clk;
input rst;
input MemToRegIn;
input RegWriteIn;
output MemToRegOut;
output RegWriteOut;
input [31:0] ReadDataIn;
input [31:0] ALUResultIn;
input [4:0] DestinationRegIn;
output [31:0] ReadDataOut;
output [31:0] ALUResultOut;
output [4:0] DestinationRegOut;

	Reg_1bit MemToRegReg(
		.clk(clk),
		.rst(rst),
		.d(MemToRegIn),
		.en(1'b1),
		.q(MemToRegOut)
		);

	Reg_1bit RegWriteReg(
		.clk(clk),
		.rst(rst),
		.d(RegWriteIn),
		.en(1'b1),
		.q(RegWriteOut)
		);

	Reg_32bit ReadDataReg(
		.clk(clk),
		.rst(rst),
		.d(ReadDataIn),
		.en(1'b1),
		.q(ReadDataOut)
		);

	Reg_32bit ALUResultReg(
		.clk(clk),
		.rst(rst),
		.d(ALUResultOut),
		.en(1'b1),
		.q(ALUResultOut)
		);

	Reg_5bit DestinationRegReg(
		.clk(clk),
		.rst(rst),
		.d(DestinationRegIn),
		.en(1'b1),
		.q(DestinationRegOut)
		);
endmodule
