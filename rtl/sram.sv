// Name       : sram
// Version    : 1.0
// Date       : 2018-06-16
// Description: singal port 8k 8-bit sram with parameters
//----------------------------------------------------------------------------------------
module sram #(
	parameter
	SRAM_DATA_WIDTH=8,
	MEM_DEPTH=8192,
	SRAM_ADDR_WIDTH=13
)
(
	//input signals
	input             clk,
	input      [SRAM_ADDR_WIDTH-1:0] addr,
	input      [SRAM_DATA_WIDTH-1:0] data_in,
	input             ce, //chip enable, active high
	input             we, //write enable, active high
	
	//output signals
	output logic [SRAM_DATA_WIDTH-1:0] data_out
);

	logic [7:0] mem[MEM_DEPTH-1:0];

	always @(posedge clk) begin
		if(ce) begin
			if(we) 
				mem[addr] <= data_in;	
			else
				data_out <= mem[addr];
		end
	end

endmodule