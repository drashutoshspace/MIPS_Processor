`timescale 1ns / 1ps

module Data_Memory(
    input clk,
    input reset,
    input MemWrite,
    input MemRead,
    input [31:0] address,
    input [31:0] write_data,
    output [31:0] read_data
    );

    reg [31:0] memory [0:127];
    integer i;

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            for(i = 0; i < 128; i = i + 1) begin
                memory[i] <= 32'h00000000;
            end
        end
        else if(MemWrite) begin
            memory[address[31:2]] <= write_data;
        end
    end

    assign read_data = (MemRead) ? memory[address[31:2]] : 32'h00000000;

endmodule
