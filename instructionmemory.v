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
  

  initial $readmemh("simpleasmtest/bne.txt", mem);

  assign DataOut = mem[Addr];
endmodule