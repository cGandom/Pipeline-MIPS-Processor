module DataMemory (clk, MemRead, MemWrite, address, WriteData, ReadData);
input clk;
input MemRead;
input MemWrite;
input [31:0] address;
input signed [31:0] WriteData;
output signed [31:0] ReadData;

	reg signed [31:0] DataMem [0:8192]; //64 KB - 8 KW

	assign ReadData = MemRead? DataMem[address[31:2]]: 32'bz;
	
	always @(posedge clk) begin
		if (MemWrite) begin
			DataMem[address[31:2]] <=  WriteData;
			$display("DataMemory write => Stored data %d in address %d ", WriteData, address);	
		end
	end

	initial begin 
		$readmemb("Mem.data", DataMem, 250);
	end
endmodule 
