/*
	Instruction decode module
*/

module instructiondecode(

	input [31:0]	instruction,
	output [5:0]	op_code, func,
	output [4:0]	Rs, Rt, Rd,
	output [4:0]	shift,
	output [15:0]	imm,
	output [25:0]	target
);

	// R-, I-, J-Type instructions
	assign op_code = instruction[31:26];

	// R- and I- Type instructions
	assign Rs = instruction[25:21];
	assign Rt = instruction[20:16];

	// R-Type instructions
	assign Rd = instruction[15:11];
	assign shift = instruction[10:6];
	assign func = instruction[5:0];

	// I-Type instructions
	assign imm = instruction[15:0];

	// J-Type instructions
	assign target = instruction[25:0];

endmodule