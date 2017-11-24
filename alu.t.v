// `include "alu.v"
`include "ALU/adder.v"

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

	// ALU alu(.result(result), .carryout(carryout), .zero(zero),
	// 	.overflow(overflow), .operandA(operandA), .operandB(operandB), 
	// 	.command(command));

	Subtractor32bit get_sub_out(operandA, operandB, result, carryout, overflow);


	initial begin
		$dumpfile("alu.vcd");
		$dumpvars();
		operandA = 32'd20; operandB = 32'd5; command = `opXOR; #1000
		$displayb(operandA);
		$displayb(operandB);
		$displayb(result);
		// $displayb("a: 		%b", get_sub_out.add1tob.add4.add1.a);
		// $displayb("b: 		%b", get_sub_out.add1tob.add4.add1.b);
		// $displayb("carryin: 	%b", get_sub_out.add1tob.add4.add1.carryin);
		// $displayb("sum: 		%b", get_sub_out.add1tob.add4.add1.sum);
		// $displayb("carryout: 	%b", get_sub_out.add1tob.add4.add1.carryout);
		$displayb(get_sub_out.b2comp);
		$finish();
	end

endmodule