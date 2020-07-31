module ID_EX(clk, rst, ALUSrcIn, ALUOperationIn, RegDstIn, MemWriteIn, MemReadIn, MemToRegIn, RegWriteIn, 
		ALUSrcOut, ALUOperationOut, RegDstOut, MemWriteOut, MemReadOut, MemToRegOut, RegWriteOut,
		ReadReg1In, ReadReg2In, SignExIn, RtIn, RdIn, RsIn,
		ReadReg1Out, ReadReg2Out, SignExOut, RtOut, RdOut, RsOut);
input clk;
input rst;
input ALUSrcIn;
input [2:0] ALUOperationIn;
input RegDstIn;
input MemWriteIn;
input MemReadIn;
input MemToRegIn;
input RegWriteIn;
output ALUSrcOut;
output [2:0] ALUOperationOut;
output RegDstOut;
output MemWriteOut;
output MemReadOut;
output MemToRegOut;
output RegWriteOut;
input [31:0] ReadReg1In;
input [31:0] ReadReg2In;
input [31:0] SignExIn;
input [4:0] RtIn;
input [4:0] RdIn;
input [4:0] RsIn;
output [31:0] ReadReg1Out; 
output [31:0] ReadReg2Out;
output [31:0] SignExOut;  
output [4:0] RtOut;
output [4:0] RdOut;
output [4:0] RsOut;

	Reg_1bit ALUSrcReg(
		.clk(clk),
		.rst(rst),
		.d(ALUSrcIn),
		.en(1'b1),
		.q(ALUSrcOut)
		);

	Reg_3bit ALUOperationReg(
		.clk(clk),
		.rst(rst),
		.d(ALUOperationIn),
		.en(1'b1),
		.q(ALUOperationOut)
		);

	Reg_1bit RegDstReg(
		.clk(clk),
		.rst(rst),
		.d(RegDstIn),
		.en(1'b1),
		.q(RegDstOut)
		);

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

	Reg_32bit ReadReg1Reg(
		.clk(clk),
		.rst(rst),
		.d(ReadReg1In),
		.en(1'b1),
		.q(ReadReg1Out)
		);

	Reg_32bit ReadReg2Reg(
		.clk(clk),
		.rst(rst),
		.d(ReadReg2In),
		.en(1'b1),
		.q(ReadReg2Out)
		);

	Reg_32bit SignExReg(
		.clk(clk),
		.rst(rst),
		.d(SignExIn),
		.en(1'b1),
		.q(SignExOut)
		);

	Reg_5bit RtReg(
		.clk(clk),
		.rst(rst),
		.d(RtIn),
		.en(1'b1),
		.q(RtOut)
		);

	Reg_5bit RdReg(
		.clk(clk),
		.rst(rst),
		.d(RdIn),
		.en(1'b1),
		.q(RdOut)
		);

	Reg_5bit RsReg(
		.clk(clk),
		.rst(rst),
		.d(RsIn),
		.en(1'b1),
		.q(RsOut)
		);

endmodule 
