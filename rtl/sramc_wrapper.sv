// Name       : sramc_top
// Version    : 1.0
// Date       : 2018-06-16
// Description: toplevel of sramc and ahb, including sram8x8k and ahb_slave_interface
//----------------------------------------------------------------------------------------

module sramc_wrapper;
	ahb_if 	wrapper_ahb();

sramc_top inst_sramc_top(
	.dut_if_tb(wrapper_ahb)
);

endmodule