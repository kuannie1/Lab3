`include "signextend.v"

module testsignextend();
	reg[15:0] num;
	wire[31:0] result;


	signextend se(num, result);

	initial begin

		num = 16'h23; #1000
		if (result != 32'h23) begin
			$display("sign extend not working");
			$displayb("result: %b", result);
		end

	end

endmodule