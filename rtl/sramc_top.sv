// Name       : sramc_top
// Version    : 1.0
// Date       : 2018-06-16
// Description: toplevel of sramc and ahb, including sram8x8k and ahb_slave_interface
//----------------------------------------------------------------------------------------

module sramc_top#(
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
	//input signals
	input	hclk,
	input	sram_clk,
	input	hresetn,
	input	[ADDR_WIDTH-1:0]	haddr,
	input	[DATA_WIDTH-1:0]	hwdata,
	input	[HBURST_WIDTH-1:0]	hburst,
	input	[HTRANS_WIDTH-1:0]	htrans,
	input	[HSIZE_WIDTH-1:0]	hsize,
	input	hsel,
	input	hwrite,
	input	hready,

	//output signals
	output	[DATA_WIDTH-1:0]	hrdata,
	output	[HRESP_WIDTH-1:0]	hresp,
	output	hready_resp
);

	sram_if #(
	.SRAM_DATA_WIDTH(SRAM_DATA_WIDTH),
	.SRAM_ADDR_WIDTH(SRAM_ADDR_WIDTH),	
	.DATA_WIDTH(DATA_WIDTH)
	)inst_sram_if();

	ahb_slave_interface	 #(
	.SRAM_DATA_WIDTH(SRAM_DATA_WIDTH),
	.SRAM_ADDR_WIDTH(SRAM_ADDR_WIDTH),
	.ADDR_WIDTH(ADDR_WIDTH),
	.DATA_WIDTH(DATA_WIDTH),
	.HBURST_WIDTH(HBURST_WIDTH),
	.HTRANS_WIDTH(HTRANS_WIDTH),
	.HSIZE_WIDTH(HSIZE_WIDTH),
	.HRESP_WIDTH(HRESP_WIDTH)
	)inst_ahb(
	.hclk(hclk),
	.hresetn(hresetn),
	.haddr(haddr),
	.hwdata(hwdata),
	.hburst(hburst),
	.htrans(htrans),
	.hsize(hsize),
	.hsel(hsel),
	.hwrite(hwrite),
	.hready(hready),
	.hrdata(hrdata),
	.hresp(hresp),
	.hready_resp(hready_resp),
//	.arbports(inst_sram_if.arb_ports)
	.sram_if_ahb(inst_sram_if)
	);

	sram8x8k inst_srams(
	.sram_clk(sram_clk),
//	.sramports(inst_sram_if.sram_ports)
	.sram_if_sram(inst_sram_if)
	);

endmodule