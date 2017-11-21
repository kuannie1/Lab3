// ALU
`include "ALU/logic32bits.v"
`include "ALU/adder.v"
`include "ALU/slt.v"
`include "ALU/cne.v"

`define opADD  3'd0
`define opSUB  3'd1
`define opXOR  3'd2
`define opSLT  3'd3
`define opCNE  3'd4

 /* 
Module: ALU
Selects the right operation to run based on the command input (3-bit) and two 32-bit inputs (operandA and operandB)
Returns the 32-bit output (result) and 1-bit outputs if required (carryout, zero, and overflow)
*/

module ALU
(
output reg [31:0] result,
output reg       carryout,
output reg       zero,
output reg       overflow,
input [31:0]   operandA,
input [31:0]   operandB,
input[2:0]    command
);


wire[31:0] add_out, sub_out, xor_out, slt_out, isNotEqual;
wire add_carryout, add_overflow, sub_carryout, sub_overflow, add_zero, sub_zero;

FullAdder32bit get_add_out(add_out, add_carryout, add_overflow, operandA, operandB);
Subtractor32bit get_sub_out(operandA, operandB, sub_out, sub_carryout, sub_overflow);
xor32 get_xor(xor_out, operandA, operandB);
SLT get_slt_out(operandA, operandB, slt_out);
CNE check_CNE(operandA, operandB, isNotEqual);

zero_check zcheck_add(add_zero, add_out);
zero_check zcheck_sub(sub_zero, sub_out);


always @(add_out or sub_out or xor_out or slt_out or isNotEqual) begin
// #2500
	case(command) 
		`opADD: begin
			result = add_out;
			carryout = add_carryout;
			overflow = add_overflow;
			zero = add_zero;
		end
		`opSUB: begin
			result = sub_out;
			carryout = sub_carryout;
			overflow = sub_overflow;
			zero = sub_zero;
		end
		`opXOR: begin
			result = xor_out;
			carryout = 1'b0;
			overflow = 1'b0;
			zero = 1'b0;
		end
		`opSLT: begin
			result = slt_out;
			carryout = 1'b0;
			overflow = 1'b0;
			zero = 1'b0;
		end
		`opCNE: begin
			result = isNotEqual; // a 32-bit of all zeros or 1 in 32-bit form
			carryout = 1'b0;
			overflow = 1'b0;
			zero = 1'b0;
		end
	endcase
end

endmodule