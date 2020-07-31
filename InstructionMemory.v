module InstructionMemory (address, instruction);
input [31:0] address;
output [31:0] instruction;

	reg [31:0] InstMem [0:8192]; //64 KB - 8KW

	assign instruction = InstMem[address[31:2]];	

	initial begin
		$readmemb("Mem.inst", InstMem);
	end

endmodule
