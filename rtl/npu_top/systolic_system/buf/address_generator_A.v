`timescale 100ns/1ns
module adderss_generator_A #(
    parameter integer ADDR_WIDTH    = 16,
    parameter integer ARRAY_N       = 8,
    parameter integer CONCAT_ADDR_WIDTH = ADDR_WIDTH * ARRAY_N
) (
    input wire                          clk,
    input wire                          reset,
    
    input wire                          on,         //1: on. 0: off  // on signal set 1 for LENGTH cycles
    input wire     [ADDR_WIDTH-1:0]     base_addr,  // WS : (Depth x max_iter_i) x iter_t + Depth x iter_i       OS: Length x iter_o
    input wire     [$clog2(ARRAY_N) : 0]  num_rows,   // default value ARRAY_N, but on the edge case num_rows is not ARRAY_N 

    output wire [CONCAT_ADDR_WIDTH-1:0] address,    // ADDR_WIDTH * ARRAY_N
    output wire [ARRAY_N-1          :0] enable      // 1 * ARRAY_N


);
    genvar n;
    generate
        for(n=0; n<ARRAY_N; n = n+1)
        begin: ADDR_GEN_UNIT
            reg [ADDR_WIDTH-1: 0] offset;
            reg enable_u;
            wire enable_get; 
            // 1st line
            if(n==0)
            begin
                always @(posedge clk)
                begin
                    if(on)
                        enable_u <= on;
                    else
                        enable_u <= 'b0;
                end
            end
            //FIFO
            if(n > 0)
                assign enable_get = ADDR_GEN_UNIT[n-1].enable_u;
            //offset
            always @(posedge clk)
            begin
                if(n>0)
                    //enable signal propagate via FIFO
                    enable_u <= (n < num_rows)? enable_get : 'b0;
                // calculate offset
                if(reset)
                    offset <= 'b0;
                else if(enable_u)
                    offset <= offset + 'b1; 
                else
                    offset <= 'b0;
            end
            
            assign enable[n] = enable_u;
            assign address[ADDR_WIDTH*n+:ADDR_WIDTH] = offset + base_addr;

            // FLOW_1
        end
    endgenerate
    


    // part for OS 
endmodule
