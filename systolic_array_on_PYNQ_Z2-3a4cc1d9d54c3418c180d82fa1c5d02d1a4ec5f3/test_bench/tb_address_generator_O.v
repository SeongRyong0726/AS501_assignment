`timescale 100ns/1ns
module tb_address_gerator_O #(
    parameter integer RAM_O_SIZE = 1<<8,
    parameter integer ARRAY_M     = 8,
    parameter integer ADDR_WIDTH = $clog2(RAM_O_SIZE), 
    parameter integer ADDR_SET_WIDTH = ADDR_WIDTH * ARRAY_M,

    parameter integer T_NUM_COLS = 8,
    parameter integer T_BASE_ADDR = 16,
    parameter integer T_DEPTH =     8
);
    reg clk;
    reg reset;
    reg on;
    reg [$clog2(ARRAY_M) : 0]   num_cols;
    reg [ADDR_WIDTH -1 : 0]     base_addr;

    wire [ADDR_SET_WIDTH -1 : 0]     addr_set;
    wire [ARRAY_M - 1 : 0]       enable_set;

    address_generator_O #(
        .RAM_O_SIZE(RAM_O_SIZE),
        .ARRAY_M(ARRAY_M),
        .ADDR_WIDTH(ADDR_WIDTH),
        .ADDR_SET_WIDTH(ADDR_SET_WIDTH)
    ) ag_o (
        .clk(clk),
        .reset(reset),
        .on(on),
        .num_cols(num_cols),
        .base_addr(base_addr),
        .addr_set(addr_set),
        .enable_set(enable_set)
    );

    initial begin
    
        clk = 1;
        reset =  1;

        on = 0;
        num_cols = 0;
        base_addr = 0;
        
        #1
        reset = 0;
        on = 1;
        num_cols = T_NUM_COLS;
        base_addr = T_BASE_ADDR;

        #T_DEPTH

        on = 0;





        
    end;

    always #0.5 clk = !clk;

endmodule