// Name       : ahb_interface
// Version    : 1.0
// Date       : 2018-06-20
// Description: ahb signals interface
//----------------------------------------------------------------------------------------
interface ahb_if#(
	parameter
	SRAM_DATA_WIDTH = 8,
	SRAM_ADDR_WIDTH = 13,
	ADDR_WIDTH = 32,
	DATA_WIDTH = 32,
	HBURST_WIDTH = 3,
	HTRANS_WIDTH = 2,
	HSIZE_WIDTH = 3,
	HRESP_WIDTH =2
)(
	//Global signals
	input hclk,
	input hresetn);

	//Master logic signals
	logic	[ADDR_WIDTH-1:0]	haddr;
	logic	[DATA_WIDTH-1:0]	hwdata;
	logic	[HBURST_WIDTH-1:0]	hburst;
	logic	[HTRANS_WIDTH-1:0]	htrans;
	logic	[HSIZE_WIDTH-1:0]	hsize;

	//Decoder and Mux logic signals
	logic	hsel;
	logic	hwrite;
	logic	hready;

	//logic signals
	logic	[DATA_WIDTH-1:0]	hrdata;
	logic	[HRESP_WIDTH-1:0]	hresp;
	logic	hready_resp;

	logic	sram_clk;

	parameter period=20;

	initial begin
		sram_clk = 0;
		forever
			begin
				#(period/2) sram_clk = ~sram_clk;
			end
	end
endinterface