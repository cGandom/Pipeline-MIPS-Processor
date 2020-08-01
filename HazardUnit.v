module HazardUnit(ID_Rs,ID_Rt,ID_EX_MemRead,ID_EX_Rt,CSSel,PCWrite,IF_ID_Write);
input [4:0]ID_Rs;
input [4:0]ID_Rt;
input ID_EX_MemRead;
input [4:0]ID_EX_Rt;
output CSSel;
output PCWrite;
output IF_ID_Write;
	assign CSSel = ~(ID_EX_MemRead & ((ID_EX_Rt == ID_Rs) | (ID_EX_Rt == ID_Rt)) & ID_EX_Rt!=5'b0);
	assign PCWrite = CSSel;
	assign IF_ID_Write = CSSel;
endmodule
