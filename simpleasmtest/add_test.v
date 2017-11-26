`include "./cpu.v"

//------------------------------------------------------------------------
// Simple CPU testbench sequence
//------------------------------------------------------------------------

module add_test ();

    reg clk;
    reg reset;
    reg [31:0] pc;

    // Clock generation
    initial clk=1;
    always #100 clk = !clk;

    // Instantiate fake CPU
    CPU cpu(.clk(clk), .reset(reset));

    reg [1023:0] mem_fn;
    reg [1023:0] dump_fn;

    // Test sequence
    initial begin
    // Dump waveforms to file
    // Note: arrays (e.g. memory) are not dumped by default
    $dumpfile("add.vcd");
    $dumpvars();


    // Load CPU memory from (assembly) dump file
    $readmemh(mem_fn, cpu.im.mem); #200;
    
    
    // Display a few cycles just for quick checking
    $display("Time |         pc | instruction|       Read 1 |   Rs  | Rt     | Rd     | exec result| wb result");
    repeat(2) begin
        $display("%4t | %d | %d |  %d  | %b | %b  | %b  | %d | %d ", $time, cpu.pc_out, cpu.instruction, cpu.read1, cpu.Rs, cpu.Rt, cpu.Rd, cpu.exec_result, cpu.wb_result);
        $display("");
        $display("data stored in Rt for addi: %d ", cpu.wd);#200;
    end
    $display("%4t | %d | %d |  %d  | %b | %b  | %b  | %d | %d ", $time, cpu.pc_out, cpu.instruction, cpu.read1, cpu.Rs, cpu.Rt, cpu.Rd, cpu.exec_result, cpu.wb_result); 
    $display("");
    $display("data stored in reg file to read: %d, %d ", cpu.read1, cpu.read2); 
    $display("");
    $display("alu_src: %d, op_code: %b, func: %b", cpu.ALU_src, cpu.op_code, cpu.func); 
    $display("");
    $display("two operands into ALU: %d, %d ", cpu.read1, cpu.operand2); #200;
    $display("... more execution (see waveform)");   


    // $display("Mem %d", cpu.datmem.memory[]);
    
    // End execution after some time delay - adjust to match your program
    // or use a smarter approach like looking for an exit syscall or the
    // PC to be the value of the last instruction in your program.
    #2000 $finish();
    end

endmodule


