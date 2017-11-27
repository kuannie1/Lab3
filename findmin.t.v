`include "cpu.v"

//------------------------------------------------------------------------
// Simple CPU testbench sequence
//------------------------------------------------------------------------

module findmin_test ();

    reg clk;
    reg reset;
    reg [31:0] pc;

    // Clock generation
    initial clk=1;
    always #200 clk = !clk;

    // Instantiate fake CPU
    CPU cpu(.clk(clk), .reset(reset));

    reg [1023:0] mem_fn;
    reg [1023:0] dump_fn;

    // Test sequence
    initial begin
    // Dump waveforms to file
    // Note: arrays (e.g. memory) are not dumped by default
    $dumpfile("findmin.vcd");
    $dumpvars();


    // Load CPU memory from (assembly) dump file
    $readmemh(mem_fn, cpu.im.mem); #200;
    // addi lines -- getting the assigned values
    if (cpu.exec_result != 14)
    $display("exec_result returns wrong value. exec_result: %d", cpu.exec_result); #400

    if (cpu.exec_result != 5)
    $display("exec_result returns wrong value. exec_result: %d", cpu.exec_result); #400

    if (cpu.exec_result != 7)
    $display("exec_result returns wrong value. exec_result: %d", cpu.exec_result); #400

    if (cpu.exec_result != 10)
    $display("exec_result returns wrong value. exec_result: %d", cpu.exec_result); #400

    // new stage: getting the minimum value in findmin.asm
    if (cpu.exec_result != 14)
    $display("exec_result returns wrong value. exec_result: %d", cpu.exec_result); #400

    if (cpu.exec_result != 0) // initializing t1
    $display("exec_result returns wrong value. exec_result: %d", cpu.exec_result); #400

    if (cpu.exec_result != 0) // because 14 is not less than 5, reassign to 5
    $display("exec_result returns wrong value. exec_result: %d", cpu.exec_result); #400

    if (cpu.exec_result != 1) // because 5 (Current minimum) is less than 7
    $display("exec_result returns wrong value. exec_result: %d", cpu.exec_result); #400

    // End execution after some time delay - adjust to match your program
    // or use a smarter approach like looking for an exit syscall or the
    // PC to be the value of the last instruction in your program.
    #5000 $finish();
    end

endmodule


