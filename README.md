# MIPS Processor Verilog Project Test

A single-cycle MIPS processor implementation in Verilog for Vivado.

**Project Date:** December 2021

## Project Structure

- `MIPS_Processor.srcs/sources_1/new/` - Verilog source files
  - `MIPS.v` - Top-level MIPS processor module
  - `PC.v` - Program Counter
  - `Instruction_Memory.v` - Instruction memory module
  - `Control_Unit.v` - Main control unit
  - `Register_File.v` - 32 general-purpose registers
  - `ALU.v` - Arithmetic Logic Unit
  - `ALU_Control.v` - ALU control logic
  - `Data_Memory.v` - Data memory module
  - `Sign_Extend.v` - Sign extension unit
  - `mux_2to1_5bit.v` - 5-bit 2-to-1 multiplexer
  - `mux_2to1_32bit.v` - 32-bit 2-to-1 multiplexer

- `MIPS_Processor.srcs/constrs_1/new/` - Constraint files
  - `constraints.xdc` - Pin assignments and timing constraints

- `MIPS_Processor.srcs/sim_1/new/` - Simulation files
  - `MIPS_tb.v` - Testbench for MIPS processor

## Supported Instructions

- R-type: ADD, SUB, AND, OR, SLT
- I-type: ADDI, LW, SW, BEQ, BNE
- J-type: J (Jump)

## Features

- Single-cycle implementation
- 32-bit architecture
- Harvard architecture (separate instruction and data memory)
- Supports basic MIPS instruction set

## Opening in Vivado

1. Open Vivado
2. File -> Open Project
3. Select `MIPS_Processor.xpr`

## Running Simulation

1. In Vivado, go to Flow Navigator
2. Click "Run Simulation" -> "Run Behavioral Simulation"
3. The testbench will execute the program in instruction memory

## Synthesis and Implementation

1. Click "Run Synthesis" in Flow Navigator
2. After synthesis completes, click "Run Implementation"
3. Generate bitstream for FPGA programming

## Target Device

**Board**: Digilent Nexys A7-100T (formerly Nexys 4 DDR)
**FPGA**: Artix-7 xc7a100tcsg324-1

### Pin Mapping for Nexys A7:
- Clock (100MHz): E3
- Reset (CPU Reset button): C12
