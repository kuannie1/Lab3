//------------------------------------------------------------------------
// SPI Shift Register
//   Parameterized width (in bits)
//   Shift register can operate in two modes:
//      - serial in, parallel out
//      - parallel in, serial out
//------------------------------------------------------------------------

module dff
(
   	input clk,
    input we,
    input [31:0] dataIn,
    output reg [31:0] dataOut
);

    always @(posedge clk) begin
        if(we) begin
            dataOut <= dataIn;
        end
    end

endmodule