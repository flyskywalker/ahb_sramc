// Name       : sram_interface
// Version    : 1.0
// Date       : 2018-06-20
// Description: interface between arb and srams
//----------------------------------------------------------------------------------------

interface sram_if#(
	parameter
	SRAM_DATA_WIDTH = 8,
	SRAM_ADDR_WIDTH = 13,
	DATA_WIDTH = 32
)();

	logic sram_we;
	logic [SRAM_ADDR_WIDTH-1:0] sram_addr;
	logic [DATA_WIDTH-1:0] sram_wdata;
	logic [3:0] bank0_cs;
	logic [3:0] bank1_cs;

	logic [SRAM_DATA_WIDTH-1:0] sram_b0;
	logic [SRAM_DATA_WIDTH-1:0] sram_b1;
	logic [SRAM_DATA_WIDTH-1:0] sram_b2;
	logic [SRAM_DATA_WIDTH-1:0] sram_b3;
	logic [SRAM_DATA_WIDTH-1:0] sram_b4;
	logic [SRAM_DATA_WIDTH-1:0] sram_b5;
	logic [SRAM_DATA_WIDTH-1:0] sram_b6;
	logic [SRAM_DATA_WIDTH-1:0] sram_b7;

endinterface