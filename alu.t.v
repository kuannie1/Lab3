`include "alu.v"

`define opADD  3'd0
`define opSUB  3'd1
`define opXOR  3'd2
`define opSLT  3'd3
`define opCNE  3'd4

module alu_test ();

	wire [31:0] result;
	wire carryout;
	wire zero;
	wire overflow;
	reg [31:0] operandA;
	reg [31:0] operandB;
	reg [2:0] command;

	ALU alu(.result(result), .carryout(carryout), .zero(zero),
		.overflow(overflow), .operandA(operandA), .operandB(operandB), 
		.command(command));

	initial begin
		$dumpfile("alu.vcd");
		$dumpvars();
		operandA = 32'b1; operandB = 32'b1; command = `opADD; #1000
		$displayb(result);
		$finish();
	end

endmodule