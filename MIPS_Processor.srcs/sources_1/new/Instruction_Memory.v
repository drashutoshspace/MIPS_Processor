`timescale 1ns / 1ps

module Instruction_Memory(
    input [31:0] read_addr,
    output [31:0] instruction
    );

    reg [31:0] memory [0:127];

    initial begin
        memory[0] = 32'h20020005;
        memory[1] = 32'h2003000c;
        memory[2] = 32'h2067fff7;
        memory[3] = 32'h00e22025;
        memory[4] = 32'h00642824;
        memory[5] = 32'h00a42820;
        memory[6] = 32'h10a7000a;
        memory[7] = 32'h0064202a;
        memory[8] = 32'h10800001;
        memory[9] = 32'h20050000;
        memory[10] = 32'h00e2202a;
        memory[11] = 32'h00853820;
        memory[12] = 32'h00e23822;
        memory[13] = 32'hac670044;
        memory[14] = 32'h8c020050;
        memory[15] = 32'h08000011;
        memory[16] = 32'h20020001;
        memory[17] = 32'hac020054;
        memory[18] = 32'h08000012;
    end

    assign instruction = memory[read_addr[31:2]];

endmodule
