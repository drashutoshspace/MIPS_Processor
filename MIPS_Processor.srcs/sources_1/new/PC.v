`timescale 1ns / 1ps

module PC(
    input clk,
    input reset,
    input [31:0] PC_in,
    output reg [31:0] PC_out
    );

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            PC_out <= 32'h00000000;
        end
        else begin
            PC_out <= PC_in;
        end
    end

endmodule
