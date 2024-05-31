/*
## PE.v 
## SeongRyong Oh
## (sroh@casys.kaist.ac.kr)
*/
`timescale 100ns/1ns
module pe #(
    parameter integer   ACT_WIDTH       = 8,
    parameter integer   WGT_WIDTH       = 8, 
    parameter integer   MULT_OUT_WIDTH  = ACT_WIDTH + WGT_WIDTH,
    parameter integer   PE_OUT_WIDTH    = 32 
) (
    input wire                                  clk,
    input wire                                  reset,
    input wire [ 2                 : 0]         operation_signal_in,

    input signed [ ACT_WIDTH      -1 : 0]         act_data_in,
    input signed [ WGT_WIDTH      -1 : 0]         wgt_data_in,
    input signed [ PE_OUT_WIDTH   -1 : 0]         result_in,

    output signed [ PE_OUT_WIDTH   -1 : 0]        result_out
    
);
    /*  split operation_signal_in */
    wire mode;
    wire os_drain;
    wire wgt_load;  
    assign mode = operation_signal_in[2];
    assign os_drain = operation_signal_in[1];
    assign wgt_load = operation_signal_in[0];
    
    /*  wires  */
    wire signed [WGT_WIDTH-1:0]        pre_load_wgt;
    wire signed [WGT_WIDTH-1:0]        mul_op_wgt;
    wire signed [MULT_OUT_WIDTH-1:0]   mul_result;
    wire signed [PE_OUT_WIDTH-1:0]        adder_op;
    wire signed [PE_OUT_WIDTH-1:0]     acc_output;
    wire signed [PE_OUT_WIDTH-1:0]     adder_result;
    wire signed [PE_OUT_WIDTH-1:0]     acc_input;


    /* pe wiring */
    reg_with_sync_en #(
        .WIDTH (WGT_WIDTH)
    ) weight_reg (
        .clk        (clk),
        .reset      (reset),
        .enable     (wgt_load),
        .in         (wgt_data_in),
        .out        (pre_load_wgt)
    );

    mux_2_to_1 #(
        .WIDTH (WGT_WIDTH) // Data Width
    ) mux_mul_op_wgt (
        .sel        (mode),
        .data_in_t  (wgt_data_in),
        .data_in_f  (pre_load_wgt),
        .data_out   (mul_op_wgt)
    );

    assign mul_result = act_data_in * mul_op_wgt;
    
    mux_2_to_1 #(
        .WIDTH (PE_OUT_WIDTH)
    ) mux_adder_op (
        .sel    (mode),
        .data_in_t  (acc_output),
        .data_in_f  (result_in),
        .data_out   (adder_op)      
    );
    // TO support signed value [Hardcoding]
    assign adder_result = mul_result + adder_op;

    mux_2_to_1 #(
        .WIDTH (PE_OUT_WIDTH)
    ) mux_acc_reg_input (
        .sel       (os_drain),
        .data_in_t (result_in),
        .data_in_f (adder_result),
        .data_out  (acc_input)
    );

    reg_with_sync_en #(
        .WIDTH (PE_OUT_WIDTH)
    ) acc (
        .clk    (clk),
        .reset  (reset),
        .enable ('b1),
        .in     (acc_input),
        .out    (acc_output)
    );

    assign result_out =  acc_output;
    
endmodule
