//------------------------------------------------------------------------
// SPI Memory
//------------------------------------------------------------------------

`include "shiftregister.v"
`include "inputconditioner.v"
`include "datamemory.v"
`include "spifsm.v"
`include "dff.v"
`include "tristate.v"

module spiMemory
(
    input           clk,        // FPGA clock
    input           sclk_pin,   // SPI clock
    input           cs_pin,     // SPI chip select
    output          miso_pin,   // SPI master in slave out
    input           mosi_pin,   // SPI master out slave in
    output [3:0]    leds        // LEDs for debugging
);

wire mosi_conditioned, sclk_pe, sclk_ne, cs_conditioned, sr_serial_out,
	miso_bufe, dm_we, addr_we, sr_we, dff_out;

wire [7:0] sr_parallel_out, dm_data_out, address;

inputconditioner mosi_ic(.clk(clk),
    			 		.noisysignal(mosi_pin),
			 			.conditioned(mosi_conditioned),
			 			.positiveedge(_),
			 			.negativeedge(_));

inputconditioner sclk_ic(.clk(clk),
    			 		.noisysignal(sclk_pin),
			 			.conditioned(_),
			 			.positiveedge(sclk_pe),
			 			.negativeedge(sclk_ne));

inputconditioner cs_ic(.clk(clk),
    			 		.noisysignal(cs_pin),
			 			.conditioned(cs_conditioned),
			 			.positiveedge(_),
			 			.negativeedge(_));

shiftregister sr(.clk(clk),                
				.peripheralClkEdge(sclk_pe),
				.parallelLoad(sr_we),     
				.parallelDataIn(dm_data_out),
				.serialDataIn(mosi_conditioned),
				.parallelDataOut(sr_parallel_out),
				.serialDataOut(sr_serial_out) );

datamemory 		dm(.clk(clk),
    			.dataOut(dm_data_out),
    			.address(address[7:1]),
    			.writeEnable(dm_we),
    			.dataIn(sr_parallel_out));

dff #(8) address_latch (.clk(clk),
						.ce(addr_we),
						.dataIn(sr_parallel_out),
						.dataOut(address));

dff #(1) d_flipflop (.clk(clk),
					.ce(sclk_ne),
					.dataIn(sr_serial_out),
					.dataOut(dff_out));

spifsm fsm(.cs(cs_conditioned),
		.clkpos(sclk_pe),
		.ReadWrite(sr_parallel_out[0]),
		.miso(miso_bufe),
		.dm_we(dm_we),
		.addr_we(addr_we),
		.sr_we(sr_we));

tristate miso_buffer(.clk(clk),
					.q(dff_out),
					.bufe(miso_bufe),
					.out(miso_pin));

assign leds[3] = miso_bufe;
assign leds[2] = dm_we;
assign leds[1] = addr_we;
assign leds[0] = sr_we;

endmodule
   
