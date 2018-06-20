// Name       : AHB_Slave_Interface
// Version    : 1.0
// Date       : 2018-06-16
// Description: ahb interface and arbiter
//				based on IHI0033B_B_amba_5_ahb_protocol_spec.pdf
//----------------------------------------------------------------------------------------

module ahb_slave_interface	
	(
	ahb_if 	ahb_if_inst,
	sram_if sram_if_ahb //init all ports between arb and sram8x8k
);
	parameter
	IDLE   = 2'b00,
	BUSY   = 2'b01,
	NONSEQ = 2'b10,
	SEQ    = 2'b11;

	//reg for ahb input signals
	logic	[ahb_if_inst.ADDR_WIDTH-1:0]	haddr_r;
	logic	[ahb_if_inst.HBURST_WIDTH-1:0]	hburst_r;
	logic	[ahb_if_inst.HTRANS_WIDTH-1:0]	htrans_r;
	logic	[ahb_if_inst.HSIZE_WIDTH-1:0]	hsize_r;
	logic	hwrite_r;

	logic	[3:0]	sram_cs; //select sram in one bank. second sram:0010
	logic	[1:0]	sram_sel; //select sram in one bank. second sram:01
	logic	[1:0]	hsize_sel; //set data length: 8,16,32
	logic 	bank_sel;
	logic 	srams_en;

	logic	[ahb_if_inst.SRAM_ADDR_WIDTH+3-1:0]	srams_addr; //addr for all 8 sram
	logic	[ahb_if_inst.DATA_WIDTH-1:0]	sram_data_out; //data read from sram and send to AHB bus
	
	assign ahb_if_inst.hready_resp = 1'b1;
	assign ahb_if_inst.hresp = 2'b00;

	//sram enable and sram write enable
	assign srams_en = (htrans_r == NONSEQ) || (htrans_r == SEQ);
	assign sram_if_ahb.sram_we = srams_en && hwrite_r;

	//data io
	assign sram_data_out = (bank_sel) ? // if 0, bank0 else bank1
	{sram_if_ahb.sram_b3, sram_if_ahb.sram_b2, sram_if_ahb.sram_b1, sram_if_ahb.sram_b0} :
	{sram_if_ahb.sram_b7, sram_if_ahb.sram_b6, sram_if_ahb.sram_b5, sram_if_ahb.sram_b4} ;
	assign ahb_if_inst.hrdata = sram_data_out;
	assign sram_if_ahb.sram_wdata = ahb_if_inst.hwdata;

	//addr	
	// srams_addr[14:0] for 4 8kbyte srams in one bank
	// srams_addr[15] for bank select
	assign srams_addr = haddr_r[ahb_if_inst.SRAM_ADDR_WIDTH+3-1:0];
	assign sram_if_ahb.sram_addr = srams_addr[14:2]; // addr for 1byte on each sram														

	assign bank_sel = (srams_en && (srams_addr[15] == 1'b0)) ? 1'b0 : 1'b1;
	assign sram_if_ahb.bank0_cs = (srams_en && (srams_addr[15] == 1'b0))  ? sram_cs : 4'b0000;
	assign sram_if_ahb.bank1_cs = (srams_en && (srams_addr[15] == 1'b1))  ? sram_cs : 4'b0000;

	//signals used to generating sram chip select signal in one bank.
	assign sram_sel = srams_addr[1:0];
	assign ahb_if_inst.hsize_sel = hsize_r [1:0];

	//seq part
	always@(posedge ahb_if_inst.hclk , negedge ahb_if_inst.hresetn) begin
		if(!ahb_if_inst.hresetn) begin
			hwrite_r  <= 1'b0	;
			hsize_r   <= 3'b0	;
			hburst_r  <= 3'b0	;
			htrans_r  <= 2'b0  	;
			haddr_r   <= 32'b0 	;
		end
		else if(ahb_if_inst.hsel && ahb_if_inst.hready) begin
			hwrite_r  <= ahb_if_inst.hwrite ;
			hsize_r   <= ahb_if_inst.hsize  ;
			hburst_r  <= ahb_if_inst.hburst ;
			htrans_r  <= ahb_if_inst.htrans ;
			haddr_r   <= ahb_if_inst.haddr 	;
		end
		else begin
			hwrite_r  <= 1'b0	;
			hsize_r   <= 3'b0	;
			hburst_r  <= 3'b0	;
			htrans_r  <= 2'b0  	;
			haddr_r   <= 32'b0 	;
		end
	end

	//comb part
	always@(ahb_if_inst.hsize_sel or sram_sel) begin
		if(ahb_if_inst.hsize_sel == 2'b10) //32bit
			sram_cs = 4'b1111;
		else if(ahb_if_inst.hsize_sel == 2'b01) //16bit
			sram_cs = (sram_sel[1] == 1'b0) ? 4'b0011 : 4'b1100; //sram_sel[1] is low, get data from 1st and 2nd srams
		else if(ahb_if_inst.hsize_sel == 2'b00) begin //8bit
			case(sram_sel) //translate sram_sel to sram_cs
				2'b00 : sram_cs = 4'b0001;
				2'b01 : sram_cs = 4'b0010;
				2'b10 : sram_cs = 4'b0100;
				2'b11 : sram_cs = 4'b1000;
				default : sram_cs = 4'b0000;
			endcase
		end
		else sram_cs=4'b0000;
	end

endmodule