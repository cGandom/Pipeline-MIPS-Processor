module BranchHandler(beq,bne,equalR,PCSrc,IF_Flush);
input beq;
input bne;
input equalR;
output PCSrc;
output IF_Flush;
	assign PCSrc = (beq & equalR) | (bne & ~equalR);
	assign IF_Flush = PCSrc;
endmodule