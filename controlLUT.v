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


	always @(op_code || func) begin

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
				ALU_op <= 3'bx;
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
				ALU_op <= 3'bx;
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
				ALU_op <= 3'bx;
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
				ALU_op <= 3'bx;
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
				ALU_op <= 3'd1; //SUB
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
				ALU_op <= 3'd6; //XOR
			end

			ADDI: begin
				reg_dst <= 1;
				ALU_src <= 1;
				mem_to_reg <= 0;
				mem_read <= 0;
				mem_write <= 0;
				reg_write <= 1;
				branch <= 0;
				jump <= 0;
				jump_and_link <= 0;
				jump_reg <= 0;
				ALU_op <= 3'd0; //ADD
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
						ALU_op <= 3'd0; //ADD
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
						ALU_op <= 3'd1; //SUB

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
						ALU_op <= 3'd7; //SLT
					end

					JR: begin
						reg_dst <= 1;
						ALU_src <= 0;
						mem_to_reg <= 0;
						mem_read <= 0;
						mem_write <= 0;
						reg_write <= 0;
						branch <= 0;
						jump <= 0;
						jump_and_link <= 0;
						jump_reg <= 1;
						ALU_op <= 3'bx; 
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
						ALU_op <= 0; 
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
					ALU_op <= 0; 
				end

		endcase

	end

endmodule