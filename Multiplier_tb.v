`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2025 05:43:51 PM
// Design Name: 
// Module Name: Multiplier_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Multiplier_tb;

    reg clk;
    reg reset;

    wire [7:0] ram_out;
    wire [2:0] st_debug;

    // Instantiate the system
    Multiplier DUT (
        .clk      (clk),
        .reset    (reset),
        .ram_out  (ram_out),
        .st_debug (st_debug)
    );

    // Clock generation: 10ns period (100MHz)
    always begin
        #5 clk = ~clk;
    end

    initial begin
        // Initialize signals
        clk   = 0;
        reset = 1;

        // Hold reset for a few cycles
        #20;
        reset = 0;

        // Run long enough for full state sequence:
        // S0 -> S1 -> S2 -> S3 -> S4 -> back to S0
        #200;

        $display("Simulation finished.");
        $finish;
    end

endmodule

