// Name       : sramc_wrapper
// Version    : 1.0
// Date       : 2018-06-20
// Description: wrapper the DUT for test
//----------------------------------------------------------------------------------------

module sramc_wrapper;
	ahb_if 	wrapper_ahb();

sramc_top inst_sramc_top(
	.dut_if_tb(wrapper_ahb)
);

endmodule