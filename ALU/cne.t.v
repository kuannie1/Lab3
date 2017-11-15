`include "cne.v"

// TODO: investigate, uncommenting this makes everything break.
// `timescale 1 ns / 1 ps

`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define NAND 3'd5
`define NOR  3'd6
`define OR   3'd7


 /* 
Module: testCNE
*/

module testCNE ();
    reg signed [31:0] a,b;
    wire[31:0] out;


    wire[31:0] xor_out;
    wire asdf;

    CNE cne(a, b, out);
    xor32 getxor(xor_out, a, b);
    zero_check checkxor(asdf, xor_out);

    initial begin 

    	a = 32'd10; b = 32'd10; #5000
        if (out != 32'b0) $display("Test 1 failed. a = %d b = %d out = %b", a, b, out);
        a = 32'd20; b = 32'd1; #5000
        if (out != 32'b1) $display("Test 2 failed. a = %d b = %d out = %b", a, b, out);

    end 
endmodule