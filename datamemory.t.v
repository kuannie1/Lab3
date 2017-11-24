`include "datamemory.v"

module testDataMemory();
	reg 		clk;
    wire [31:0] dataOut;
    reg [11:0]  address;
    reg         writeEnable;
    reg [31:0]  dataIn;

	datamemory dm(.clk(clk), .dataOut(dataOut), 
		.address(address), .writeEnable(writeEnable),
		.dataIn(dataIn));


    // Clock generation
    initial clk=1;
    always #100 clk = !clk;



	// Test sequence
    initial begin
    // Dump waveforms to file
    // Note: arrays (e.g. memory) are not dumped by default
    $dumpfile("dm.vcd");
    $dumpvars();
    address = 12'd0; dataIn = 32'd1; writeEnable = 1'b1; #400
    if (dataOut != 32'd1) $display("Test 1 failed");

    address = 12'd0; dataIn = 32'd10; writeEnable = 1'b1; #400
    if (dataOut != 32'd10) $display("Test 2 failed");

    // End execution after some time delay
    #8000 $finish();
    end

endmodule