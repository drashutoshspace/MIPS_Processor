`timescale 1ns / 1ps

module ALU(
    input [31:0] input1,
    input [31:0] input2,
    input [3:0] ALU_control,
    output reg [31:0] ALU_result,
    output zero_flag
    );

    always @(*) begin
        case(ALU_control)
            4'b0000: ALU_result = input1 & input2;
            4'b0001: ALU_result = input1 | input2;
            4'b0010: ALU_result = input1 + input2;
            4'b0110: ALU_result = input1 - input2;
            4'b0111: ALU_result = (input1 < input2) ? 32'h00000001 : 32'h00000000;
            4'b1100: ALU_result = ~(input1 | input2);
            default: ALU_result = 32'h00000000;
        endcase
    end

    assign zero_flag = (ALU_result == 32'h00000000) ? 1'b1 : 1'b0;

endmodule
