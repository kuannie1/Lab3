// define gates with delays
`define AND and #30
`define OR or #30
`define NOT not #10
`define NAND nand #20
`define NOR nor #20
`define XOR xor #30

// Single-bit D Flip-Flop with enable
//   Positive edge triggered
module register
(
output reg	q,
input		d,
input		wrenable,
input		clk
);

    always @(posedge clk) begin
        if(wrenable) begin
            q = d;
        end
    end

endmodule

// 32-bit D Flip-Flop with enable
// 		Positive edge triggered
module register32
(
output[31:0] 	q,
input[31:0]		d,
input		wrenable,
input		clk
);

register getbit0(q[0], d[0], wrenable, clk);
register getbit1(q[1], d[1], wrenable, clk);
register getbit2(q[2], d[2], wrenable, clk);
register getbit3(q[3], d[3], wrenable, clk);
register getbit4(q[4], d[4], wrenable, clk);
register getbit5(q[5], d[5], wrenable, clk);
register getbit6(q[6], d[6], wrenable, clk);
register getbit7(q[7], d[7], wrenable, clk);
register getbit8(q[8], d[8], wrenable, clk);
register getbit9(q[9], d[9], wrenable, clk);
register getbit10(q[10], d[10], wrenable, clk);
register getbit11(q[11], d[11], wrenable, clk);
register getbit12(q[12], d[12], wrenable, clk);
register getbit13(q[13], d[13], wrenable, clk);
register getbit14(q[14], d[14], wrenable, clk);
register getbit15(q[15], d[15], wrenable, clk);
register getbit16(q[16], d[16], wrenable, clk);
register getbit17(q[17], d[17], wrenable, clk);
register getbit18(q[18], d[18], wrenable, clk);
register getbit19(q[19], d[19], wrenable, clk);
register getbit20(q[20], d[20], wrenable, clk);
register getbit21(q[21], d[21], wrenable, clk);
register getbit22(q[22], d[22], wrenable, clk);
register getbit23(q[23], d[23], wrenable, clk);
register getbit24(q[24], d[24], wrenable, clk);
register getbit25(q[25], d[25], wrenable, clk);
register getbit26(q[26], d[26], wrenable, clk);
register getbit27(q[27], d[27], wrenable, clk);
register getbit28(q[28], d[28], wrenable, clk);
register getbit29(q[29], d[29], wrenable, clk);
register getbit30(q[30], d[30], wrenable, clk);
register getbit31(q[31], d[31], wrenable, clk);

endmodule

module register32zero
(
output[31:0] 	q,
input[31:0]		d,
input		wrenable,
input		clk
);
assign q = 32'b0;

endmodule

