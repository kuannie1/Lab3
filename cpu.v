/*
	Top-level module for the CPU.
*/

`include "SPI/dff.v"
`include "alu.v"
// `include "mux.v"
`include "instructionmemory.v"
`include "instructiondecode.v"
`include "controlLUT.v"
`include "regfile.v"
`include "SPI/datamemory.v"
`include "signextend.v"


module CPU
(
	input clk
	//output [31:0] instruction
);

//wire [15:0] pc_signextend; //What's this? do we need this
wire [31:0] pc;
wire [31:0] pcplus4; //The next instruction
wire [31:0] pc_out;

wire alu0_carryout, alu0_zero, alu0_overflow;

// initialize IF phase

//signextend se0(.num(pc), .result(pc_signextend)); //why do we need this? is pc not always positive?

dff #(32) dflipflop(.clk(clk), .we(1'b1), .dataIn(pc), .dataOut(pc_out));

ALU alu_pc4(.result(pcplus4), .carryout(alu0_carryout), .zero(alu0_zero), .overflow(alu0_overflow),
	.operandA(pc), .operandB(32'd4), .command(3'd0));

wire [31:0] instruction;
instructionmemory im(.clk(clk), .Addr(pc[11:2]), .DataOut(instruction));

// initialize instruction decode phase
wire [5:0]	op_code, func;
wire [4:0]	Rs, Rt, Rd;
wire [4:0]	shift;
wire [15:0]	imm;
wire [25:0]	target;
//Control signals:
wire reg_dst, ALU_src, mem_to_reg, mem_read, mem_write, reg_write;
wire branch, jump, jump_and_link, jump_reg;
wire [2:0] ALU_op;

wire [31:0] read1, read2;

wire [31:0] dm_out;

instructiondecode id(.instruction(instruction), .op_code(op_code), .func(func), .Rs(Rs), .Rt(Rt), .Rd(Rd),
	.shift(shift), .imm(imm), .target(target));

controlLUT cl(.op_code(op_code), .func(func), .reg_dst(reg_dst), .ALU_src(ALU_src), .mem_to_reg(mem_to_reg),
	.mem_read(mem_read), .mem_write(mem_write), .reg_write(reg_write), .branch(branch), .jump(jump),
	.jump_and_link(jump_and_link), .jump_reg(jump_reg), .ALU_op(ALU_op));

wire [31:0] pc_no_jump, pc_jump;
wire [31:0] branch_addr, jump_addr;
//Muxes to select for pc
mux2to1 select_branch(.outputofmux(pc_no_jump), .address(branch), .input0(pcplus4), .input1(branch_addr));
mux2to1 select_jump_addr(.outputofmux(pc_jump), .address(jump_reg), .input0({jump_addr[29:0], 2'b0}), .input1(read1));
mux2to1 select_jump(.outputofmux(pc), .address(jump), .input0(pc_no_jump), .input1(pc_jump));

wire[31:0] wd, exec_result, wb_result;

regfile rf(.ReadData1(read1), .ReadData2(read2), .WriteData(wd),
	.ReadRegister1(Rs), .ReadRegister2(Rt), .WriteRegister(Rd), .RegWrite(reg_write), .Clk(clk));

//select what to write into register
mux2to1 select_wd(.outputofmux(wd), .address(jump_and_link), .input0(wb_result), .input1(pcplus4));

//select write register : CHECK BACK for order
mux2to1_5bit select_wa(.outputofmux(Rd), .address(reg_dst), .input0(Rt), .input1(Rd));

// initialize execute phase
// lw components
wire [31:0] signextendimm;
wire alu1_carryout, alu1_zero, alu1_overflow;

signextend se1(.num(imm), .result(signextendimm));

wire [31:0] operand2;
ALU alu_exec(.result(exec_result), .carryout(alu1_carryout), .zero(alu1_zero), .overflow(alu1_overflow),
	.operandA(read1), .operandB(operand2), .command(ALU_op));

mux2to1 select_operand2(.outputofmux(operand2), .address(ALU_src), .input0(read2), .input1(signextendimm));

wire [31:0] readData;
datamemory datmem(.clk(clk), .dataOut(readData), .address(exec_result[13:2]), .writeEnable(mem_write), .dataIn(read2));

mux2to1 select_WB(.outputofmux(wb_result), .address(mem_read), .input0(exec_result), .input1(readData));

wire alu2_carryout, alu2_zero, alu2_overflow;
ALU alu_branch(.result(branch_addr), .overflow(alu2_overflow), .zero(alu2_zero), .carryout(alu2_carryout),
	.operandA({signextendimm[29:0], 2'b0}), .operandB(operand2), .command(ALU_op));

endmodule