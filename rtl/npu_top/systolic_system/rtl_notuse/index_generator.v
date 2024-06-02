`timescale 100ns/1ns
module index_generator #(
    parameter integer DEPTH = 16,
    parameter integer ARRAY_M = 8,
    parameter integer IDX_WIDTH = $clog2(DEPTH),
    parameter integer IDX_SET_WIDTH = IDX_WIDTH * ARRAY_M
) (
    input wire                  clk,
    input wire                  reset,
    input wire                  on,
    input wire  [$clog2(ARRAY_M) : 0] num_cols,
    input wire drain,

    output wire [IDX_SET_WIDTH-1:0] idx_set,
    output wire [ARRAY_M-1:0]   enable_set
);
    //reg 
    reg drain_dly;
    always @(posedge clk)
    begin
        drain_dly <= drain;
    end
    //index for accumulate
    genvar m;
    generate 
        for(m=0; m<ARRAY_M; m= m+1)
        begin:IDX_GEN_UNIT
            reg [IDX_WIDTH-1:0] index_r;
            reg enable_r;
            wire enable_w;

            if(m==0)
            begin
                always @(posedge clk)
                begin
                    enable_r <= on;
                end
            end
            else if(m>0)
            begin
                assign enable_w = IDX_GEN_UNIT[m-1].enable_r;
            end

            always @(posedge clk)
            begin
                //enable
                if(m>0)
                    enable_r <= (m < num_cols)? enable_w : 'b0;
                //index
                if(reset)
                    index_r <= 'b0;
                else if(enable_r)
                    index_r <= index_r + 'b1;
                else
                    index_r <= 'b0;
                
            end

            //drain
            reg [IDX_WIDTH-1:0]drain_index;
            wire drain_enable;
    
            always @(posedge clk)
            begin
                if(reset)
                    drain_index <= 'b0;
                else if(drain_dly)
                    drain_index <= drain_index + 'b1;
                else 
                    drain_index <= 'b0;
            end
            assign drain_enable = (m < num_cols)? drain_dly : 'b0;


            //sum
            assign enable_set[m] = (drain_dly)? drain_enable : enable_r;
            assign idx_set[IDX_WIDTH*m+:IDX_WIDTH] = (drain_dly)? drain_index : index_r;
        end

        
    endgenerate

    //drain



endmodule
