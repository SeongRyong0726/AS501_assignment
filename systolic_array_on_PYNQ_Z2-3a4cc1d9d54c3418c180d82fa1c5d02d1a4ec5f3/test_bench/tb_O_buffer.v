`timescale 100ns/1ns

module tb_O_buffer #(
    parameter integer RAM_SIZE = 1<<8,
    parameter integer ADDR_WIDTH = $clog2(RAM_SIZE),
    parameter integer ARRAY_M = 8,
    parameter integer OUT_WIDTH = 32,
    parameter integer OBUF_DATA_WIDTH = ARRAY_M * OUT_WIDTH,
    parameter integer OBUF_ADDR_WIDTH = ARRAY_M * ADDR_WIDTH
);
    reg clk;
    reg reset;

    reg [$clog2(ARRAY_M):0]         num_cols;
    reg                             ag_o_on;
    reg [OBUF_DATA_WIDTH-1:0]       data_in;
    reg [ADDR_WIDTH -1 : 0]         base_addr;
    reg [$clog2(ARRAY_M)-1:0]       ram_idx;

    reg [ADDR_WIDTH -1 : 0]         read_addr;
    wire [OUT_WIDTH -1 :0]    data_read;

    O_buffer #(
        .RAM_SIZE(RAM_SIZE),
        .ARRAY_M(ARRAY_M),
        .OUT_WIDTH(OUT_WIDTH),
        .DATA_WIDTH(OUT_WIDTH)
    ) tb_o_buf (
        .clk(clk),
        .reset(reset),
        .num_cols(num_cols),
        .ag_o_on(ag_o_on),
        .data_in(data_in),
        .base_addr(base_addr),
        .ram_idx(ram_idx),

        .read_addr(read_addr),
        .data_read(data_read)
    );
    integer i;
    integer j;
    integer k;
    integer idx;
    initial begin
        clk = 1;
        reset = 1;
        num_cols = 0;
        ag_o_on = 0;
        data_in = 0;
        base_addr = 0;
        ram_idx =0;

        read_addr = 0;
        #1

        reset = 0;
        #1
        num_cols = 8;
        ag_o_on  = 1;
        base_addr = 16;
        for(j=0; j<8; j=j+1)
        begin
        for(i=0; i<8; i=i+1)
        begin
            data_in[OUT_WIDTH*i+:OUT_WIDTH]  = 8*j+i;
        end
        #1;
        end
        
        ag_o_on = 0;
        #1
        for(idx = 0 ; idx < ARRAY_M ; idx = idx+1)
        begin
        for(k=base_addr; k<base_addr+8; k=k+1)
        begin
            ram_idx = idx;
            read_addr = k;
            #1;
        end
        end
    end

    always #0.5 clk = !clk;

endmodule