`include "cpu.v"

//------------------------------------------------------------------------
// Simple fake CPU testbench sequence
//------------------------------------------------------------------------

module cpu_test ();

    reg clk;
    reg reset;
    reg [31:0] pc;

    // Clock generation
    initial clk=0;
    always #10 clk = !clk;

    // Instantiate fake CPU
    CPU cpu(.clk(clk), .reset(reset));

    reg [1023:0] mem_fn;
    reg [1023:0] dump_fn;

    // Test sequence
    initial begin

    // pc = 32'b0; #1000

	// Get command line arguments for memory image and VCD dump file
	//   http://iverilog.wikia.com/wiki/Simulation
	//   http://www.project-veripage.com/plusarg.php
	// if (! $value$plusargs("mem_fn=%s", mem_fn)) begin
	//     $display("ERROR: provide +mem_fn=[path to memory image] argument");
	//     $finish();
 //        end
	// if (! $value$plusargs("dump_fn=%s", dump_fn)) begin
	//     $display("ERROR: provide +dump_fn=[path for VCD dump] argument");
	//     $finish();
 //        end`


        // Load CPU memory from (assembly) dump file
	$readmemh(mem_fn, cpu.im.mem);
        // Alternate: Explicitly state which array element range to read into
        // $readmemh("mymem.hex", memory);
	
	// Dump waveforms to file
	// Note: arrays (e.g. memory) are not dumped by default
	$dumpfile("cpu.vcd");
	$dumpvars();

	// Assert reset pulse
	reset = 0; #10;
	reset = 1; #10;
	reset = 0; #10;

	// Display a few cycles just for quick checking
	// Note: I'm just dumping instruction bits, but you can do some
	// self-checking test cases based on your CPU and program and
	// automatically report the results.
	$display("Time | pc       | ALU_op"); #300
	repeat(10) begin
        $display("%4t | %b | %h", $time, cpu.pc_out, cpu.instruction); #20 ;
        end
	$display("... more execution (see waveform)");
    
	// End execution after some time delay - adjust to match your program
	// or use a smarter approach like looking for an exit syscall or the
	// PC to be the value of the last instruction in your program.
	#2000 $finish();
    end

endmodule


