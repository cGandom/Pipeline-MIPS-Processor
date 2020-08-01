module Controller(inst, Opc, func, equalR, ID_EX_Rs, ID_EX_Rt, EX_MEM_RegWrite, EX_MEM_Rd,
	MEM_WB_RegWrite, MEM_WB_Rd, ID_Rs, ID_Rt, ID_EX_MemRead, InstSrc, PCSrc,
	PCWrite, IF_ID_Write, IF_Flush, ForwardA, ForwardB, FinalALUSrc, FinalALUOperation,
	FinalRegDst, FinalMemWrite, FinalMemRead, FinalMemToReg, FinalRegWrite);
input [31:0]inst;
input [5:0]Opc;
input [5:0]func;
input equalR;
input [4:0]ID_EX_Rs;
input [4:0]ID_EX_Rt;
input EX_MEM_RegWrite;
input [4:0]EX_MEM_Rd;
input MEM_WB_RegWrite;
input [4:0]MEM_WB_Rd;
input [4:0]ID_Rs;
input [4:0]ID_Rt;
input ID_EX_MemRead;
output InstSrc;
output PCSrc;
output PCWrite;
output IF_ID_Write;
output IF_Flush;
output [1:0]ForwardA;
output [1:0]ForwardB;
output FinalALUSrc;
output [2:0]FinalALUOperation;
output FinalRegDst;
output FinalMemWrite;
output FinalMemRead;
output FinalMemToReg;
output FinalRegWrite;

	wire RT,addi,andi,lw,sw,beq,bne,j,nop;
	OpcDcd OD(
		.Opc(Opc),
		.inst(inst),
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
	wire ALUSrc;
	wire RegDst;
	wire MemWrite;
	wire MemRead;
	wire MemToReg;
	wire RegWrite;
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

	wire [2:0]ALUOperation;
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

	wire CSSel;
	HazardUnit HU(
		.ID_Rs(ID_Rs),
		.ID_Rt(ID_Rt),
		.ID_EX_MemRead(ID_EX_MemRead),
		.ID_EX_Rt(ID_EX_Rt),
		.CSSel(CSSel),
		.PCWrite(PCWrite),
		.IF_ID_Write(IF_ID_Write)
	);

	
	Mux2to1_9bit CSSelMux(
		.inp0(9'b0),
		.inp1({ALUSrc, ALUOperation, RegDst, MemWrite, MemRead, MemToReg, RegWrite}),
		.sel(CSSel),
		.out({FinalALUSrc, FinalALUOperation, FinalRegDst, FinalMemWrite, FinalMemRead, FinalMemToReg, FinalRegWrite})
	);

endmodule
