`timescale 100ns/1ns

module tb_acc #(
    parameter integer DEPTH = 8,
    parameter integer ARRAY_M = 8,
    parameter integer DATA_WIDTH = 32,
    parameter integer IDX_WIDTH = $clog2(DEPTH),
    parameter integer IDX_SET_WIDTH = IDX_WIDTH*ARRAY_M,
    parameter integer DATA_SET_WIDTH = ARRAY_M * DATA_WIDTH
);
    reg clk;
    reg reset;

    reg [ARRAY_M-1:0]       enable_set;
    reg [IDX_SET_WIDTH-1:0] idx_set;
    reg [DATA_SET_WIDTH-1:0]data_set;
    reg                     drain;

    wire [DATA_SET_WIDTH-1:0] acc_out;

    acc #(
        .DEPTH(DEPTH),
        .ARRAY_M(ARRAY_M),
        .DATA_WIDTH(DATA_WIDTH),
        .IDX_WIDTH(IDX_WIDTH),
        .IDX_SET_WIDTH(IDX_SET_WIDTH),
        .DATA_SET_WIDTH(DATA_SET_WIDTH)
    ) tb_acc (
        .clk(clk),
        .reset(reset),
        .enable_set(enable_set),
        .idx_set(idx_set),
        .data_set(data_set),
        .drain(drain),
        .acc_out(acc_out)
    );
    integer i;
    integer cycle;
    initial begin
        //TEST START
        clk = 1;
        reset = 1;
        enable_set = 0;
        idx_set =0;
        data_set =0;
        drain = 0;
        #1
        // ACC
        reset = 0;
        for(cycle =0; cycle<DEPTH; cycle = cycle +1)
        begin
        for(i=0; i<ARRAY_M; i= i+1)
        begin
            enable_set[i] = 1;
            idx_set[i*IDX_WIDTH+:IDX_WIDTH]     =   cycle;
            data_set[i*DATA_WIDTH+:DATA_WIDTH]  =   cycle + i;
        end
        #1;
        end
        //
        for(cycle =0; cycle<DEPTH; cycle = cycle +1)
        begin
        for(i=0; i<ARRAY_M; i= i+1)
        begin
            enable_set[i] = 1;
            idx_set[i*IDX_WIDTH+:IDX_WIDTH]     =   cycle;
            data_set[i*DATA_WIDTH+:DATA_WIDTH]  =   cycle + i;
        end
        #1;
        end

        //
        //drain
        for(cycle =0; cycle<DEPTH; cycle = cycle +1)
        begin
        for(i=0; i<ARRAY_M; i= i+1)
        begin
            enable_set[i] = 1;
            drain = 1;
            idx_set[i*IDX_WIDTH+:IDX_WIDTH]     =   cycle;
        end
        #1;
        end

        reset =1;
        



        //TEST END
    end;
    always #0.5 clk=!clk;
endmodule