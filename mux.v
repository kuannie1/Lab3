// define gates with delays
`define AND and #30
`define OR or #30
`define NOT not #10
`define NAND nand #20
`define NOR nor #20
`define XOR xor #30

//Behavioral Mux
module mux32to1by1(
	output       outputofmux,
	input[4:0]	address,
	input[31:0] inputsofmux
);
	assign outputofmux=inputsofmux[address];
endmodule

module mux32to1by32(
	output[31:0]  out,
	input[4:0]    address,
	input[31:0]   input0, input1, input2, input3, 
					input4, input5, input6, input7, 
					input8, input9, input10, input11,
					input12, input13, input14, input15,
					input16, input17, input18, input19,
					input20, input21, input22, input23,
					input24, input25, input26, input27,
					input28, input29, input30, input31
);

  wire[31:0] mux[31:0];			// Create a 2D array of wires
  assign mux[0] = input0;		// Connect the sources of the array
  assign mux[1] = input1;
  assign mux[2] = input2;
  assign mux[3] = input3;
  assign mux[4] = input4;
  assign mux[5] = input5;
  assign mux[6] = input6;
  assign mux[7] = input7;
  assign mux[8] = input8;
  assign mux[9] = input9;  
  assign mux[10] = input10;
  assign mux[11] = input11;
  assign mux[12] = input12;
  assign mux[13] = input13;
  assign mux[14] = input14;
  assign mux[15] = input15;
  assign mux[16] = input16;
  assign mux[17] = input17;
  assign mux[18] = input18;
  assign mux[19] = input19;
  assign mux[20] = input20;
  assign mux[21] = input21;
  assign mux[22] = input22;
  assign mux[23] = input23;
  assign mux[24] = input24;
  assign mux[25] = input25;
  assign mux[26] = input26;
  assign mux[27] = input27;
  assign mux[28] = input28;
  assign mux[29] = input29;
  assign mux[30] = input30;
  assign mux[31] = input31;

  assign out = mux[address];	// Connect the output of the array
endmodule



// /* 
// Module: not32
// Applies the NOT gate to each bit in input variable a
// Outputs each NOT gate result to the corresponding index in output variable out.
// */
// module not5(
//   output[4:0] out,
//   input[4:0] a
// );
// `NOT get0thbit(out[0],a[0]);
// `NOT get1thbit(out[1],a[1]);
// `NOT get2thbit(out[2],a[2]);
// `NOT get3thbit(out[3],a[3]);
// `NOT get4thbit(out[4],a[4]);
// endmodule
// Structural Mux
// module mux32to1by1(
// 	output      out,
// 	input[4:0]  address,
// 	input[31:0] inputs
// );
// wire[4:0] naddress;
// not5 negateaddress(naddress, address);

// wire[31:0] outputbits;
// // NOT-ing address[2], address[3], address[4]
// `AND outputbit0(outputbits[0], naddress[0], naddress[1], naddress[2], naddress[3], naddress[4]);
// `AND outputbit1(outputbits[1], naddress[0], address[1], naddress[2], naddress[3], naddress[4]);
// `AND outputbit2(outputbits[2], address[0], naddress[1], naddress[2], naddress[3], naddress[4]);
// `AND outputbit3(outputbits[3], address[0], address[1], naddress[2], naddress[3], naddress[4]);

// // Same thing from above but with address[2] rather than naddress[2]
// `AND outputbit4(outputbits[4], naddress[0], naddress[1], address[2], naddress[3], naddress[4]);
// `AND outputbit5(outputbits[5], naddress[0], address[1], address[2], naddress[3], naddress[4]);
// `AND outputbit6(outputbits[6], address[0], naddress[1], address[2], naddress[3], naddress[4]);
// `AND outputbit7(outputbits[7], address[0], address[1], address[2], naddress[3], naddress[4]);

// // Same thing as above but with address[3] rather than naddress[3]
// `AND outputbit8(outputbits[8], naddress[0], naddress[1], naddress[2], address[3], naddress[4]);
// `AND outputbit9(outputbits[9], naddress[0], address[1], naddress[2], address[3], naddress[4]);
// `AND outputbit10(outputbits[10], address[0], naddress[1], naddress[2], address[3], naddress[4]);
// `AND outputbit11(outputbits[11], address[0], address[1], naddress[2], address[3], naddress[4]);
// `AND outputbit12(outputbits[12], naddress[0], naddress[1], address[2], address[3], naddress[4]);
// `AND outputbit13(outputbits[13], naddress[0], address[1], address[2], address[3], naddress[4]);
// `AND outputbit14(outputbits[14], address[0], naddress[1], address[2], address[3], naddress[4]);
// `AND outputbit15(outputbits[15], address[0], address[1], address[2], address[3], naddress[4]);

// // Same thing as all of this above junk but with address[4] rather than naddress[4]
// `AND outputbit16(outputbits[16], naddress[0], naddress[1], naddress[2], naddress[3], address[4]);
// `AND outputbit17(outputbits[17], naddress[0], address[1], naddress[2], naddress[3], address[4]);
// `AND outputbit18(outputbits[18], address[0], naddress[1], naddress[2], naddress[3], address[4]);
// `AND outputbit19(outputbits[19], address[0], address[1], naddress[2], naddress[3], address[4]);
// `AND outputbit20(outputbits[20], naddress[0], naddress[1], address[2], naddress[3], address[4]);
// `AND outputbit21(outputbits[21], naddress[0], address[1], address[2], naddress[3], address[4]);
// `AND outputbit22(outputbits[22], address[0], naddress[1], address[2], naddress[3], address[4]);
// `AND outputbit23(outputbits[23], address[0], address[1], address[2], naddress[3], address[4]);
// `AND outputbit24(outputbits[24], naddress[0], naddress[1], naddress[2], address[3], address[4]);
// `AND outputbit25(outputbits[25], naddress[0], address[1], naddress[2], address[3], address[4]);
// `AND outputbit26(outputbits[26], address[0], naddress[1], naddress[2], address[3], address[4]);
// `AND outputbit27(outputbits[27], address[0], address[1], naddress[2], address[3], address[4]);
// `AND outputbit28(outputbits[28], naddress[0], naddress[1], address[2], address[3], address[4]);
// `AND outputbit29(outputbits[29], naddress[0], address[1], address[2], address[3], address[4]);
// `AND outputbit30(outputbits[30], address[0], naddress[1], address[2], address[3], address[4]);
// `AND outputbit31(outputbits[31], address[0], address[1], address[2], address[3], address[4]);

// wire[31:0] inputs;
// // now based on these output bits, we and corresponding bits with the input bits
// `AND getinput(inputs[0], in0, outputbits[0]);
// `AND getinput1(inputs[1], in1, outputbits[1]);
// `AND getinput2(inputs[2], in2, outputbits[2]);
// `AND getinput3(inputs[3], in3, outputbits[3]);
// `AND getinput4(inputs[4], in4, outputbits[4]);
// `AND getinput5(inputs[5], in5, outputbits[5]);
// `AND getinput6(inputs[6], in6, outputbits[6]);
// `AND getinput7(inputs[7], in7, outputbits[7]);
// `AND getinput8(inputs[8], in8, outputbits[8]);
// `AND getinput9(inputs[9], in9, outputbits[9]);
// `AND getinput10(inputs[10], in10, outputbits[10]);
// `AND getinput11(inputs[11], in11, outputbits[11]);
// `AND getinput12(inputs[12], in12, outputbits[12]);
// `AND getinput13(inputs[13], in13, outputbits[13]);
// `AND getinput14(inputs[14], in14, outputbits[14]);
// `AND getinput15(inputs[15], in15, outputbits[15]);
// `AND getinput16(inputs[16], in16, outputbits[16]);
// `AND getinput17(inputs[17], in17, outputbits[17]);
// `AND getinput18(inputs[18], in18, outputbits[18]);
// `AND getinput19(inputs[19], in19, outputbits[19]);
// `AND getinput20(inputs[20], in20, outputbits[20]);
// `AND getinput21(inputs[21], in21, outputbits[21]);
// `AND getinput22(inputs[22], in22, outputbits[22]);
// `AND getinput23(inputs[23], in23, outputbits[23]);
// `AND getinput24(inputs[24], in24, outputbits[24]);
// `AND getinput25(inputs[25], in25, outputbits[25]);
// `AND getinput26(inputs[26], in26, outputbits[26]);
// `AND getinput27(inputs[27], in27, outputbits[27]);
// `AND getinput28(inputs[28], in28, outputbits[28]);
// `AND getinput29(inputs[29], in29, outputbits[29]);
// `AND getinput30(inputs[30], in30, outputbits[30]);
// `AND getinput31(inputs[31], in31, outputbits[31]);

// //Now you finally get an output by `ANDing everything
// `AND getoutput(out, inputs[0], inputs[1], inputs[2], inputs[3], 
// 				inputs[4], inputs[5], inputs[6], inputs[7], 
// 				inputs[8],inputs[9], inputs[10], inputs[11], 
// 				inputs[12], inputs[13], inputs[14], inputs[15], 
// 				inputs[16], inputs[17], inputs[18], inputs[19], 
// 				inputs[20], inputs[21], inputs[22], inputs[23], 
// 				inputs[24], inputs[25], inputs[26], inputs[27], 
// 				inputs[28], inputs[29], inputs[30], inputs[31]);

// endmodule