`timescale 100ns/1ns
module address_generator_O #(
    parameter integer RAM_O_SIZE = 1<<8,
    parameter integer ARRAY_M     = 8,
    parameter integer ADDR_WIDTH = $clog2(RAM_O_SIZE), 
    parameter integer ADDR_SET_WIDTH = ADDR_WIDTH * ARRAY_M
) (
    input wire                  clk,
    input wire                  reset,
    input wire                  on,
    input wire  [$clog2(ARRAY_M) : 0]   num_cols,
    input wire  [ADDR_WIDTH -1 : 0]     base_addr,

    output wire [ADDR_SET_WIDTH -1 : 0]     addr_set,
    output wire [ARRAY_M - 1 : 0]       enable_set
);
    reg on_;
    always @(posedge clk)
    begin
        on_ <= on;
    end
    genvar m;
    generate
        reg [ADDR_WIDTH-1 : 0] o_addr;
        for(m=0; m<ARRAY_M; m=m+1)
        begin
            always @(posedge clk)
            begin
                if(reset)
                    o_addr <= 'b0;
                else if(on_)
                    o_addr <= o_addr + 'b1;
                else 
                    o_addr <= 'b0;
            end
            assign addr_set[ADDR_WIDTH*m+:ADDR_WIDTH] = base_addr + o_addr;
            assign enable_set[m] = on_;
        end
        
    endgenerate
endmodule