`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/17 15:00:45
// Design Name: 
// Module Name: adder
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


module adder(
    input           clk,
    input           reset,
    input   [31:0]  a,
    input   [31:0]  b,
    output  [31:0]  c,
    output  [3:0]   web
    
    );
    assign c = a+b;
    assign web = |a;

endmodule
