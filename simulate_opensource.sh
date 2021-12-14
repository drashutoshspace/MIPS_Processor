#!/bin/bash

echo "=========================================="
echo "MIPS Processor Simulation (Dec 2021)"
echo "=========================================="
echo "Simulating with Icarus Verilog..."

if ! command -v iverilog &> /dev/null
then
    echo "Icarus Verilog not found. Installing..."
    sudo apt-get update
    sudo apt-get install -y iverilog gtkwave
fi

cd "$(dirname "$0")"

echo "Compiling Verilog files..."
iverilog -o mips_sim.vvp \
    MIPS_Processor.srcs/sources_1/new/mux_2to1_32bit.v \
    MIPS_Processor.srcs/sources_1/new/mux_2to1_5bit.v \
    MIPS_Processor.srcs/sources_1/new/Sign_Extend.v \
    MIPS_Processor.srcs/sources_1/new/ALU.v \
    MIPS_Processor.srcs/sources_1/new/ALU_Control.v \
    MIPS_Processor.srcs/sources_1/new/Data_Memory.v \
    MIPS_Processor.srcs/sources_1/new/Register_File.v \
    MIPS_Processor.srcs/sources_1/new/Control_Unit.v \
    MIPS_Processor.srcs/sources_1/new/Instruction_Memory.v \
    MIPS_Processor.srcs/sources_1/new/PC.v \
    MIPS_Processor.srcs/sources_1/new/MIPS.v \
    MIPS_Processor.srcs/sim_1/new/MIPS_tb.v

if [ $? -eq 0 ]; then
    echo "Running simulation..."
    
    mkdir -p simulation_results
    
    vvp mips_sim.vvp | tee simulation_results/simulation_log.txt
    
    if [ -f mips_waveform.vcd ]; then
        TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
        cp mips_waveform.vcd simulation_results/mips_waveform_${TIMESTAMP}.vcd
        
        echo ""
        echo "=========================================="
        echo "Simulation complete!"
        echo "=========================================="
        echo "Results saved:"
        echo "  - Waveform: simulation_results/mips_waveform_${TIMESTAMP}.vcd"
        echo "  - Log: simulation_results/simulation_log.txt"
        echo ""
        echo "To view waveforms:"
        echo "  gtkwave simulation_results/mips_waveform_${TIMESTAMP}.vcd"
        echo ""
        
        ls -lh simulation_results/
    else
        echo "Warning: Waveform file not generated"
    fi
else
    echo "Compilation failed!"
    exit 1
fi
