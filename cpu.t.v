`include "cpu.v"

//------------------------------------------------------------------------
// simple CPU testbench
//------------------------------------------------------------------------

module cpu_test ();

    reg clk;
    reg reset;

    // Clock generation
    initial clk=0;
    always #100 clk = !clk;

    // Instantiate fake CPU
    CPU cpu(.clk(clk), .reset(reset));


    reg [1023:0] mem_fn;
    reg [1023:0] dump_fn;

    // Test sequence
    initial begin

	// Get command line arguments for memory image and VCD dump file
	//   http://iverilog.wikia.com/wiki/Simulation
	//   http://www.project-veripage.com/plusarg.php
	/*if (! $value$plusargs("mem_fn=%s", mem_fn)) begin
	    $display("ERROR: provide +mem_fn=[path to memory image] argument");
	    $finish();
        end
	if (! $value$plusargs("dump_fn=%s", dump_fn)) begin
	    $display("ERROR: provide +dump_fn=[path for VCD dump] argument");
	    $finish();
        end */


        // Load CPU memory from (assembly) dump file
	// $readmemh("mem_fn", cpu.im.mem);
        // Alternate: Explicitly state which array element range to read into
        //$readmemh("mymem.hex", memory, 10, 80);
	
	// Dump waveforms to file
	// Note: arrays (e.g. memory) are not dumped by default
	$dumpfile(dump_fn);
	$dumpvars();

	// Assert reset pulse
	reset = 0; #10;
	reset = 1; #10;
	reset = 0; #10;

	// Display a few cycles just for quick checking
	// Note: I'm just dumping instruction bits, but you can do some
	// self-checking test cases based on your CPU and program and
	// automatically report the results.
	// $display("mem_fn %h", mem_fn);
	$display("Time | PC       | Instruction");
	repeat(3) begin
        $display("%4t | %h | %h", $time, cpu.pc, cpu.instruction); #2000 ;
        end
	$display("... more execution (see waveform)");
    
	// End execution after some time delay - adjust to match your program
	// or use a smarter approach like looking for an exit syscall or the
	// PC to be the value of the last instruction in your program.
	#2000 $finish();
    end

endmodule
