`timescale 100ns/1ns

module tb_W_buffer #(
    parameter integer   RAM_SIZE    = 1<<8,
    parameter integer   ADDR_WIDTH  = $clog2(RAM_SIZE),
    parameter integer   ARRAY_N    = 8,
    parameter integer   ARRAY_M    = 8,
    parameter integer   WGT_WIDTH   = 8,
    parameter integer   WBUF_DATA_WIDTH =  ARRAY_M * WGT_WIDTH
);
   reg clk;
   reg reset;
   reg mode;
   reg on;
   reg [ADDR_WIDTH-1:0]        base_addr;
   reg [$clog2(ARRAY_M) : 0]   num_cols;
   
   wire [WBUF_DATA_WIDTH-1:  0] wgt_data_set_out;
//    wire     [ADDR_WIDTH * ARRAY_M-1:0] address_DEBUG;
//    wire     [ARRAY_M-1          :0] enable_DEBUG;
   
   W_buffer #(
    .RAM_SIZE(RAM_SIZE),
    .ADDR_WIDTH(ADDR_WIDTH),
    .ARRAY_N(ARRAY_N),
    .ARRAY_M(ARRAY_M),
    .WGT_WIDTH(WGT_WIDTH)
   ) w_buf (
        .clk(clk),
        .reset(reset),

        .mode(mode),
        .on(on),
        .base_addr(base_addr),
        .num_cols(num_cols),
        
        .wgt_data_set_out(wgt_data_set_out)
//        .address_DEBUG(address_DEBUG),
//        .enable_DEBUG(enable_DEBUG)
   );
   
   initial begin
    clk = 1;
    reset = 1;
    mode        = 0;
    on          = 0;
    base_addr   = 0;
    num_cols    = 0;
    # 1
    reset = 0;
    # 1
    mode        = 1;
    on          = 1;
    base_addr   = 0;
    num_cols    = 8;
    
    # 8
    on          = 0;
    # 8
    reset = 1;
    # 1
    reset = 0;
    # 1
    mode        = 0;
    on          = 1;
    base_addr   = 0;
    num_cols    = 8;
    
    # 8
    on          = 0;
    
   end;
   always #0.5 clk = !clk;
endmodule