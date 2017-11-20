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

    // pc = 32'b0; #1000
        // Load CPU memory from (assembly) dump file
	$readmemh(mem_fn, cpu.im.mem);
        // Alternate: Explicitly state which array element range to read into
        // $readmemh("mymem.hex", memory);
	
	// Dump waveforms to file
	// Note: arrays (e.g. memory) are not dumped by default
	$dumpfile("cpu.vcd");
	$dumpvars();


	// Display a few cycles just for quick checking
	$display("Time | pc       | ALU_op");
	repeat(10) begin
        $display("%4t | %b | %h", $time, cpu.pc_out, cpu.instruction); #400 ;
        end
	$display("... more execution (see waveform)");
    
	// End execution after some time delay - adjust to match your program
	// or use a smarter approach like looking for an exit syscall or the
	// PC to be the value of the last instruction in your program.
	#2000 $finish();
    end

endmodule


