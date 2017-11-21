//--------------------------------------------------------------------------------
//  SPI Memory -- FPGA with Pmod: Programming a shift register
//
//  Using the FPGA, you can either parrallel load a constant (b10100101)
//  or program using manual serial input. Serial input can be programmed by
//  setting the curent bit with switch 1, and indicating a write to the register
//  with switch 2.
//--------------------------------------------------------------------------------

`timescale 1ns / 1ps

`include "shiftregister.v"
`include "inputconditioner.v"


module midpoint(
    input           clk,
    input[3:0]      btn,
    input [3:0]     sw,
    output[3:0]     led,
    output[7:0]     je
    );

    wire serialDataOut;
    wire [7:0] parallelDataOut;
    wire conditioned1, PE2, NE0;

    assign je = parallelDataOut;
    assign led[0] = serialDataOut;
    assign  led[3:1] = 3'b0;


    inputconditioner ic0(.clk(clk),
                        .noisysignal(btn[0]),
                        .conditioned(),
                        .positiveedge(),
                        .negativeedge(NE0));
    inputconditioner ic1(.clk(clk),
                        .noisysignal(sw[0]),
                        .conditioned(conditioned1),
                        .positiveedge(),
                        .negativeedge());
    inputconditioner ic2(.clk(clk),
                        .noisysignal(sw[1]),
                        .conditioned(),
                        .positiveedge(PE2),
                        .negativeedge());

    shiftregister #(8) sr(.clk(clk), 
                       .peripheralClkEdge(PE2),
                       .parallelLoad(NE0), 
                       .parallelDataIn(8'hA5), 
                       .serialDataIn(conditioned1), 
                       .parallelDataOut(parallelDataOut), 
                       .serialDataOut(serialDataOut));
endmodule

