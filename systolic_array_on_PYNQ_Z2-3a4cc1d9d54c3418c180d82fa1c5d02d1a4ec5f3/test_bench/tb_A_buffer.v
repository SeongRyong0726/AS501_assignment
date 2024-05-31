`timescale 100ns/1ns

module tb_A_buffer #(
    parameter integer   RAM_SIZE    = 1<<16,
    parameter integer   ADDR_WIDTH  = $clog2(RAM_SIZE),
    parameter integer   ARRAY_N    = 8,
    parameter integer   ARRAY_M    = 8,
    parameter integer   ACT_WIDTH   = 8,
    parameter integer   IBUF_DATA_WIDTH =  ARRAY_N * ACT_WIDTH
);
   reg clk;
   reg reset;
   reg on;
   reg [ADDR_WIDTH-1:0]        base_addr;
   reg [$clog2(ARRAY_N) : 0]   num_rows;
   
   wire [IBUF_DATA_WIDTH-1:  0] act_data_set_out;
   
   A_buffer #(
    .RAM_SIZE(RAM_SIZE),
    .ADDR_WIDTH(ADDR_WIDTH),
    .ARRAY_N(ARRAY_N),
    .ARRAY_M(ARRAY_M),
    .ACT_WIDTH(ACT_WIDTH)
   ) a_buf (
        .clk(clk),
        .reset(reset),
        .on(on),
        .base_addr(base_addr),
        .num_rows(num_rows),
        
        .act_data_set_out(act_data_set_out)
   );
   
   initial begin
    clk = 1;
    reset = 1;
    on          = 0;
    base_addr   = 0;
    num_rows    = 0;
    # 1
    reset = 0;
    # 1
    
    on          = 1;
    base_addr   = 16;
    num_rows    = 4;
    
    # 16
    
    on          = 0;
    base_addr   = 16;
    num_rows    = 4;
    
   end;
   always #0.5 clk = !clk;
endmodule