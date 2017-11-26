/* Test bench for the CPU controller
*/

`include "controlLUT.v"

// define op codes for the instructions
`define LW  6'h23
`define SW  6'h2b
`define J  6'h2
`define JAL  6'h3
`define BNE  6'h5
`define XORI  6'he
`define ADDI  6'h8
`define FUNCT  6'h0

// define func codes for the R-type instructions
`define ADD  6'h20
`define SUB  6'h22
`define SLT  6'h2a
`define JR  6'h08

// define ALU control codes
`define opNONE  3'bx
`define opADD  3'd0
`define opSUB  3'd1
`define opXOR  3'd2
`define opSLT  3'd3
`define opCNE  3'd4

module controlLUTtest ();

	reg [5:0] op_code, func;
	wire reg_dst, ALU_src, mem_read, mem_write, reg_write;
	wire branch, jump, jump_and_link, jump_reg;
	wire [2:0] ALU_op;

	controlLUT controller(.op_code(op_code), .func(func), .reg_dst(reg_dst), .ALU_src(ALU_src),
		.mem_read(mem_read), .mem_write(mem_write), .reg_write(reg_write), .branch(branch),
		.jump(jump), .jump_and_link(jump_and_link), .jump_reg(jump_reg), .ALU_op(ALU_op));

	initial begin
		$dumpfile("controlLUT.vcd");
		$dumpvars();

		// testing LW
		op_code = `LW; #1000
		if (reg_dst !== 0) 
			$display("LW failed: reg_dst is %b", reg_dst);
		if (ALU_src !== 1)
			$display("LW failed: ALU_src is %b", ALU_src);
	 	if (mem_read !== 1)
	 		$display("LW failed: mem_read is %b", mem_read);
		if (mem_write !== 0)
			$display("LW failed: mem_write is %b", mem_write);
		if (reg_write !== 1)
			$display("LW failed: reg_write is %b", reg_write);
		if (branch !== 0)
			$display("LW failed: branch is %b", branch);
		if (jump !== 0)
			$display("LW failed: jump is %b", jump);
		if (jump_and_link !== 0)
			$display("LW failed: jump_and_link is %b", jump_and_link);
		if (jump_reg !== 0)
			$display("LW failed: jump_reg %b", jump_reg);
		if (ALU_op !== `opNONE)
			$display("LW failed: ALU_op is %b", ALU_op);

		// testing SW
		op_code = `SW; #1000
		if (reg_dst !== 0) 
			$display("SW failed: reg_dst is %b", reg_dst);
		if (ALU_src !== 1)
			$display("SW failed: ALU_src is %b", ALU_src);
	 	if (mem_read !== 0)
	 		$display("SW failed: mem_read is %b", mem_read);
		if (mem_write !== 1)
			$display("SW failed: mem_write is %b", mem_write);
		if (reg_write !== 0)
			$display("SW failed: reg_write is %b", reg_write);
		if (branch !== 0)
			$display("SW failed: branch is %b", branch);
		if (jump !== 0)
			$display("SW failed: jump is %b", jump);
		if (jump_and_link !== 0)
			$display("SW failed: jump_and_link is %b", jump_and_link);
		if (jump_reg !== 0)
			$display("SW failed: jump_reg %b", jump_reg);
		if (ALU_op !== `opNONE)
			$display("SW failed: ALU_op is %b", ALU_op);

		// testing J
		op_code = `J; #1000
		if (reg_dst !== 0) 
			$display("J failed: reg_dst is %b", reg_dst);
		if (ALU_src !== 0)
			$display("J failed: ALU_src is %b", ALU_src);
	 	if (mem_read !== 0)
	 		$display("J failed: mem_read is %b", mem_read);
		if (mem_write !== 0)
			$display("J failed: mem_write is %b", mem_write);
		if (reg_write !== 0)
			$display("J failed: reg_write is %b", reg_write);
		if (branch !== 0)
			$display("J failed: branch is %b", branch);
		if (jump !== 1)
			$display("J failed: jump is %b", jump);
		if (jump_and_link !== 0)
			$display("J failed: jump_and_link is %b", jump_and_link);
		if (jump_reg !== 0)
			$display("J failed: jump_reg %b", jump_reg);
		if (ALU_op !== `opNONE)
			$display("J failed: ALU_op is %b", ALU_op);

		// testing JAL
		op_code = `JAL; #1000
		if (reg_dst !== 0) 
			$display("JAL failed: reg_dst is %b", reg_dst);
		if (ALU_src !== 0)
			$display("JAL failed: ALU_src is %b", ALU_src);
	 	if (mem_read !== 0)
	 		$display("JAL failed: mem_read is %b", mem_read);
		if (mem_write !== 0)
			$display("JAL failed: mem_write is %b", mem_write);
		if (reg_write !== 1)
			$display("JAL failed: reg_write is %b", reg_write);
		if (branch !== 0)
			$display("JAL failed: branch is %b", branch);
		if (jump !== 1)
			$display("JAL failed: jump is %b", jump);
		if (jump_and_link !== 1)
			$display("JAL failed: jump_and_link is %b", jump_and_link);
		if (jump_reg !== 0)
			$display("JAL failed: jump_reg %b", jump_reg);
		if (ALU_op !== `opNONE)
			$display("JAL failed: ALU_op is %b", ALU_op);

		// testing BNE
		op_code = `BNE; #1000
		if (reg_dst !== 0) 
			$display("BNE failed: reg_dst is %b", reg_dst);
		if (ALU_src !== 0)
			$display("BNE failed: ALU_src is %b", ALU_src);
	 	if (mem_read !== 0)
	 		$display("BNE failed: mem_read is %b", mem_read);
		if (mem_write !== 0)
			$display("BNE failed: mem_write is %b", mem_write);
		if (reg_write !== 0)
			$display("BNE failed: reg_write is %b", reg_write);
		if (branch !== 1)
			$display("BNE failed: branch is %b", branch);
		if (jump !== 0)
			$display("BNE failed: jump is %b", jump);
		if (jump_and_link !== 0)
			$display("BNE failed: jump_and_link is %b", jump_and_link);
		if (jump_reg !== 0)
			$display("BNE failed: jump_reg %b", jump_reg);
		if (ALU_op !== `opCNE)
			$display("BNE failed: ALU_op is %b", ALU_op);

		// testing XORI
		op_code = `XORI; #1000
		if (reg_dst !== 0) 
			$display("XORI failed: reg_dst is %b", reg_dst);
		if (ALU_src !== 1)
			$display("XORI failed: ALU_src is %b", ALU_src);
	 	if (mem_read !== 0)
	 		$display("XORI failed: mem_read is %b", mem_read);
		if (mem_write !== 0)
			$display("XORI failed: mem_write is %b", mem_write);
		if (reg_write !== 1)
			$display("XORI failed: reg_write is %b", reg_write);
		if (branch !== 0)
			$display("XORI failed: branch is %b", branch);
		if (jump !== 0)
			$display("XORI failed: jump is %b", jump);
		if (jump_and_link !== 0)
			$display("XORI failed: jump_and_link is %b", jump_and_link);
		if (jump_reg !== 0)
			$display("XORI failed: jump_reg %b", jump_reg);
		if (ALU_op !== `opXOR)
			$display("XORI failed: ALU_op is %b", ALU_op);

		// testing ADDI
		op_code = `ADDI; #1000
		if (reg_dst !== 0) 
			$display("ADDI failed: reg_dst is %b", reg_dst);
		if (ALU_src !== 1)
			$display("ADDI failed: ALU_src is %b", ALU_src);
	 	if (mem_read !== 0)
	 		$display("ADDI failed: mem_read is %b", mem_read);
		if (mem_write !== 0)
			$display("ADDI failed: mem_write is %b", mem_write);
		if (reg_write !== 1)
			$display("ADDI failed: reg_write is %b", reg_write);
		if (branch !== 0)
			$display("ADDI failed: branch is %b", branch);
		if (jump !== 0)
			$display("ADDI failed: jump is %b", jump);
		if (jump_and_link !== 0)
			$display("ADDI failed: jump_and_link is %b", jump_and_link);
		if (jump_reg !== 0)
			$display("ADDI failed: jump_reg %b", jump_reg);
		if (ALU_op !== `opADD)
			$display("ADDI failed: ALU_op is %b", ALU_op);

		// testing R-TYPE instructions
		op_code = `FUNCT; #1000

			// testing ADD
			func = `ADD; #1000
			if (reg_dst !== 1) 
				$display("ADD failed: reg_dst is %b", reg_dst);
			if (ALU_src !== 0)
				$display("ADD failed: ALU_src is %b", ALU_src);
		 	if (mem_read !== 0)
		 		$display("ADD failed: mem_read is %b", mem_read);
			if (mem_write !== 0)
				$display("ADD failed: mem_write is %b", mem_write);
			if (reg_write !== 1)
				$display("ADD failed: reg_write is %b", reg_write);
			if (branch !== 0)
				$display("ADD failed: branch is %b", branch);
			if (jump !== 0)
				$display("ADD failed: jump is %b", jump);
			if (jump_and_link !== 0)
				$display("ADD failed: jump_and_link is %b", jump_and_link);
			if (jump_reg !== 0)
				$display("ADD failed: jump_reg %b", jump_reg);
			if (ALU_op !== `opADD)
				$display("ADD failed: ALU_op is %b", ALU_op);

			// testing SUB
			func = `SUB; #1000
			if (reg_dst !== 1) 
				$display("SUB failed: reg_dst is %b", reg_dst);
			if (ALU_src !== 0)
				$display("SUB failed: ALU_src is %b", ALU_src);
		 	if (mem_read !== 0)
		 		$display("SUB failed: mem_read is %b", mem_read);
			if (mem_write !== 0)
				$display("SUB failed: mem_write is %b", mem_write);
			if (reg_write !== 1)
				$display("SUB failed: reg_write is %b", reg_write);
			if (branch !== 0)
				$display("SUB failed: branch is %b", branch);
			if (jump !== 0)
				$display("SUB failed: jump is %b", jump);
			if (jump_and_link !== 0)
				$display("SUB failed: jump_and_link is %b", jump_and_link);
			if (jump_reg !== 0)
				$display("SUB failed: jump_reg %b", jump_reg);
			if (ALU_op !== `opSUB)
				$display("SUB failed: ALU_op is %b", ALU_op);

			// testing SLT
			func = `SLT; #1000
			if (reg_dst !== 1) 
				$display("SLT failed: reg_dst is %b", reg_dst);
			if (ALU_src !== 0)
				$display("SLT failed: ALU_src is %b", ALU_src);
		 	if (mem_read !== 0)
		 		$display("SLT failed: mem_read is %b", mem_read);
			if (mem_write !== 0)
				$display("SLT failed: mem_write is %b", mem_write);
			if (reg_write !== 1)
				$display("SLT failed: reg_write is %b", reg_write);
			if (branch !== 0)
				$display("SLT failed: branch is %b", branch);
			if (jump !== 0)
				$display("SLT failed: jump is %b", jump);
			if (jump_and_link !== 0)
				$display("SLT failed: jump_and_link is %b", jump_and_link);
			if (jump_reg !== 0)
				$display("SLT failed: jump_reg %b", jump_reg);
			if (ALU_op !== `opSLT)
				$display("SLT failed: ALU_op is %b", ALU_op);

			// testing JR
			func = `JR; #1000
			if (reg_dst !== 1) 
				$display("JR failed: reg_dst is %b", reg_dst);
			if (ALU_src !== 0)
				$display("JR failed: ALU_src is %b", ALU_src);
		 	if (mem_read !== 0)
		 		$display("JR failed: mem_read is %b", mem_read);
			if (mem_write !== 0)
				$display("JR failed: mem_write is %b", mem_write);
			if (reg_write !== 0)
				$display("JR failed: reg_write is %b", reg_write);
			if (branch !== 0)
				$display("JR failed: branch is %b", branch);
			if (jump !== 1)
				$display("JR failed: jump is %b", jump);
			if (jump_and_link !== 0)
				$display("JR failed: jump_and_link is %b", jump_and_link);
			if (jump_reg !== 1)
				$display("JR failed: jump_reg %b", jump_reg);
			if (ALU_op !== `opNONE)
				$display("JR failed: ALU_op is %b", ALU_op);

		// test default
		op_code = 6'h1; #1000
		if (reg_dst !== 0) 
			$display("JR failed: reg_dst is %b", reg_dst);
		if (ALU_src !== 0)
			$display("JR failed: ALU_src is %b", ALU_src);
	 	if (mem_read !== 0)
	 		$display("JR failed: mem_read is %b", mem_read);
		if (mem_write !== 0)
			$display("JR failed: mem_write is %b", mem_write);
		if (reg_write !== 0)
			$display("JR failed: reg_write is %b", reg_write);
		if (branch !== 0)
			$display("JR failed: branch is %b", branch);
		if (jump !== 0)
			$display("JR failed: jump is %b", jump);
		if (jump_and_link !== 0)
			$display("JR failed: jump_and_link is %b", jump_and_link);
		if (jump_reg !== 0)
			$display("JR failed: jump_reg %b", jump_reg);
		if (ALU_op !== `opNONE)
			$display("JR failed: ALU_op is %b", ALU_op);

		$finish();
	end

endmodule