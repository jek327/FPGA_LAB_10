# FPGA_LAB_10

Project Description: 
The system consists of a ROM holding the input values, a combinational multiplier that computes their product, a RAM module that stores the output, and a control unit that manages addresses, enables, and timing. During execution, the control unit reads operands from ROM, triggers the multiplier, and writes the computed result into RAM at the correct location. All modules—ROM, RAM, multiplier, and controller—are connected within a top-level design, and a testbench is used to verify that the read–multiply–write cycle behaves correctly.

Instructions for Simulation and FPGA Implementation:
To simulate the design, compile all Verilog modules and the testbench, apply appropriate ROM addresses, and verify that the ROM outputs feed the multiplier and that the resulting product is correctly written to RAM. For FPGA implementation, synthesize the design, resolve any timing or resource warnings, assign pins for clock, reset, switches, and LEDs (or 7-segment display), generate the bitstream, and program the board. After downloading the design to the FPGA, verify correct functionality by observing the multiplier’s output on LEDs or the display while ensuring the control unit completes the full read–compute–write cycle.
