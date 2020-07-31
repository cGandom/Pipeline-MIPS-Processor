module EX_MEM(clk, rst, MemWriteIn, MemReadIn, MemToRegIn, RegWriteIn,
		MemWriteOut, MemReadOut, MemToRegOut, RegWriteOut,
		ZeroIn, ALUResultIn, WriteDataIn, DestinationRegIn, 
		ZeroOut, ALUResultOut, WriteDataOut, DestinationRegOut);
input clk;
input rst;
input MemWriteIn;
input MemReadIn;
input MemToRegIn;
input RegWriteIn;
output MemWriteOut;
output MemReadOut;
output MemToRegOut;
output RegWriteOut;
input ZeroIn;
input [31:0] ALUResultIn;
input [31:0] WriteDataIn;
input [4:0] DestinationRegIn;
output ZeroOut;
output [31:0] ALUResultOut;
output [31:0] WriteDataOut;
output [4:0] DestinationRegOut;

	Reg_1bit MemWriteReg(
		.clk(clk),
		.rst(rst),
		.d(MemWriteIn),
		.en(1'b1),
		.q(MemWriteOut)
		);

	Reg_1bit MemReadReg(
		.clk(clk),
		.rst(rst),
		.d(MemReadIn),
		.en(1'b1),
		.q(MemReadOut)
		);

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

	Reg_1bit ZeroReg(
		.clk(clk),
		.rst(rst),
		.d(ZeroIn),
		.en(1'b1),
		.q(ZeroOut)
		);

	Reg_32bit ALUResultReg(
		.clk(clk),
		.rst(rst),
		.d(ALUResultIn),
		.en(1'b1),
		.q(ALUResultOut)
		);

	Reg_32bit WriteDataReg(
		.clk(clk),
		.rst(rst),
		.d(WriteDataIn),
		.en(1'b1),
		.q(WriteDataOut)
		);

	Reg_5bit DestinationRegReg(
		.clk(clk),
		.rst(rst),
		.d(DestinationRegIn),
		.en(1'b1),
		.q(DestinationRegOut)
		);

endmodule 