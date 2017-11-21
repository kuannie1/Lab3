`include "cpu.v"

//------------------------------------------------------------------------
// Simple CPU testbench sequence
//------------------------------------------------------------------------

module cpu_test ();

    reg clk;
    reg reset;
    reg [31:0] pc;

    // Clock generation
    initial clk=0;
    always #200 clk = !clk;

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
    $display("Time | pc                               | instruction                         | ALU Op Code      |       Rs       | Rt     | Rd  ");
    repeat(10) begin

        $display("%4t | %b | %b    |  %b             |      %b     | %b  | %b", $time, cpu.pc_out, cpu.instruction, cpu.ALU_op, cpu.Rs, cpu.Rt, cpu.Rd); #400;
        end
    $display("... more execution (see waveform)");   

    
    // End execution after some time delay - adjust to match your program
    // or use a smarter approach like looking for an exit syscall or the
    // PC to be the value of the last instruction in your program.
    #8000 $finish();
    end

endmodule


