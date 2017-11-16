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
  
  // change filename based on assembly .text file
  //initial $readmemh("file.text", mem);
  //
  initial begin
  	mem[0] <= 32'b00100000000001000000000000000100;
  	mem[1] <= 32'b00100000000001010000000000001010;
  end
    
  assign DataOut = mem[Addr];
endmodule