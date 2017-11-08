`include "decoders.v"
`include "register.v"
`include "mux.v"

//------------------------------------------------------------------------------
// MIPS register file
//   width: 32 bits
//   depth: 32 words (reg[0] is static zero register)
//   2 asynchronous read ports
//   1 synchronous, positive edge triggered write port
//------------------------------------------------------------------------------

module regfile
(
output[31:0]	ReadData1,	// Contents of first register read
output[31:0]	ReadData2,	// Contents of second register read
input[31:0]		WriteData,	// Contents to write to register
input[4:0]		ReadRegister1,	// Address of first register to read
input[4:0]		ReadRegister2,	// Address of second register to read
input[4:0]		WriteRegister,	// Address of register to write
input			RegWrite,	// Enable writing of register when High
input			Clk		// Clock (Positive Edge Triggered)
);
  wire[31:0] selectregister;
  decoder1to32 decoder(selectregister, RegWrite, WriteRegister); // Not sure if WriteRegister is the input variable to use

  wire[31:0] q0, q1, q2, q3,
  			q4, q5, q6, q7,
  			q8, q9, q10, q11,
  			q12, q13, q14, q15,
  			q16, q17, q18, q19,
  			q20, q21, q22, q23,
  			q24, q25, q26, q27,
  			q28, q29, q30, q31;

  register32zero register0(q0, WriteData, selectregister[0], Clk);
  register32 register1( q1,  WriteData, selectregister[1], Clk);
  register32 register2( q2,  WriteData, selectregister[2], Clk);
  register32 register3( q3,  WriteData, selectregister[3], Clk);
  register32 register4( q4,  WriteData, selectregister[4], Clk);
  register32 register5( q5,  WriteData, selectregister[5], Clk);
  register32 register6( q6,  WriteData, selectregister[6], Clk);
  register32 register7( q7,  WriteData, selectregister[7], Clk);
  register32 register8( q8,  WriteData, selectregister[8], Clk);
  register32 register9( q9,  WriteData, selectregister[9], Clk);
  register32 register10(q10, WriteData, selectregister[10], Clk);
  register32 register11(q11, WriteData, selectregister[11], Clk);
  register32 register12(q12, WriteData, selectregister[12], Clk);
  register32 register13(q13, WriteData, selectregister[13], Clk);
  register32 register14(q14, WriteData, selectregister[14], Clk);
  register32 register15(q15, WriteData, selectregister[15], Clk);
  register32 register16(q16, WriteData, selectregister[16], Clk);
  register32 register17(q17, WriteData, selectregister[17], Clk);
  register32 register18(q18, WriteData, selectregister[18], Clk);
  register32 register19(q19, WriteData, selectregister[19], Clk);
  register32 register20(q20, WriteData, selectregister[20], Clk);
  register32 register21(q21, WriteData, selectregister[21], Clk);
  register32 register22(q22, WriteData, selectregister[22], Clk);
  register32 register23(q23, WriteData, selectregister[23], Clk);
  register32 register24(q24, WriteData, selectregister[24], Clk);
  register32 register25(q25, WriteData, selectregister[25], Clk);
  register32 register26(q26, WriteData, selectregister[26], Clk);
  register32 register27(q27, WriteData, selectregister[27], Clk);
  register32 register28(q28, WriteData, selectregister[28], Clk);
  register32 register29(q29, WriteData, selectregister[29], Clk);
  register32 register30(q30, WriteData, selectregister[30], Clk);
  register32 register31(q31, WriteData, selectregister[31], Clk);

  mux32to1by32 mux1(ReadData1, ReadRegister1, q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q25, q26, q27, q28, q29, q30, q31);
  mux32to1by32 mux2(ReadData2, ReadRegister2, q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q25, q26, q27, q28, q29, q30, q31);

endmodule


// one register file for cases where all registers have something in it

// one register file for cases where decoder returns all 1s? Like 

// one register file where register 0 returns something instead of all 0s

// one register file where port x of decoder always returns the wrong register file