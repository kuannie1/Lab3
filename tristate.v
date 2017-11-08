//------------------------------------------------------------------------
// SPI Memory Tri-State Component 
//	for miso_pin
//------------------------------------------------------------------------


module tristate

(
input				clk,
input               q,           
input               bufe,
output reg			out
);
    always @(posedge clk) begin
        if (bufe == 1)
            out <= q;
        else
        out <= 0'bZ;
    end

endmodule