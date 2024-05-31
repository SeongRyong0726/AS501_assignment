`timescale 100ns/1ns
module adderss_generator_W #(
    parameter integer ADDR_WIDTH    = 16,
    parameter integer ARRAY_M       = 8,
    parameter integer CONCAT_ADDR_WIDTH = ADDR_WIDTH * ARRAY_M
) (
    input wire                          clk,
    input wire                          reset,
    input wire                          mode,       //DEBUG 1: OS, 0: WS
    input wire                          on,         //1: on. 0: off  // on signal set 1 for LENGTH cycles
    input wire     [ADDR_WIDTH-1:0]     base_addr,  // WS : (Depth x max_iter_i) x iter_t + Depth x iter_i       OS: Length x iter_o
    input wire     [$clog2(ARRAY_M) : 0]  num_cols,   // default value ARRAY_M, but on the edge case num_rows is not ARRAY_N 

    output wire [CONCAT_ADDR_WIDTH-1:0] address,    // ADDR_WIDTH * ARRAY_M
    output wire [ARRAY_M-1          :0] enable      // 1 * ARRAY_M


);
    genvar m;
    generate
        for(m=0; m<ARRAY_M; m = m+1)
        begin: ADDR_GEN_UNIT
            reg [ADDR_WIDTH-1: 0] offset;
            reg enable_u;
            wire _enable_get;
            // 1st line
            if(m==0)
            begin
                assign _enable_get = on;
                always @(posedge clk)
                begin
                    enable_u <= _enable_get;
                end
            end
            //rest
            if(m > 0)begin
                assign _enable_get = (mode)? ADDR_GEN_UNIT[m-1].enable_u : on;
            end

            
            //offset calculation
            always @(posedge clk)
            begin
                if(m>0)
                    //enable signal propagate via FIFO
                    enable_u <= (m < num_cols)? _enable_get : 'b0;
                // calculate offset
                if(reset)
                    offset <= 'b0;
                else if(enable_u)
                    offset <= offset + 'b1; 
                else
                    offset <= 'b0;
            end
            
            assign enable[m] = (mode)? enable_u : ADDR_GEN_UNIT[0].enable_u;
            assign address[ADDR_WIDTH*m+:ADDR_WIDTH] = (mode)? offset + base_addr : ADDR_GEN_UNIT[0].offset + base_addr;

            // FLOW_1
        end
    endgenerate

endmodule
