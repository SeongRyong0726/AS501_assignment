`timescale 100ns/1ns

module tb_address_generator_A #(
    parameter integer ADDR_WIDTH    = 16,
    parameter integer ARRAY_N       = 8,
    parameter integer CONCAT_ADDR_WIDTH = ADDR_WIDTH * ARRAY_N
);
    reg clk;
    reg reset;
    reg on;
    reg [ADDR_WIDTH-1:0]base_addr;
    reg [$clog2(ARRAY_N) : 0] num_rows;
    
    wire [CONCAT_ADDR_WIDTH-1:0] address;
    wire [ARRAY_N-1          :0] enable ;
    
    adderss_generator_A ag_a(
        .clk(clk),
        .reset(reset),
        .on(on),
        .base_addr(base_addr),
        .num_rows(num_rows),
        .address(address),
        .enable(enable)
    );
    
    initial begin
        clk = 1;
        reset = 1;
        on          = 0;
        base_addr   = 0;
        num_rows    = 0;
        # 2
        
        reset = 0;
        # 2
        
        on        = 1;
        num_rows  = 8;
        base_addr = 0;
        
        # 16
        on        = 0;
        base_addr = 0;
        
    end;
    
    always #0.5 clk = !clk;
    
endmodule