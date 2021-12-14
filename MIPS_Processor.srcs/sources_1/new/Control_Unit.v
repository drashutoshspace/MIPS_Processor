`timescale 1ns / 1ps

module Control_Unit(
    input [5:0] opcode,
    output reg RegDst,
    output reg Jump,
    output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg [1:0] ALUOp,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite,
    output reg bne_control
    );

    always @(*) begin
        case(opcode)
            6'b000000: begin
                RegDst = 1'b1;
                ALUSrc = 1'b0;
                MemtoReg = 1'b0;
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                Branch = 1'b0;
                ALUOp = 2'b10;
                Jump = 1'b0;
                bne_control = 1'b0;
            end
            6'b100011: begin
                RegDst = 1'b0;
                ALUSrc = 1'b1;
                MemtoReg = 1'b1;
                RegWrite = 1'b1;
                MemRead = 1'b1;
                MemWrite = 1'b0;
                Branch = 1'b0;
                ALUOp = 2'b00;
                Jump = 1'b0;
                bne_control = 1'b0;
            end
            6'b101011: begin
                RegDst = 1'b0;
                ALUSrc = 1'b1;
                MemtoReg = 1'b0;
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b1;
                Branch = 1'b0;
                ALUOp = 2'b00;
                Jump = 1'b0;
                bne_control = 1'b0;
            end
            6'b000100: begin
                RegDst = 1'b0;
                ALUSrc = 1'b0;
                MemtoReg = 1'b0;
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                Branch = 1'b1;
                ALUOp = 2'b01;
                Jump = 1'b0;
                bne_control = 1'b0;
            end
            6'b000101: begin
                RegDst = 1'b0;
                ALUSrc = 1'b0;
                MemtoReg = 1'b0;
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                Branch = 1'b1;
                ALUOp = 2'b01;
                Jump = 1'b0;
                bne_control = 1'b1;
            end
            6'b001000: begin
                RegDst = 1'b0;
                ALUSrc = 1'b1;
                MemtoReg = 1'b0;
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                Branch = 1'b0;
                ALUOp = 2'b00;
                Jump = 1'b0;
                bne_control = 1'b0;
            end
            6'b000010: begin
                RegDst = 1'b0;
                ALUSrc = 1'b0;
                MemtoReg = 1'b0;
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                Branch = 1'b0;
                ALUOp = 2'b00;
                Jump = 1'b1;
                bne_control = 1'b0;
            end
            default: begin
                RegDst = 1'b0;
                ALUSrc = 1'b0;
                MemtoReg = 1'b0;
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                Branch = 1'b0;
                ALUOp = 2'b00;
                Jump = 1'b0;
                bne_control = 1'b0;
            end
        endcase
    end

endmodule
