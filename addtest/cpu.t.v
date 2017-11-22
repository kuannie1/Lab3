`include "cpu.v"

//------------------------------------------------------------------------
// Simple CPU testbench sequence
//------------------------------------------------------------------------

module cpu_test ();

    reg clk;
    reg reset;
    reg [31:0] pc;

    // Clock generation
    initial clk=1;
    always #300 clk = !clk;

    // Instantiate fake CPU
    CPU cpu(.clk(clk), .reset(reset));

    reg [1023:0] mem_fn;
    reg [1023:0] dump_fn;

    // Test sequence
    initial begin
    // Dump waveforms to file
    // Note: arrays (e.g. memory) are not dumped by default
    $dumpfile("cpu.vcd");
    $dumpvars();


    // Load CPU memory from (assembly) dump file
    $readmemh(mem_fn, cpu.im.mem); #200;
    
    


    // Display a few cycles just for quick checking 
    $display("Time |         pc |      instruction                    | Read 1       |   Rs       | Rt     | Rd     | exec result ");
    repeat(10) begin

        $display("%4t | %d | %b    |  %d  |   %b    | %b  | %b  | %d ", $time, cpu.pc_out, cpu.instruction, cpu.read1, cpu.Rs, cpu.Rt, cpu.Rd, cpu.exec_result); #400;
        end
    $display("... more execution (see waveform)");   

    
    // End execution after some time delay - adjust to match your program
    // or use a smarter approach like looking for an exit syscall or the
    // PC to be the value of the last instruction in your program.
    #8000 $finish();
    end

endmodule
