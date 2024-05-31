// -----------------------
// O_buffer_top.v
// ?�� accumulator.v
// 	?�� acc.v
// 	?�� index_generator.v
// ?�� O_buffer.v
//  ?�� address_generator_O.v
//  ?�� ram.v
// -----------------------


`timescale 100ns/1ns

module O_buffer_top  #(
    parameter integer RAM_SIZE = 1<<8,
    parameter integer DEPTH = 8,
    parameter integer ADDR_WIDTH = $clog2(RAM_SIZE),
    parameter integer ARRAY_M = 8,
    parameter integer OUT_WIDTH = 32,
    parameter integer DATA_WIDTH = 32,
    parameter integer DATA_SET_WIDTH = ARRAY_M * DATA_WIDTH
) (
    input wire clk,
    input wire reset,

    input wire [DATA_SET_WIDTH-1:0] data_set_in,
    input wire                      idx_gen_on,
    input wire                      ag_o_on,
    input wire                          drain,

    input wire [$clog2(ARRAY_M) : 0] num_cols,
    input wire [ADDR_WIDTH -1 : 0] base_addr,
    input wire                          mode, //1: OS 0:WS
    input wire [$clog2(ARRAY_M)-1:0] ram_idx,

    //bram
    input wire [ADDR_WIDTH-1 : 0] read_addr,

    output signed [DATA_WIDTH-1:0] data_read
    // output wire [DATA_SET_WIDTH-1:0] debug_,
    // output wire [ARRAY_M * ADDR_WIDTH-1 : 0] debug_addr,
    // output wire [DATA_SET_WIDTH-1 : 0] DEBUG_data
);
    //DEBUG
    // assign debug_ = data_set_mux_op2;
    //DEBUG
    wire [DATA_SET_WIDTH-1:0] data_set_mux_op1;
    wire [DATA_SET_WIDTH-1:0] data_set_mux_op2; //acc
    wire [DATA_SET_WIDTH-1:0] data_set_mux_out; //to ram
    assign data_set_mux_op1 = data_set_in;
    assign data_set_mux_out = (mode)?  data_set_mux_op1 : data_set_mux_op2;

    //DEBUG_
    // assign DEBUG_data = data_set_in;
    //FOR timing DELAY ag_o_on
    reg ag_o_on_; 
    always @(posedge clk)
    begin
        ag_o_on_ <= ag_o_on;
    end

    O_buffer #(
        .RAM_SIZE(RAM_SIZE),
        .ARRAY_M(ARRAY_M),
        .OUT_WIDTH(OUT_WIDTH)
    ) O_buf_inst (
        .clk(clk),
        .reset(reset),
        //data
        .ag_o_on(ag_o_on_),
        .data_in(data_set_mux_out),
        // signal
        .num_cols(num_cols),
        .base_addr(base_addr),
        //TO bram
        .ram_idx(ram_idx),
        .read_addr(read_addr),
        .data_read(data_read) //output
        // .debug_addr(debug_addr)
    );

    accumulator #(
        .DEPTH(DEPTH),
        .ARRAY_M(ARRAY_M),
        .DATA_WIDTH(OUT_WIDTH)
    ) accumulator_inst (
        .clk(clk),
        .reset(reset),
        .data_set_in(data_set_in),
        .on(idx_gen_on),
        .num_cols(num_cols),
        .drain(drain),
        .acc_out(data_set_mux_op2)      //output
    );

endmodule
