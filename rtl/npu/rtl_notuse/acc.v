`timescale 100ns/1ns
module acc #(
    parameter integer DEPTH = 8,
    parameter integer ARRAY_M = 8,
    parameter integer DATA_WIDTH = 32,
    parameter integer IDX_WIDTH = $clog2(DEPTH),
    parameter integer IDX_SET_WIDTH = IDX_WIDTH*ARRAY_M,
    parameter integer DATA_SET_WIDTH = ARRAY_M * DATA_WIDTH
) (
    input wire clk,
    input wire reset,

    input wire [IDX_SET_WIDTH-1:0]  idx_set,
    input wire [DATA_SET_WIDTH-1:0] data_set,
    
    input wire [ARRAY_M-1:0]        enable_set,
    input wire                      drain,

    output wire [DATA_SET_WIDTH-1:0] acc_out  
);

    
    genvar m;
    generate
        
        
        for (m=0; m<ARRAY_M; m=m+1)
        begin: col_idx
            wire enable;
            wire [DATA_WIDTH-1:0] ram_out;
            wire [DATA_WIDTH-1:0] ram_in;
            wire [DATA_WIDTH-1:0] data_in;
            wire [IDX_WIDTH-1:0] index;
            //wire [DATA_WIDTH-1:0] acc_result;

            assign data_in = data_set[DATA_WIDTH*m+:DATA_WIDTH];
            assign index = idx_set[IDX_WIDTH*m+:IDX_WIDTH];
            assign ram_in = ram_out + data_in;
            assign enable = enable_set[m];
            //read no_reg, write neg_edge
            acc_unit#(
                .DATA_WIDTH(DATA_WIDTH),
                .ADDR_WIDTH($clog2(DEPTH)),
                .OUTPUT_REG('b0)
            ) acc_storage (
                .clk(clk),
                .reset(reset),
                .read_req('b0),
                .read_addr(index),
                .read_data(ram_out),   //output
                .write_req(enable&&!drain),
                .write_addr(index),
                .write_data(ram_in)
            );
            // drain at "enable && drain" true
            // index require.
            assign acc_out[DATA_WIDTH*m+:DATA_WIDTH] = (drain&&enable)? ram_out:{DATA_WIDTH{'b0}};
        end
    endgenerate
endmodule