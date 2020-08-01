module HazardUnit(Rs,Rt,ID_EX_MemRead,ID_EX_Rt,ChSel,PCWrite,IF_ID_Write);
input [4:0]Rs;
input [4:0]Rt;
input ID_EX_MemRead;
input [4:0]ID_EX_Rt;
output ChSel;
output PCWrite;
output IF_ID_Write;
	assign ChSel = ~(ID_EX_MemRead & ((ID_EX_Rt == Rs) | (ID_EX_Rt == Rt)) & ID_EX_Rt!=5'b0);
	assign PCWrite = ChSel;
	assign IF_ID_Write = ChSel;
endmodule