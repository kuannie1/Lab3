//------------------------------------------------------------------------
// SPI Memory Finite State Machine
//------------------------------------------------------------------------

module spifsm(
	input cs,
	input clkpos,
	input ReadWrite,
	output reg miso,
	output reg dm_we,
	output reg addr_we,
	output reg sr_we
);

reg[4:0] counter = 5'd0;


always @(posedge clkpos ) begin

	if (cs == 1'b0) begin 

		if (counter < 5'd8) begin

			counter <= counter+1;
			miso <= 0;
			dm_we <= 0;
			addr_we <= 1;
			sr_we <= 0;
		end
		else if (counter == 5'd8) begin
			counter <= counter+1;

			addr_we <= 0;
			if (ReadWrite == 1) begin // reading is selected
				miso <= 1;
				dm_we <= 0;
				sr_we <= 1; // if you're reading then SR has to load everything at the same time (parallel-y)
			end

			else begin // writing is selected
				miso <= 0;
				dm_we <= 1;
				sr_we <= 0;
			end 
		end
		else if (counter == 5'd9) begin
			sr_we <= 0;
		end
	end

	else begin
		counter <= 5'b0;
		miso <= 1'b0;
		dm_we <= 1'b0;
		sr_we <= 1'b0;
		addr_we <= 1'b0;
	end


end


endmodule