module ForwardingUnit(ID_EX_Rs,ID_EX_Rt,EX_MEM_RegWrite,EX_MEM_Rd,MEM_WB_RegWrite,MEM_WB_Rd,ForwardA,ForwardB);
input [4:0]ID_EX_Rs;
input [4:0]ID_EX_Rt;
input EX_MEM_RegWrite;
input [4:0]EX_MEM_Rd;
input MEM_WB_RegWrite;
input [4:0]MEM_WB_Rd;
output [1:0]ForwardA;
output [1:0]ForwardB;
	assign ForwardA = (EX_MEM_RegWrite & (EX_MEM_Rd == ID_EX_Rs) & EX_MEM_Rd!=5'b0) ? 2'b01 
		: (MEM_WB_RegWrite & (MEM_WB_Rd == ID_EX_Rs) & MEM_WB_Rd!=5'b0) ? 2'b10 
		: 2'b00;
	assign ForwardB = (EX_MEM_RegWrite & (EX_MEM_Rd == ID_EX_Rt) & EX_MEM_Rd!=5'b0) ? 2'b01 
		: (MEM_WB_RegWrite & (MEM_WB_Rd == ID_EX_Rt) & MEM_WB_Rd!=5'b0) ? 2'b10 
		: 2'b00;
endmodule