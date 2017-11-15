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


module CPU
(
	input clk,
	input [15:0] pc,
	output [31:0] instruction	// double check what this is, double check size
);

wire pc_signextend;
wire [31:0] pcplus4;

wire [4:0] branch,

wire alu0_carryout, alu0_zero, alu0_overflow;

// initialize IF phase

signextend se(.num(pc), .result(pc_signextend));

dff #(16) dflipflop(.clk(clk), .we(1'b1), .dataIn(pc_signextend), .dataOut(pc_signextend));

ALU alu0(.result(pcplus4), .carryout(alu0_carryout), .zero(alu0_zero), .overflow(alu0_overflow),
	.operandA(pc_signextend), .operandB(32'd4), .command(3'd0));

// control logic for selecting pc vs pc + 4 ???
mux2to1 mux0(.out(pc_signextend), .address(branch), .input0(pcplus4), .input0(pc_signextend));

// 	ERROR: ADDR IS ONLY 10 BITS
// FIX
instructionmemory im(.clk(clk), .Addr(pc_signextend), .DataOut(instruction));

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

instructiondecode id(.instruction(instruction), .op_code(op_code), .func(func), .Rs(Rs), .Rt(Rt), .Rd(Rd),
	.shift(shift), .imm(imm), .target(target));

controlLUT cl(.op_code(op_code), .func(func), .reg_dst(reg_dst), .ALU_src(ALU_src), .mem_to_reg(mem_to_reg),
	.mem_read(mem_read), .mem_write(mem_write), .reg_write(reg_write), .branch(branch), .jump(jump),
	.jump_and_link(jump_and_link), .jump_reg(jump_reg), .ALU_op(ALU_op));

// change WriteData input, it is just 0 for now
regfile rf(.ReadData1(read0), .ReadData2(read1), .WriteData(32'b0),
	.ReadRegister1(Rs), .ReadRegister2(Rt), .WriteRegister(Rd), .RegWrite(reg_write), .Clk(clk));

endmodule