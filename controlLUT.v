/*
	Determines what signals need to be passed through.
	reg_dst: determines destination of write address (different for R-type and other types of instruction)
	alu_src: mux control signal for the B operand
	mem_to_reg: write enable for the register file frin memory
	mem_read: 'read enable' signal for data memory
	mem_write: write enable signal for data memory
	reg_write: write enable for register
	branch: is there a branch needed
	jump: is there a jump needed
	jump_and_link: is there a jump and link needed
	jump_reg: is there a jump register needed
	ALU_op: selecting the appropriate ALU operation
*/

module controlLUT 
(	
	input [5:0] op_code, func,
	output reg reg_dst, ALU_src, mem_to_reg, mem_read, mem_write, reg_write,
	output reg branch, jump, jump_and_link, jump_reg,
	output reg [2:0] ALU_op
);

	// All op_codes in hex
	localparam LW = 6'h23;
	localparam SW = 6'h2b;
	localparam J = 6'h2;
	localparam JAL = 6'h3;
	localparam BNE = 6'h5;
	localparam XORI = 6'he;
	localparam ADDI = 6'h8;
	localparam FUNCT = 6'h0;

	// FUNCT means that it is an R-Type instruction, must look at func not op_code instead
	localparam ADD = 6'h20;
	localparam SUB = 6'h22;
	localparam SLT = 6'h2a;
	localparam JR = 6'h08;

	// ALU ops
	localparam opNONE = 3'bx;
	localparam opADD = 3'd0;
	localparam opSUB = 3'd1;
	localparam opXOR = 3'd2;
	localparam opSLT = 3'd3;
	localparam opCNE = 3'd4;


	always @(op_code or func) begin

		case(op_code)

			LW: begin
				reg_dst <= 0;
				ALU_src <= 1;
				mem_to_reg <= 1;
				mem_read <= 1;
				mem_write <= 0;
				reg_write <= 1;
				branch <= 0;
				jump <= 0;
				jump_and_link <= 0;
				jump_reg <= 0;
				ALU_op <= opNONE;
			end

			SW: begin
				reg_dst <= 0;
				ALU_src <= 1;
				mem_to_reg <= 0;
				mem_read <= 0;
				mem_write <= 1;
				reg_write <= 0;
				branch <= 0;
				jump <= 0;
				jump_and_link <= 0;
				jump_reg <= 0;
				ALU_op <= opNONE;
			end

			J: begin
				reg_dst <= 0;
				ALU_src <= 0;
				mem_to_reg <= 0;
				mem_read <= 0;
				mem_write <= 0;
				reg_write <= 0;
				branch <= 0;
				jump <= 1;
				jump_and_link <= 0;
				jump_reg <= 0;
				ALU_op <= opNONE;
			end

			JAL: begin
				reg_dst <= 0;
				ALU_src <= 0;
				mem_to_reg <= 0;
				mem_read <= 0;
				mem_write <= 0;
				reg_write <= 1;
				branch <= 0;
				jump <= 1;
				jump_and_link <= 1;
				jump_reg <= 0;
				ALU_op <= opNONE;
			end

			BNE: begin
				reg_dst <= 0;
				ALU_src <= 0;
				mem_to_reg <= 0;
				mem_read <= 0;
				mem_write <= 0;
				reg_write <= 0;
				branch <= 1;
				jump <= 0;
				jump_and_link <= 0;
				jump_reg <= 0;
				ALU_op <= opCNE;
			end

			XORI: begin
				reg_dst <= 0;
				ALU_src <= 1;
				mem_to_reg <= 0;
				mem_read <= 0;
				mem_write <= 0;
				reg_write <= 1;
				branch <= 0;
				jump <= 0;
				jump_and_link <= 0;
				jump_reg <= 0;
				ALU_op <= opXOR;
			end

			ADDI: begin
				reg_dst <= 0;
				ALU_src <= 1;
				mem_to_reg <= 0;
				mem_read <= 0;
				mem_write <= 0;
				reg_write <= 1;
				branch <= 0;
				jump <= 0;
				jump_and_link <= 0;
				jump_reg <= 0;
				ALU_op <= opADD;
			end
			
			FUNCT:
				case(func)

					ADD: begin
						reg_dst <= 1;
						ALU_src <= 0;
						mem_to_reg <= 0;
						mem_read <= 0;
						mem_write <= 0;
						reg_write <= 1;
						branch <= 0;
						jump <= 0;
						jump_and_link <= 0;
						jump_reg <= 0;
						ALU_op <= opADD;
					end

					SUB: begin
						reg_dst <= 1;
						ALU_src <= 0;
						mem_to_reg <= 0;
						mem_read <= 0;
						mem_write <= 0;
						reg_write <= 1;
						branch <= 0;
						jump <= 0;
						jump_and_link <= 0;
						jump_reg <= 0;
						ALU_op <= opSUB;

					end

					SLT: begin
						reg_dst <= 1;
						ALU_src <= 0;
						mem_to_reg <= 0;
						mem_read <= 0;
						mem_write <= 0;
						reg_write <= 1;
						branch <= 0;
						jump <= 0;
						jump_and_link <= 0;
						jump_reg <= 0;
						ALU_op <= opSLT;
					end

					JR: begin
						reg_dst <= 1;
						ALU_src <= 0;
						mem_to_reg <= 0;
						mem_read <= 0;
						mem_write <= 0;
						reg_write <= 0;
						branch <= 0;
						jump <= 1;
						jump_and_link <= 0;
						jump_reg <= 1;
						ALU_op <= opNONE; 
					end

					// just in case - everything zero!
					default: begin
						reg_dst <= 0;
						ALU_src <= 0;
						mem_to_reg <= 0;
						mem_read <= 0;
						mem_write <= 0;
						reg_write <= 0;
						branch <= 0;
						jump <= 0;
						jump_and_link <= 0;
						jump_reg <= 0;
						ALU_op <= opNONE; 
					end

				endcase

				// just in case - everything zero!
				default: begin
					reg_dst <= 0;
					ALU_src <= 0;
					mem_to_reg <= 0;
					mem_read <= 0;
					mem_write <= 0;
					reg_write <= 0;
					branch <= 0;
					jump <= 0;
					jump_and_link <= 0;
					jump_reg <= 0;
					ALU_op <= opNONE; 
				end

		endcase

	end

endmodule