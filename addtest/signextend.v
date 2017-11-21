module signextend
(
	input [15:0] num, // input of 16 bits
	output[31:0] result // sign extended to 32 bits
);

	assign result = $signed(num);

endmodule