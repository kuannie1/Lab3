// Program Counter of Single-Cycle CPU
`include "mux.v"

module pc(
	output[3:0] pc_output, // there are 11 instructions we want to support
	input clk,
	input[3:0] pc_input
);

wire [3:0] pc_intermediate;

always @(posedge clk) begin
	if (pc_input == 4'b1010) begin
		pc_input <= 4'b0011;
	end
	else if (pc_input == 4'b1001) begin
		pc_input <= 4'b0010;
	end 
	else if (pc_input == 4'b1000) begin
		pc_input <= 4'b0001;
	end
	else if (pc_input == 4'b0111) begin
		pc_input <= 4'b0000;
	end
	else begin
		pc_input <= pc_input + 4'b0100;
	end
end

assign pc_output = pc_input;


endmodule