module ControlSignalGen(RT,addi,andi,lw,sw,j,beq,bne,nop,InstSrc,ALUSrc,ALUOp,RegDst,MemWrite,MemRead,MemToReg,RegWrite);
input RT;
input addi;
input andi;
input lw;
input sw;
input j;
input beq;
input bne;
input nop;
output reg InstSrc;
output reg ALUSrc;
output reg [1:0] ALUOp;
output reg RegDst;
output reg MemWrite;
output reg MemRead;
output reg MemToReg;
output reg RegWrite;

	always@(RT or addi or andi or lw or sw or j or beq or bne or nop) begin
		ALUOp = 2'b00; 
		{InstSrc, ALUSrc, RegDst, MemWrite, MemRead, MemToReg, RegWrite} = 7'b0;
		if (RT) begin
			RegDst = 1'b1; RegWrite = 1'b1;
			ALUOp = 2'b10;
		end
		else if (addi) begin
			{RegWrite, ALUSrc} = 2'b11;
			ALUOp = 2'b00;
		end
		else if (andi) begin
			{RegWrite, ALUSrc} = 2'b11;
			ALUOp = 2'b11;
		end
		else if (lw) begin
			{RegWrite, ALUSrc, MemRead, MemToReg} = 4'b1111;
		end
		else if (sw) begin
			{ALUSrc, MemWrite} = 2'b11;
			ALUOp = 2'b00;
		end
		else if (j) begin
			InstSrc = 1'b1;
		end
		// no change for nop and beq-bne
	end
endmodule
