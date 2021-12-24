`timescale 1ns / 1ps

module MIPS(
    input clk,
    input reset
    );

    wire [31:0] PC_out;
    wire [31:0] PC_in;
    wire [31:0] instruction;
    wire [31:0] reg1_data;
    wire [31:0] reg2_data;
    wire [31:0] write_data;
    wire [31:0] extended_immediate;
    wire [31:0] ALU_input2;
    wire [31:0] ALU_result;
    wire [31:0] data_memory_out;
    wire [31:0] PC_j;
    wire [31:0] PC_beq;
    wire [31:0] PC_plus4;
    wire [31:0] PC_bne;
    wire [5:0] opcode;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [4:0] shamt;
    wire [5:0] funct;
    wire [15:0] immediate;
    wire [25:0] address;
    wire [4:0] write_reg;
    wire [31:0] shifted_immediate;
    wire [31:0] shifted_jump;
    wire RegDst;
    wire Jump;
    wire Branch;
    wire MemRead;
    wire MemtoReg;
    wire [1:0] ALUOp;
    wire MemWrite;
    wire ALUSrc;
    wire RegWrite;
    wire zero_flag;
    wire [3:0] ALU_control;
    wire bne_control;
    wire beq_control;
    wire pc_select_beq;
    wire pc_select_bne;

    assign opcode = instruction[31:26];
    assign rs = instruction[25:21];
    assign rt = instruction[20:16];
    assign rd = instruction[15:11];
    assign shamt = instruction[10:6];
    assign funct = instruction[5:0];
    assign immediate = instruction[15:0];
    assign address = instruction[25:0];

    PC program_counter(
        .clk(clk),
        .reset(reset),
        .PC_in(PC_in),
        .PC_out(PC_out)
    );

    Instruction_Memory instruction_memory(
        .read_addr(PC_out),
        .instruction(instruction)
    );

    Control_Unit control_unit(
        .opcode(opcode),
        .RegDst(RegDst),
        .Jump(Jump),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .bne_control(bne_control)
    );

    mux_2to1_5bit mux_regdst(
        .in0(rt),
        .in1(rd),
        .sel(RegDst),
        .out(write_reg)
    );

    Register_File register_file(
        .clk(clk),
        .reset(reset),
        .RegWrite(RegWrite),
        .read_reg1(rs),
        .read_reg2(rt),
        .write_reg(write_reg),
        .write_data(write_data),
        .read_data1(reg1_data),
        .read_data2(reg2_data)
    );

    Sign_Extend sign_extend(
        .in(immediate),
        .out(extended_immediate)
    );

    mux_2to1_32bit mux_alusrc(
        .in0(reg2_data),
        .in1(extended_immediate),
        .sel(ALUSrc),
        .out(ALU_input2)
    );

    ALU_Control alu_control(
        .ALUOp(ALUOp),
        .funct(funct),
        .ALU_control(ALU_control)
    );

    ALU alu(
        .input1(reg1_data),
        .input2(ALU_input2),
        .ALU_control(ALU_control),
        .ALU_result(ALU_result),
        .zero_flag(zero_flag)
    );

    Data_Memory data_memory(
        .clk(clk),
        .reset(reset),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .address(ALU_result),
        .write_data(reg2_data),
        .read_data(data_memory_out)
    );

    mux_2to1_32bit mux_memtoreg(
        .in0(ALU_result),
        .in1(data_memory_out),
        .sel(MemtoReg),
        .out(write_data)
    );

    assign PC_plus4 = PC_out + 4;
    assign shifted_immediate = extended_immediate << 2;
    assign PC_beq = PC_plus4 + shifted_immediate;
    assign PC_bne = PC_plus4 + shifted_immediate;
    assign shifted_jump = {PC_plus4[31:28], address, 2'b00};

    assign beq_control = Branch & zero_flag;
    assign pc_select_beq = beq_control & ~bne_control;

    assign pc_select_bne = bne_control & ~zero_flag;

    mux_2to1_32bit mux_branch(
        .in0(PC_plus4),
        .in1(PC_beq),
        .sel(pc_select_beq),
        .out(PC_j)
    );

    wire [31:0] PC_after_bne;

    mux_2to1_32bit mux_bne(
        .in0(PC_j),
        .in1(PC_bne),
        .sel(pc_select_bne),
        .out(PC_after_bne)
    );

    mux_2to1_32bit mux_jump(
        .in0(PC_after_bne),
        .in1(shifted_jump),
        .sel(Jump),
        .out(PC_in)
    );

endmodule
