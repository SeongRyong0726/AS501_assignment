// -----------------------
// O_buffer.v
// ?�� address_generator_O.v
// ?�� ram.v
// -----------------------

`timescale 100ns/1ns
module O_buffer #(
    parameter integer RAM_SIZE = 1<<8,
    parameter integer ADDR_WIDTH = $clog2(RAM_SIZE),
    parameter integer ARRAY_M = 8,
    parameter integer OUT_WIDTH = 32,
    parameter integer DATA_WIDTH = 32,
    parameter integer OBUF_DATA_WIDTH = ARRAY_M * OUT_WIDTH,
    parameter integer OBUF_ADDR_WIDTH = ARRAY_M * ADDR_WIDTH
) (
    input wire                  clk,
    input wire                  reset,
    input wire                  ram_reset,

    input wire  [$clog2(ARRAY_M):0]     num_cols,
    input wire                          ag_o_on,
    //  write
    input wire  [OBUF_DATA_WIDTH-1:0]   data_in,
    input wire  [ADDR_WIDTH -1 : 0]     base_addr,


    //  read
    input wire  [$clog2(ARRAY_M)-1:0]   ram_idx,
    input wire  [ADDR_WIDTH-1 : 0]      read_addr,
    output signed [DATA_WIDTH-1:0]   data_read
);

    reg [OBUF_DATA_WIDTH-1:0]   data_in_;
    wire [OBUF_ADDR_WIDTH-1:0]  addr_set; 
    wire [ARRAY_M-1:0]          enable_set;         
    

    always @(posedge clk)
    begin
        data_in_ <= data_in;
    end

    address_generator_O #(
        .RAM_O_SIZE(RAM_SIZE),
        .ARRAY_M(ARRAY_M),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) ag_o (
        .clk(clk),
        .reset(reset),
        .on(ag_o_on),
        .num_cols(num_cols),
        .base_addr(base_addr),

        .addr_set(addr_set),
        .enable_set(enable_set)
    );
    
    genvar m;
    generate
    for(m=0; m<ARRAY_M; m=m+1)
    begin: RAM_ARRAY
        wire [DATA_WIDTH-1:0] output_data;
        ram #(
            .DATA_WIDTH(OUT_WIDTH),
            .ADDR_WIDTH(ADDR_WIDTH),
            .OUTPUT_REG(0)
        ) ram_output_storage (
            .clk(clk),
            .reset(ram_reset),
            .read_req(1'b0), //since we not use REG
            .read_addr(read_addr),
            .read_data(output_data),
            .write_req(enable_set[m]),
            .write_addr(addr_set[ADDR_WIDTH*m+:ADDR_WIDTH]),
            .write_data(data_in_[OUT_WIDTH*m+:OUT_WIDTH])
        );
        assign data_read = (ram_idx == m)? output_data[DATA_WIDTH-1:0] : {DATA_WIDTH{'bZ}};
    end
    endgenerate
endmodule
