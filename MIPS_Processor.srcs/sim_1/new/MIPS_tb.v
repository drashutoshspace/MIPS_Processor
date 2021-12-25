`timescale 1ns / 1ps

module MIPS_tb;

    reg clk;
    reg reset;
    integer cycle_count;

    MIPS uut (
        .clk(clk),
        .reset(reset)
    );

    initial begin
        $dumpfile("mips_waveform.vcd");
        $dumpvars(0, MIPS_tb);
        
        $display("========================================");
        $display("MIPS Processor Simulation");
        $display("December 2021");
        $display("========================================");
        $display("Time: %0t", $time);
    end

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    always @(posedge clk) begin
        if (!reset) begin
            cycle_count = cycle_count + 1;
            $display("Cycle %0d: PC=%h, Instruction=%h", 
                     cycle_count, uut.PC_out, uut.instruction);
        end
    end

    initial begin
        cycle_count = 0;
        reset = 1;
        
        $display("\n--- TEST CASE 1: Reset Sequence ---");
        #15;
        reset = 0;
        $display("Reset released at time %0t", $time);
        
        $display("\n--- TEST CASE 2: Instruction Execution ---");
        #200;
        
        $display("\n--- TEST CASE 3: Register File State ---");
        $display("Register $2 = %h", uut.register_file.registers[2]);
        $display("Register $3 = %h", uut.register_file.registers[3]);
        $display("Register $4 = %h", uut.register_file.registers[4]);
        $display("Register $5 = %h", uut.register_file.registers[5]);
        $display("Register $7 = %h", uut.register_file.registers[7]);
        
        #300;
        
        $display("\n========================================");
        $display("MIPS Processor Simulation Completed");
        $display("========================================");
        $display("Total Cycles: %0d", cycle_count);
        $display("Total Time: %0t", $time);
        $display("Waveform saved to: mips_waveform.vcd");
        $finish;
    end

endmodule
