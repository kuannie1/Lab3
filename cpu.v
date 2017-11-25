/*
	Top-level module for the CPU.
*/


`include "alu.v"
`include "instructionmemory.v"
`include "instructiondecode.v"
`include "controlLUT.v"
`include "regfile.v"
`include "datamemory.v"
`include "signextend.v"


module CPU
(
	input clk,
	input reset
);

wire [31:0] pc_next;
wire [31:0] pcplus4; //The next instruction
reg [31:0] pc_out;


initial begin pc_out = 32'b0; end //initialize pc to 0

always @(posedge clk) begin
	if (pc_next) begin
		pc_out <= pc_next;
	end
end

wire alu0_carryout, alu0_zero, alu0_overflow;

// initialize IF phase
// Replace with behavioral adder later

assign pcplus4 = pc_out + 4;

wire [31:0] instruction;

instructionmemory im(.clk(clk), .Addr(pc_out[13:2]), .DataOut(instruction));
// instructionmemory im(.clk(clk), .Addr(10'b0), .DataOut(instruction));

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

assign jump_addr = target;

//Muxes to select for pc
// change name of pc_no_jump to be more appropriate
mux2to1 select_branch(.outputofmux(pc_no_jump), .address(branch), .input0(pcplus4), .input1(branch_addr));
mux2to1 select_jump_addr(.outputofmux(pc_jump), .address(jump_reg), .input0({jump_addr[29:0], 2'b0}), .input1(read1));

mux2to1 select_jump(.outputofmux(pc_next), .address(jump), .input0(pc_no_jump), .input1(pc_jump));

// wire alu2_carryout, alu2_zero, alu2_overflow;
// ALU alu_branch(.result(branch_addr), .overflow(alu2_overflow), .zero(alu2_zero), .carryout(alu2_carryout),
// 	.operandA({signextendimm[29:0], 2'b0}), .operandB(pcplus4), .command(ALU_op));
assign branch_addr = {signextendimm[29:0], 2'b0} + pcplus4;

wire[31:0] wd, exec_result, wb_result;

wire [4:0] Rdtemp;
regfile rf(.ReadData1(read1), .ReadData2(read2), .WriteData(wd),
	.ReadRegister1(Rs), .ReadRegister2(Rt), .WriteRegister(Rdtemp), .RegWrite(reg_write), .Clk(clk));

//select what to write into register
mux2to1 select_wd(.outputofmux(wd), .address(jump_and_link), .input0(wb_result), .input1(pcplus4));

mux2to1_5bit select_wa(.outputofmux(Rdtemp), .address(reg_dst), .input0(Rt), .input1(Rd));

// initialize execute phase
// lw components
wire [31:0] signextendimm;
wire alu1_carryout, alu1_zero, alu1_overflow;

signextend se1(.num(imm), .result(signextendimm));

wire [31:0] operand2;

mux2to1 select_operand2(.outputofmux(operand2), .address(ALU_src), .input0(read2), .input1(signextendimm));

ALU alu_exec(.result(exec_result), .carryout(alu1_carryout), .zero(alu1_zero), .overflow(alu1_overflow),
	.operandA(read1), .operandB(operand2), .command(ALU_op));


wire [31:0] readData;

datamemory datmem(.clk(clk), .dataOut(readData), .address(exec_result[13:2]), .writeEnable(mem_write), .dataIn(read2));

mux2to1 select_WB(.outputofmux(wb_result), .address(mem_read), .input0(exec_result), .input1(readData));

endmodule