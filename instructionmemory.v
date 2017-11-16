/*
  Module for instruction memory.
  Based on Ben Hill's implementation of a basic memory.
*/

module instructionmemory
(
  input clk,
  input[9:0] Addr,
  output[31:0]  DataOut
);
  
  reg [31:0] mem[4095:0];  
  
  // change filename based on assembly .dat file
  initial $readmemh(file.dat, mem);
    
  assign DataOut = mem[Addr];
endmodule