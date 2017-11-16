/*
	Top-level module for the CPU.
*/

`include "SPI/dff.v"
`include "alu.v"
`include "mux.v"
`include "instructionmemory.v"
`include "instructiondecode.v"
`include "controlLUT.v"
`include "regfile.v"
`include "SPI/datamemory.v"


module CPU
(
	input clk,
	input [15:0] pc,
	output [31:0] instruction	// this is the 32 bit instruction: 1 and 0s that need to be decoded
);

//wire [15:0] pc_signextend; //What's this? do we need this
wire [15:0] pcplus4; //The next instsructure

wire [4:0] branch; //what's this?

wire alu0_carryout, alu0_zero, alu0_overflow;

// initialize IF phase

//signextend se0(.num(pc), .result(pc_signextend)); //why do we need this? is pc not always positive?

dff #(16) dflipflop(.clk(clk), .we(1'b1), .dataIn(pc_signextend), .dataOut(pc_signextend));

ALU alu0(.result(pcplus4), .carryout(alu0_carryout), .zero(alu0_zero), .overflow(alu0_overflow),
	.operandA(pc), .operandB(32'd4), .command(3'd0));

// control logic for selecting pc vs pc + 4 ???
mux2to1 mux0(.out(pc_signextend), .address(branch), .input0(pcplus4), .input1(pc));

// 	ERROR: ADDR IS ONLY 10 BITS
// FIX
instructionmemory im(.clk(clk), .Addr(pc), .DataOut(instruction));

// initialize instruction decode phase

wire [31:0] instruction;
wire [5:0]	op_code, func;
wire [4:0]	Rs, Rt, Rd;
wire [4:0]	shift;
wire [15:0]	imm;
wire [25:0]	target;

wire reg_dst, ALU_src, mem_to_reg, mem_read, mem_write, reg_write;
wire branch, jump, jump_and_link, jump_reg;
wire [2:0] ALU_op;

wire [31:0] read0, read1;

wire [31:0] dm_out;

instructiondecode id(.instruction(instruction), .op_code(op_code), .func(func), .Rs(Rs), .Rt(Rt), .Rd(Rd),
	.shift(shift), .imm(imm), .target(target));

controlLUT cl(.op_code(op_code), .func(func), .reg_dst(reg_dst), .ALU_src(ALU_src), .mem_to_reg(mem_to_reg),
	.mem_read(mem_read), .mem_write(mem_write), .reg_write(reg_write), .branch(branch), .jump(jump),
	.jump_and_link(jump_and_link), .jump_reg(jump_reg), .ALU_op(ALU_op));

// change WriteData input, it is just 0 for now
regfile rf(.ReadData1(read0), .ReadData2(read1), .WriteData(32'b0),
	.ReadRegister1(Rs), .ReadRegister2(Rt), .WriteRegister(Rd), .RegWrite(reg_write), .Clk(clk));

// initialize execute phase

// lw components
wire [31:0] signextendimm_lw, ALUresult_lw;
wire alu1_carryout, alu1_zero, alu1_overflow;

signextend se1(.num(imm), .result(signextendimm_lw));

ALU alu1(.result(ALUresult_lw), .carryout(alu1_carryout), .zero(alu1_zero), .overflow(alu1_overflow),
	.operandA(read0), .operandB(read1), .command(ALU_op));

datamemory #(32, 2, ) dm(.clk(clk), )

endmodule