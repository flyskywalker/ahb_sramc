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
	ahb_if 	dut_if_tb,
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
	.ahb_if_inst(dut_if_tb),
	.sram_if_ahb(inst_sram_if)
	);

	sram8x8k inst_srams(
	.sram_clk(sram_clk),
	.sram_if_sram(inst_sram_if)
	);

endmodule