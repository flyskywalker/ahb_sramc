// Name       : sramc_top
// Version    : 1.0
// Date       : 2018-06-16
// Description: toplevel of sramc and ahb, including sram8x8k and ahb_slave_interface
//----------------------------------------------------------------------------------------

module sramc_top(
	ahb_if 	dut_if_tb
);

	sram_if inst_sram_if();

	ahb_slave_interface	inst_ahb(
	.ahb_if_inst(dut_if_tb),
	.sram_if_ahb(inst_sram_if)
	);

	sram8x8k inst_srams(
	.sram_clk(inst_sram_if.sram_clk),
	.sram_if_sram(inst_sram_if)
	);

endmodule