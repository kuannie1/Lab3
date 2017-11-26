/*
  Module for instruction memory.
  Based on Ben Hill's implementation of a basic memory.
*/

module instructionmemory
(
  input clk,
  input[11:0] Addr,
  output[31:0]  DataOut
);
  
  reg [31:0] mem[4095:0];  
  

  // change filename based on assembly .text file
  initial $readmemh("simpleasmtest/jal.txt", mem);
  // initial $readmemh("file.text", mem);

  assign DataOut = mem[Addr];
endmodule