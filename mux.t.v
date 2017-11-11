`include "mux.v"

module testMux();
	wire 2to1output;
	reg 2to1selector;
	reg[1:0] 2to1inputs;

	mux2to1 dut(.outputofmux(2to1output),
				.2to1selector(2to1selector),
				.inputsofmux(2to1inputs));

	initial begin
		$dumpfile("muxtest.vcd");
		$dumpvars();
		// set 2to1inputs
		2to1inputs[0] = 1;2to1inputs[1] = 0; #50

		// set 2to1selector = 0
		2to1selector=0; #50
		$display("Output: %b", 2to1output);

		2to1selector=1; #50
		$display("Output: %b", 2to1output);
	end
endmodule