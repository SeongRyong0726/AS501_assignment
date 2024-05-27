


`timescale 100ns/1ns
module reg_with_sync_en #(
    parameter integer WIDTH         = 8
) (
    input   wire            clk,
    input   wire            reset,
    input   wire            enable,
    input   wire    [ WIDTH -1 : 0 ]    in,
    output   wire    [ WIDTH -1 : 0 ]    out 
);
    reg signed [ WIDTH - 1 : 0] reg_inner;

    always @(posedge clk)
    begin
        if(reset)
            reg_inner <= 'b0;
        else if (enable)
            reg_inner <= in;
    end
    
    assign out = reg_inner; 

endmodule
