module Pipeline_MIPS();

	wire [5:0]Opc;
	wire [5:0]func;
	wire equalR;
	wire [4:0]ID_EX_Rs;
	wire [4:0]ID_EX_Rt;
	wire EX_MEM_RegWrite;
	wire [4:0]EX_MEM_Rd;
	wire MEM_WB_RegWrite;
	wire[4:0]MEM_WB_Rd;
	wire [4:0]Rs;
	wire [4:0]Rt;
	wire ID_EX_MemRead;
	wire InstSrc;
	wire PCSrc;
	wire PCWrite;
	wire IF_ID_Write;
	wire IF_Flush;
	wire ChSel;
	wire [1:0]ForwardA;
	wire[1:0]ForwardB;
	wire ALUSrc;
	wire [2:0]ALUOperation;
	wire RegDst;
	wire MemWrite;
	wire MemRead;
	wire MemToReg;
	wire RegWrite;

	Datapath DP(
		.Opc(Opc),
		.func(func),
		.equalR(equalR),
		.ID_EX_Rs(ID_EX_Rs),
		.ID_EX_Rt(ID_EX_Rt),
		.EX_MEM_RegWrite(EX_MEM_RegWrite),
		.EX_MEM_Rd(EX_MEM_Rd),
		.MEM_WB_RegWrite(MEM_WB_RegWrite),
		.MEM_WB_Rd(MEM_WB_Rd),
		.Rs(Rs),
		.Rt(Rt),
		.ID_EX_MemRead(ID_EX_MemRead),
		.InstSrc(InstSrc),
		.PCSrc(PCSrc),
		.PCWrite(PCWrite),
		.IF_ID_Write(IF_ID_Write),
		.IF_Flush(IF_Flush),
		.ChSel(ChSel),
		.ForwardA(ForwardA),
		.ForwardB(ForwardB),
		.ALUSrc(ALUSrc),
		.ALUOperation(ALUOperation),
		.RegDst(RegDst),
		.MemWrite(MemWrite),
		.MemRead(MemRead),
		.MemToReg(MemToReg),
		.RegWrite(RegWrite)
	);
	
	Controller C(
		.Opc(Opc),
		.func(func),
		.equalR(equalR),
		.ID_EX_Rs(ID_EX_Rs),
		.ID_EX_Rt(ID_EX_Rt),
		.EX_MEM_RegWrite(EX_MEM_RegWrite),
		.EX_MEM_Rd(EX_MEM_Rd),
		.MEM_WB_RegWrite(MEM_WB_RegWrite),
		.MEM_WB_Rd(MEM_WB_Rd),
		.Rs(Rs),
		.Rt(Rt),
		.ID_EX_MemRead(ID_EX_MemRead),
		.InstSrc(InstSrc),
		.PCSrc(PCSrc),
		.PCWrite(PCWrite),
		.IF_ID_Write(IF_ID_Write),
		.IF_Flush(IF_Flush),
		.ChSel(ChSel),
		.ForwardA(ForwardA),
		.ForwardB(ForwardB),
		.ALUSrc(ALUSrc),
		.ALUOperation(ALUOperation),
		.RegDst(RegDst),
		.MemWrite(MemWrite),
		.MemRead(MemRead),
		.MemToReg(MemToReg),
		.RegWrite(RegWrite)
	);

endmodule