`timescale 100ns/1ns

module tb_O_buffer_top #(
    parameter integer RAM_SIZE = 1<<8,
    parameter integer DEPTH = 8,
    parameter integer ADDR_WIDTH = $clog2(RAM_SIZE),
    parameter integer ARRAY_M = 8,
    parameter integer ARRAY_N = 8,
    parameter integer DATA_WIDTH = 32,
    parameter integer DATA_SET_WIDTH = ARRAY_M * DATA_WIDTH
);
    reg clk;
    reg reset;

    reg [DATA_SET_WIDTH-1:0] data_set_in;
    reg                      idx_gen_on;
    reg                      ag_o_on;
    reg                          drain;

    reg [$clog2(ARRAY_M) : 0] num_cols;
    reg [ADDR_WIDTH -1 : 0] base_addr;
    reg                          mode; //1: OS 0:WS
    reg [$clog2(ARRAY_M)-1:0] ram_idx;

    //bram
    reg [ADDR_WIDTH-1 : 0] read_addr;

    wire [DATA_WIDTH-1:0] data_read;

    O_buffer_top #(
        .RAM_SIZE(RAM_SIZE),
        .ARRAY_M(ARRAY_M),
        .OUT_WIDTH(DATA_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) O_buf_top_inst (
        .clk(clk),
        .reset(reset),
        .data_set_in(data_set_in),
        .idx_gen_on(idx_gen_on),
        .ag_o_on(ag_o_on),
        .drain(drain),
        .num_cols(num_cols),
        .base_addr(base_addr),
        .mode(mode),
        .ram_idx(ram_idx),
        .read_addr(read_addr),
        .data_read(data_read)
    );
    integer c;
    integer cycle;
    integer i;
    integer ad;
    integer BASE_ADDR = 1<<7;
    
    initial begin
        clk = 1;
        reset = 1;
        data_set_in =0;
        idx_gen_on = 0;
        ag_o_on = 0;
        drain = 0;
        
        num_cols = 0;
        base_addr = 0;
        mode = 0;
        //drain to bram
        ram_idx = 0;
        read_addr = 0;
        #1
        reset = 0;
        num_cols = 8;
        base_addr = BASE_ADDR;
        mode = 0; //ws
        idx_gen_on = 1;
        ag_o_on = 0;
        drain = 0;

        for(cycle = 0 ; cycle < (DEPTH + ARRAY_M -1); cycle = cycle + 1)
        begin
        for(c = 0; c < ARRAY_M; c = c+1)
        begin
            if(cycle >= c && cycle < DEPTH + c)
                data_set_in[DATA_WIDTH*c+:DATA_WIDTH] = (cycle);
            else 
                data_set_in[DATA_WIDTH*c+:DATA_WIDTH] = 'b0;
        end 
        #1;
        end

        idx_gen_on = 0;
        ag_o_on = 1;
        drain = 1;

        #(DEPTH + 1)  //<== right || wrong: DEPTH before
        drain = 0;
        ag_o_on = 0;
        for(i = 0; i < ARRAY_M; i=i+1)
        begin
            for(ad = 0; ad < DEPTH; ad=ad+1)
            begin
                ram_idx = i;
                read_addr = BASE_ADDR+ad;
                #1;
            end
        end
        //=======================
        #10
        reset = 1;
        data_set_in =0;
        idx_gen_on = 0;
        ag_o_on = 0;
        drain = 0;
        
        num_cols = 0;
        base_addr = 0;
        mode = 0;
        //drain to bram
        ram_idx = 0;
        read_addr = 0;
        #1
        reset = 0;
        num_cols = 8;
        base_addr =0;
        mode = 1; //0s
        idx_gen_on = 0;
        ag_o_on = 1;
        drain = 0;

        for(cycle = 0 ; cycle < (ARRAY_N); cycle = cycle + 1)
        begin
        for(c = 0; c < ARRAY_M; c = c+1)
        begin
                data_set_in[DATA_WIDTH*c+:DATA_WIDTH] = cycle+16;
        end 
        #1;
        end

        idx_gen_on = 0;
        ag_o_on = 0;
        drain = 0;

        #DEPTH
        for(i = 0; i < ARRAY_M; i=i+1)
        begin
            for(ad = 0; ad < DEPTH; ad=ad+1)
            begin
                ram_idx = i;
                read_addr = ad;
                #1;
            end
        end





    end
    always #0.5 clk = !clk;
endmodule