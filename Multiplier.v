`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2025 04:47:03 PM
// Design Name: 
// Module Name: Multiplier
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


module Multiplier (
    input        clk,
    input        reset,
    output [7:0] ram_out,    // for observing result in simulation / on board
    output [2:0] st_debug    // to see the state if needed
);

    // Control unit <-> rest of system signals
    wire        w_rf;
    wire [2:0]  rom_addr;
    wire        DA, SA, SB;
    wire [2:0]  st_out;
    wire [2:0]  ram_addr;
    wire        ram_we;

    // Datapath signals
    wire [3:0] rom_data;
    wire [3:0] rf_A, rf_B;
    wire [7:0] product;
    wire [7:0] ram_data_out;

    // ---------------- CU ----------------
    // Pick which ROM locations you want as operands:
    // e.g., adr1 = 3'd1, adr2 = 3'd2
    cu CU (
        .clk   (clk),
        .reset (reset),
        .adr1  (3'd1),     // first operand address in ROM
        .adr2  (3'd2),     // second operand address in ROM
        .w_rf  (w_rf),
        .adr   (rom_addr),
        .DA    (DA),
        .SA    (SA),
        .SB    (SB),
        .st_out(st_out),
        .w_ram (ram_addr)  // we'll use this as RAM address
    );

    // ---------------- ROM ----------------
    ROM ROM1 (
        .ROM_data(rom_data),
        .ROM_addr(rom_addr)
    );

    // ---------------- Register File ----------------
    RF RF1 (
        .A   (rf_A),
        .B   (rf_B),
        .SA  (SA),
        .SB  (SB),
        .D   (rom_data),
        .DA  (DA),
        .W   (w_rf),
        .rst (reset),
        .clk (clk)
    );

    // ---------------- Combinational Multiplier ----------------
    Comb_Mult MUL1 (
        .a (rf_A),
        .b (rf_B),
        .p (product)
    );

    // ---------------- RAM ----------------
    // Write enable is asserted only in the write state (st_out = 3'b100)
    assign ram_we = (st_out == 3'b100);

    RAM RAM1 (
        .i_clk       (clk),
        .i_rst       (reset),
        .i_write_en  (ram_we),
        .i_addr      (ram_addr),
        .i_write_data(product),
        .o_read_data (ram_data_out)
    );

    // ---------------- Outputs for observation ----------------
    assign ram_out  = ram_data_out;
    assign st_debug = st_out;

endmodule





