`timescale 100ns/1ns

module tb_address_generator_W #(
    parameter integer ADDR_WIDTH    = 16,
    parameter integer ARRAY_M       = 8,
    parameter integer CONCAT_ADDR_WIDTH = ADDR_WIDTH * ARRAY_M
);
    reg clk;
    reg reset;
    reg mode;
    reg on;
    reg [ADDR_WIDTH-1:0]base_addr;
    reg [$clog2(ARRAY_M) : 0] num_cols;
    
    wire [CONCAT_ADDR_WIDTH-1:0] address;
    wire [ARRAY_M-1          :0] enable ;
    
    adderss_generator_W ag_w(
        .clk(clk),
        .reset(reset),
        .mode(mode),
        .on(on),
        .base_addr(base_addr),
        .num_cols(num_cols),
        .address(address),
        .enable(enable)
    );
    
    initial begin
        clk = 1;
        reset = 1;
        mode = 0;
        on          = 0;
        base_addr   = 0;
        num_cols    = 0;
        # 1
        $display("reset off");
        reset = 0;
        # 1
        $display("WS test");
        mode = 0;
        on        = 1;
        num_cols  = 8;
        base_addr = 0;
        # 8
        on        = 0;
        # 8
        $display("reset");
        reset = 1;
        #1
        $display("reset off");
        reset = 0;
        #1
        $display("OS test");
        mode = 1;
        on        = 1;
        num_cols  = 8;
        base_addr = 0;
        # 8
        on        = 0;
        
        
    end;
    
    always #0.5 clk = !clk;
    
endmodule