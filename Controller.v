module Controller(Opc, func, equalR, ID_EX_Rs, ID_EX_Rt, EX_MEM_RegWrite, EX_MEM_Rd, MEM_WB_RegWrite,
	MEM_WB_Rd,Rs, Rt, ID_EX_MemRead, InstSrc, PCSrc, PCWrite, IF_ID_Write, IF_Flush, ChSel,
	ForwardA, ForwardB, ALUSrc, ALUOperation, RegDst, MemWrite, MemRead, MemToReg, RegWrite);
input [5:0]Opc;
input [5:0]func;
input equalR;
input [4:0]ID_EX_Rs;
input [4:0]ID_EX_Rt;
input EX_MEM_RegWrite;
input [4:0]EX_MEM_Rd;
input MEM_WB_RegWrite;
input [4:0]MEM_WB_Rd;
input [4:0]Rs;
input [4:0]Rt;
input ID_EX_MemRead;
output InstSrc;
output PCSrc;
output PCWrite;
output IF_ID_Write;
output IF_Flush;
output ChSel;
output [1:0]ForwardA;
output [1:0]ForwardB;
output ALUSrc;
output [2:0]ALUOperation;
output RegDst;
output MemWrite;
output MemRead;
output MemToReg;
output RegWrite;

	wire RT,addi,andi,lw,sw,beq,bne,j,nop;
	OpcDCD OD(
		.Opc(Opc),
		.RT(RT),
		.addi(addi),
		.andi(andi),
		.lw(lw),
		.sw(sw),
		.beq(beq),
		.bne(bne),
		.j(j),
		.nop(nop)
	);

	wire [1:0]ALUOp;
	ControlSignalGen CSG(
		.RT(RT),
		.addi(addi),
		.andi(andi),
		.lw(lw),
		.sw(sw),
		.beq(beq),
		.bne(bne),
		.j(j),
		.nop(nop),
		.InstSrc(InstSrc),
		.ALUSrc(ALUSrc),
		.ALUOp(ALUOp),
		.RegDst(RegDst),
		.MemWrite(MemWrite),
		.MemRead(MemRead),
		.MemToReg(MemToReg),
		.RegWrite(RegWrite)
	);

	ALUControl ALUC(
		.func(func),
		.ALUOp(ALUOp),
		.ALUOperation(ALUOperation)
	);

	BranchHandler BH(
		.beq(beq),
		.bne(bne),
		.equalR(equalR),
		.PCSrc(PCSrc),
		.IF_Flush(IF_Flush)
	);

	ForwardingUnit FU(
		.ID_EX_Rs(ID_EX_Rs),
		.ID_EX_Rt(ID_EX_Rt),
		.EX_MEM_RegWrite(EX_MEM_RegWrite),
		.EX_MEM_Rd(EX_MEM_Rd),
		.MEM_WB_RegWrite(MEM_WB_RegWrite),
		.MEM_WB_Rd(MEM_WB_Rd),
		.ForwardA(ForwardA),
		.ForwardB(ForwardB)
	);

	HazardUnit HU(
		.Rs(Rs),
		.Rt(Rt),
		.ID_EX_MemRead(ID_EX_MemRead),
		.ID_EX_Rt(ID_EX_Rt),
		.ChSel(ChSel),
		.PCWrite(PCWrite),
		.IF_ID_Write(IF_ID_Write)
	);

endmodule
