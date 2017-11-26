`include "alu.v"
// `include "ALU/adder.v"

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

	// // how we tested specific modules within the ALU:

	// Subtractor32bit get_sub_out(operandA, operandB, result, carryout, overflow);
	// FullAdder32bit add(result, carryout, overflow, operandA, operandB);

	// reg [3:0] opA;
	// reg [3:0] opB;
	// wire [3:0] res;
	// FullAdder4bit newadd(res, carryout, overflow, opA, opB, 1'b0);



	initial begin
		$dumpfile("alu.vcd");
		$dumpvars();

		operandA = 32'd20; operandB = 32'd5; command = `opSUB; #1500
		$display("operand A: %d", operandA);
		$display("operand B: %d", operandB);
		$display("command: %d", command);
		$display("result: %d", result);
		
		operandA = 32'd20; operandB = 32'd5; command = `opADD; #1500
		$display("operand A: %d", operandA);
		$display("operand B: %d", operandB);
		$display("command: %d", command);
		$display("result: %d", result);

		operandA = 32'd5; operandB = 32'd25; command = `opSLT; #1500
		$display("operand A: %d", operandA);
		$display("operand B: %d", operandB);
		$display("command: %d", command);
		$display("result: %d", result);

		operandA = 32'd25; operandB = 32'd24; command = `opCNE; #1500
		$display("operand A: %d", operandA);
		$display("operand B: %d", operandB);
		$display("command: %d", command);
		$display("result: %d", result);


		$finish();
	end

endmodule