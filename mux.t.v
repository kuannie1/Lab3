`include "mux.v"

module testMux();
	wire outputs;
	reg address;
	reg[1:0] inputs;

	mux2to1 dut(.outputofmux(outputs),
				.address(address),
				.inputsofmux(inputs));

	initial begin
		$dumpfile("muxtest.vcd");
		$dumpvars();
		// set inputs
		inputs[0] = 1;inputs[1] = 0; #50

		// set address = 0
		address=0; #50
		$display("Output: %b", outputs);

		address=1; #50
		$display("Output: %b", outputs);
	end
endmodule