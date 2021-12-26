set project_name "MIPS_Processor"
set project_dir [file dirname [info script]]

puts "MIPS Processor - Vivado Project Creation"
puts "December 2021"
puts ""

create_project ${project_name} ${project_dir} -part xc7a100tcsg324-1 -force

set_property board_part digilentinc.com:nexys-a7-100t:part0:1.2 [current_project]
set_property target_language Verilog [current_project]
set_property simulator_language Verilog [current_project]

add_files -norecurse {
    MIPS_Processor.srcs/sources_1/new/mux_2to1_32bit.v
    MIPS_Processor.srcs/sources_1/new/mux_2to1_5bit.v
    MIPS_Processor.srcs/sources_1/new/Sign_Extend.v
    MIPS_Processor.srcs/sources_1/new/ALU.v
    MIPS_Processor.srcs/sources_1/new/ALU_Control.v
    MIPS_Processor.srcs/sources_1/new/Data_Memory.v
    MIPS_Processor.srcs/sources_1/new/Register_File.v
    MIPS_Processor.srcs/sources_1/new/Control_Unit.v
    MIPS_Processor.srcs/sources_1/new/Instruction_Memory.v
    MIPS_Processor.srcs/sources_1/new/PC.v
    MIPS_Processor.srcs/sources_1/new/MIPS.v
}

update_compile_order -fileset sources_1

set_property top MIPS [current_fileset]

add_files -fileset constrs_1 -norecurse MIPS_Processor.srcs/constrs_1/new/constraints.xdc

add_files -fileset sim_1 -norecurse MIPS_Processor.srcs/sim_1/new/MIPS_tb.v

update_compile_order -fileset sim_1

set_property top MIPS_tb [get_filesets sim_1]
set_property top_lib xil_defaultlib [get_filesets sim_1]

puts "Project creation completed successfully!"
