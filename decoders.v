// 32 bit decoder with enable signal
//   enable=0: all output bits are 0
//   enable=1: out[address] is 1, all other outputs are 0
module decoder1to32
(
output[31:0]	out,
input		enable,
input[4:0]	address
);

    assign out = enable<<address; 

endmodule

//Description of how it works
/*
If you left-shift the enable bit (equals 1) by all the bit possibilities in address, the largest value you get is 32.
This helps you get all of the output possibilities you need in a decoder, all from 5 bits. 
*/