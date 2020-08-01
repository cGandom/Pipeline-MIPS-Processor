module Datapath(clk, rst, InstSrc, PCSrc, ALUSrc, ALUOperation, RegDst, MemWrite, MemRead, 
		MemToReg, RegWrite, IF_Flush, ForwardA, ForwardB, PCWrite, IF_ID_Write, 
		func, Opc, inst, ID_Rs, ID_Rt, equalR, ID_EX_Rt, ID_EX_Rs, ID_EX_MemRead, 
		EX_MEM_RegWrite, EX_MEM_Rd, MEM_WB_RegWrite, MEM_WB_Rd); 
input clk;
input rst;
input InstSrc;
input PCSrc;
input ALUSrc;
input [2:0] ALUOperation;
input RegDst;
input MemWrite;
input MemRead;
input MemToReg;
input RegWrite;
input IF_Flush;
input [1:0] ForwardA;
input [1:0] ForwardB;
input PCWrite;
input IF_ID_Write;
output [5:0] func;
output [5:0] Opc;
output [31:0] inst;
output [4:0] ID_Rs;
output [4:0] ID_Rt;
output equalR;
output [4:0] ID_EX_Rt;
output [4:0] ID_EX_Rs;
output ID_EX_MemRead;
output EX_MEM_RegWrite;
output [4:0] EX_MEM_Rd;
output MEM_WB_RegWrite;
output [4:0] MEM_WB_Rd;


	/*=====Wires=====*/
	//Stage IF
	wire [31:0] IF_PCPlus, IF_Inst, IF_IM_Addr_inp, IF_PCSrcMux_out;
	wire [31:0] IF_PCOut;
	
	//Stage ID
	wire [31:0] IF_ID_PCPlus, IF_ID_Inst, ID_L_Address, ID_ReadReg1, ID_ReadReg2, ID_SignEx, ID_ShL2out;

	//Stage EX
	wire ID_EX_ALUSrc, ID_EX_RegDst, ID_EX_MemWrite, ID_EX_MemToReg, ID_EX_RegWrite;
	wire [2:0] ID_EX_ALUOperation;
	wire [4:0] ID_EX_Rd, EX_DestinationReg;
	wire [31:0] ID_EX_ReadReg1, ID_EX_ReadReg2, ID_EX_SignEx, EX_ForwardA_out, EX_ForwardB_out, EX_ALUSrcB_out;
	wire [31:0] EX_ALUResult;

	//Stage MEM
	wire EX_MEM_MemWrite, EX_MEM_MemRead, EX_MEM_MemToReg;
	wire [4:0] EX_MEM_DestinationReg;
	wire [31:0] EX_MEM_ALUResult, EX_MEM_WriteData, MEM_ReadData;

	//Stage WB
	wire MEM_WB_MemToReg;
	wire [4:0] MEM_WB_WriteReg;
	wire [31:0] WB_WriteData, MEM_WB_ReadData, MEM_WB_ALUResult;

	/*=====Modules=====*/
	//Stage IF//

	InstructionMemory if_inst_mem(
		.address(IF_IM_Addr_inp),
		.instruction(IF_Inst)
		);
	
	Reg_32bit if_PC(
		.clk(clk),
		.rst(rst),
		.d(IF_PCSrcMux_out),
		.en(PCWrite),
		.q(IF_PCOut)
		);

	Adder_32bit if_adder(
		.A(4), 
		.B(IF_IM_Addr_inp), 
		.Result(IF_PCPlus)
		);

	Mux2to1_32bit if_im_addr_inp_mux(
		.inp0(IF_PCOut),
		.inp1({IF_ID_PCPlus[31:28], IF_ID_Inst[25:0], 2'b00}),
		.sel(InstSrc),
		.out(IF_IM_Addr_inp)
		);

	Mux2to1_32bit if_pc_src_mux(
		.inp0(IF_PCPlus),
		.inp1(ID_L_Address),
		.sel(PCSrc),
		.out(IF_PCSrcMux_out)
		);

	//Interstage IF-ID//
	IF_ID if_id(
		.clk(clk),
		.rst(rst),
		.IF_ID_Write(IF_ID_Write), 
		.aclr(IF_Flush), 
		.PCPlusIn(IF_PCPlus), 
		.PCPlusOut(IF_ID_PCPlus), 
		.InstIn(IF_Inst), 
		.InstOut(IF_ID_Inst)
		);

	//Stage ID

	assign Opc = IF_ID_Inst[31:26];
	assign func = IF_ID_Inst[5:0];
	assign inst = IF_ID_Inst;
	assign ID_Rs = IF_ID_Inst[25:21];
	assign ID_Rt = IF_ID_Inst[20:16];

	RegisterFile register_file(
		.clk(clk),
		.rst(rst),
		.RegWrite(MEM_WB_RegWrite), 
		.ReadReg1(IF_ID_Inst[25:21]), 
		.ReadReg2(IF_ID_Inst[20:16]), 
		.WriteReg(MEM_WB_WriteReg), 
		.WriteData(WB_WriteData), 
		.ReadData1(ID_ReadReg1), 
		.ReadData2(ID_ReadReg2)
		);

	SignEx signex(
		.inp(IF_ID_Inst[15:0]),
		.out(ID_SignEx)
		);

	ShL2_32bit shl2(
		.inp(ID_SignEx),
		.out(ID_ShL2out)
		);

	Adder_32bit id_adder(
		.A(IF_ID_PCPlus),
		.B(ID_ShL2out),
		.Result(ID_L_Address)
		);

	Comparator_32bit id_comparator(
		.A(ID_ReadReg1),
		.B(ID_ReadReg2),
		.equal(equalR)
		);

	//Interstage ID-EX

	ID_EX id_ex(
		.clk(clk), 
		.rst(rst), 
		.ALUSrcIn(ALUSrc), 
		.ALUOperationIn(ALUOperation), 
		.RegDstIn(RegDst), 
		.MemWriteIn(MemWrite), 
		.MemReadIn(MemRead), 
		.MemToRegIn(MemToReg), 
		.RegWriteIn(RegWrite), 
		.ALUSrcOut(ID_EX_ALUSrc), 
		.ALUOperationOut(ID_EX_ALUOperation), 
		.RegDstOut(ID_EX_RegDst), 
		.MemWriteOut(ID_EX_MemWrite), 
		.MemReadOut(ID_EX_MemRead), 
		.MemToRegOut(ID_EX_MemToReg), 
		.RegWriteOut(ID_EX_RegWrite),
		.ReadReg1In(ID_ReadReg1), 
		.ReadReg2In(ID_ReadReg2), 
		.SignExIn(ID_SignEx), 
		.RtIn(IF_ID_Inst[20:16]), 
		.RdIn(IF_ID_Inst[15:11]), 
		.RsIn(IF_ID_Inst[25:21]),
		.ReadReg1Out(ID_EX_ReadReg1), 
		.ReadReg2Out(ID_EX_ReadReg2), 
		.SignExOut(ID_EX_SignEx), 
		.RtOut(ID_EX_Rt), 
		.RdOut(ID_EX_Rd), 
		.RsOut(ID_EX_Rs)
		);

	//Stage EX

	Mux4to1_32bit ex_forward_A_mux(
		.inp0(ID_EX_ReadReg1),
		.inp1(EX_MEM_ALUResult),
		.inp2(WB_WriteData),
		.sel(ForwardA),
		.out(EX_ForwardA_out)
		);

	Mux4to1_32bit ex_forward_B_mux(
		.inp0(ID_EX_ReadReg2),
		.inp1(EX_MEM_ALUResult),
		.inp2(WB_WriteData),
		.sel(ForwardB),
		.out(EX_ForwardB_out)
		);

	Mux2to1_32bit ex_alu_src_B_mux(
		.inp0(EX_ForwardB_out),
		.inp1(ID_EX_SignEx),
		.sel(ID_EX_ALUSrc),
		.out(EX_ALUSrcB_out)
		);

	ALU ex_alu(
		.A(EX_ForwardA_out), 
		.B(EX_ALUSrcB_out), 
		.ALUOperation(ID_EX_ALUOperation), 
		.res(EX_ALUResult)
		);

	Mux2to1_5bit ex_reg_dest_mux(
		.inp0(ID_EX_Rt),
		.inp1(ID_EX_Rd),
		.sel(ID_EX_RegDst),
		.out(EX_DestinationReg)
		);

	//Interstage EX-MEM
	EX_MEM ex_mem(
		.clk(clk), 
		.rst(rst), 
		.MemWriteIn(ID_EX_MemWrite), 
		.MemReadIn(ID_EX_MemRead), 
		.MemToRegIn(ID_EX_MemToReg), 
		.RegWriteIn(ID_EX_RegWrite),
		.MemWriteOut(EX_MEM_MemWrite), 
		.MemReadOut(EX_MEM_MemRead), 
		.MemToRegOut(EX_MEM_MemToReg), 
		.RegWriteOut(EX_MEM_RegWrite),
		.ALUResultIn(EX_ALUResult), 
		.WriteDataIn(EX_ForwardB_out), 
		.DestinationRegIn(EX_DestinationReg), 
		.ALUResultOut(EX_MEM_ALUResult), 
		.WriteDataOut(EX_MEM_WriteData), 
		.DestinationRegOut(EX_MEM_DestinationReg)
		);

	//Stage MEM
	assign EX_MEM_Rd = EX_MEM_DestinationReg;

	DataMemory mem_data_memory(
		.clk(clk), 
		.MemRead(EX_MEM_MemRead), 
		.MemWrite(EX_MEM_MemWrite), 
		.address(EX_MEM_ALUResult), 
		.WriteData(EX_MEM_WriteData), 
		.ReadData(MEM_ReadData)
		);

	//Interstage MEM-WB
	MEM_WB mem_wb(
		.clk(clk), 
		.rst(rst), 
		.MemToRegIn(EX_MEM_MemToReg), 
		.RegWriteIn(EX_MEM_RegWrite),
		.MemToRegOut(MEM_WB_MemToReg), 
		.RegWriteOut(MEM_WB_RegWrite),
		.ReadDataIn(MEM_ReadData), 
		.ALUResultIn(EX_MEM_ALUResult), 
		.DestinationRegIn(EX_MEM_DestinationReg),
		.ReadDataOut(MEM_WB_ReadData), 
		.ALUResultOut(MEM_WB_ALUResult), 
		.DestinationRegOut(MEM_WB_WriteReg)
		);

	//Stage WB
	Mux2to1_32bit wb_mem_to_reg_mux(
		.inp0(MEM_WB_ALUResult),
		.inp1(MEM_WB_ReadData),
		.sel(MEM_WB_MemToReg),
		.out(WB_WriteData)
		);
	
	assign MEM_WB_Rd = MEM_WB_WriteReg;
endmodule 
