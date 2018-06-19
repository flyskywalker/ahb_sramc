// Name       : sram8x8k
// Version    : 1.0
// Date       : 2018-06-16
// Description: Toplevel of sram from eight 8kbyte sync singal-port srams, including 2 banks. 
//				Each bank contains 4 srams.
//----------------------------------------------------------------------------------------

module sram8x8k (
	input sram_clk, //sramclock
	sram_if sram_if_sram //init all ports between arb and sram8x8k
);
	sram sram_block0(
		.clk		(sram_clk),
		.addr		(sram_if_sram.sram_addr),
		.data_in	(sram_if_sram.sram_wdata[7:0]),
		.ce		(sram_if_sram.bank0_cs[0]),
		.we		(sram_if_sram.sram_we),
		.data_out	(sram_if_sram.sram_b0)
	);

	sram sram_block1(
		.clk		(sram_clk),
		.addr		(sram_if_sram.sram_addr),
		.data_in	(sram_if_sram.sram_wdata[15:8]),
		.ce		(sram_if_sram.bank0_cs[1]),
		.we		(sram_if_sram.sram_we),
		.data_out	(sram_if_sram.sram_b1)
	);

	sram sram_block2(
		.clk		(sram_clk),
		.addr		(sram_if_sram.sram_addr),
		.data_in	(sram_if_sram.sram_wdata[23:16]),
		.ce		(sram_if_sram.bank0_cs[2]),
		.we		(sram_if_sram.sram_we),
		.data_out	(sram_if_sram.sram_b2)
	);

	sram sram_block3(
		.clk		(sram_clk),
		.addr		(sram_if_sram.sram_addr),
		.data_in	(sram_if_sram.sram_wdata[31:24]),
		.ce		(sram_if_sram.bank0_cs[3]),
		.we		(sram_if_sram.sram_we),
		.data_out	(sram_if_sram.sram_b3)
	);

	sram sram_block4(
		.clk		(sram_clk),
		.addr		(sram_if_sram.sram_addr),
		.data_in	(sram_if_sram.sram_wdata[7:0]),
		.ce		(sram_if_sram.bank1_cs[0]),
		.we		(sram_if_sram.sram_we),
		.data_out	(sram_if_sram.sram_b4)
	);

	sram sram_block5(
		.clk		(sram_clk),
		.addr		(sram_if_sram.sram_addr),
		.data_in	(sram_if_sram.sram_wdata[15:8]),
		.ce		(sram_if_sram.bank1_cs[1]),
		.we		(sram_if_sram.sram_we),
		.data_out	(sram_if_sram.sram_b5)
	);

	sram sram_block6(
		.clk		(sram_clk),
		.addr		(sram_if_sram.sram_addr),
		.data_in	(sram_if_sram.sram_wdata[23:16]),
		.ce		(sram_if_sram.bank1_cs[2]),
		.we		(sram_if_sram.sram_we),
		.data_out	(sram_if_sram.sram_b6)
	);

	sram sram_block7(
		.clk		(sram_clk),
		.addr		(sram_if_sram.sram_addr),
		.data_in	(sram_if_sram.sram_wdata[31:24]),
		.ce		(sram_if_sram.bank1_cs[3]),
		.we		(sram_if_sram.sram_we),
		.data_out	(sram_if_sram.sram_b7)
	);

endmodule



















