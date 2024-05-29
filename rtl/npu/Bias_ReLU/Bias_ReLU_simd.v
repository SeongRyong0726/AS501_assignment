`timescale 100ns/1ns
module Bias_ReLU_simd #(
    parameter integer ARRAY_N = 16,
    parameter integer OUT_WIDTH = 32
)  (
    input wire  clk,
    input wire  reset,
    input wire [$clog2(ARRAY_N) : 0]        w_index,
    input wire [OUT_WIDTH -1 : 0]           w_data,
    input wire                              w_en,

    input wire [ARRAY_N * OUT_WIDTH -1 : 0] data_in,
    input wire [ARRAY_N * OUT_WIDTH -1 : 0] data_out
);

reg [OUT_WIDTH -1 : 0] bias_values [ARRAY_N -1 : 0];

always @(posedge clk)
begin
    if(w_en == 'b1)
    begin
        bias_values[w_index] <= w_data;
    end
end


genvar i;
generate
for(i=0; i<ARRAY_N; i=i+1)
begin: SIMD_LOOP
    wire [OUT_WIDTH-1:0] temp;
    assign temp  = data_in[OUT_WIDTH * (i+1)-1 : OUT_WIDTH * (i)] + bias_values[i];
    assign data_out[OUT_WIDTH * (i+1)-1 :OUT_WIDTH * (i)] = temp[OUT_WIDTH * (i+1)-1] == 'b0 ? temp : 0;
end
endgenerate

endmodule
