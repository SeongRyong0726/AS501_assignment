// -----------------------
// systolic_array.v
// ?�� pe.v
// -----------------------


`timescale 100ns/1ns
module systolic_array #(
    parameter integer   ARRAY_N         = 16,
    parameter integer   ARRAY_M         = 16,

    parameter integer   ACT_WIDTH       = 8,
    parameter integer   WGT_WIDTH       = 8,
    parameter integer   PE_OUT_WIDTH    = 32,

    parameter integer   IBUF_DATA_WIDTH = ARRAY_N * ACT_WIDTH,
    parameter integer   WBUF_DATA_WIDTH = ARRAY_M * WGT_WIDTH,
    parameter integer   OUT_DATA_WIDTH  = ARRAY_M * PE_OUT_WIDTH
) (
    input wire                              clk,
    input wire                              reset,
    input wire [IBUF_DATA_WIDTH-1:  0]      act_data_set_in,
    input wire [WBUF_DATA_WIDTH-1:  0]      wgt_data_set_in,
    input wire [2               :   0]      operation_signal_in,

    output wire [OUT_DATA_WIDTH-1:   0]     result_data_set_out

);

// ======
// Wires and Regs
// ======
wire [OUT_DATA_WIDTH-1:   0]  result_data_set_out_delay_wire;
reg  [OUT_DATA_WIDTH-1:   0]  result_data_set_out_delay_reg;

// ======
// Systlic Array - Begin
// CHECK POINT is clk of PE, and each reg
// ======
genvar n, m;
generate
for (m=0; m<ARRAY_M; m=m+1)
begin: LOOP_IPNUT_FORWARD
for (n=0; n<ARRAY_N; n=n+1)
begin: LOOP_OUTPUT_FORWARD
    wire [ACT_WIDTH     -1 : 0]     act_in;
    wire [ACT_WIDTH     -1 : 0]     act_in_;
    wire [WGT_WIDTH     -1 : 0]     wgt_in;
    wire [WGT_WIDTH     -1 : 0]     wgt_in_;
    wire [PE_OUT_WIDTH  -1 : 0]     result_in;

    wire [PE_OUT_WIDTH  -1 : 0]     result_out;
    //==============================================
    if(m == 0)
    begin
        assign act_in = act_data_set_in [n*ACT_WIDTH+:ACT_WIDTH];
    end
    else
    begin
        reg_with_sync_en #(
            .WIDTH(ACT_WIDTH)
            ) fwd_a (
            .clk(!clk),
            .reset(reset), 
            .enable('b1), 
            .in(LOOP_IPNUT_FORWARD[m-1].LOOP_OUTPUT_FORWARD[n].act_in),
            .out(act_in_)
            );
        reg_with_sync_en #(
            .WIDTH(ACT_WIDTH)
            ) fwd_a_ (
            .clk(clk),
            .reset(reset), 
            .enable('b1), 
            .in(act_in_),
            .out(act_in)
            );
    end
    
    //=================================================
    if(n == 0)
    begin
        assign result_in = {PE_OUT_WIDTH{1'b0}};
        assign wgt_in = wgt_data_set_in[m*WGT_WIDTH+:WGT_WIDTH];
    end
    else
    begin 
        reg_with_sync_en #(
            .WIDTH(WGT_WIDTH)
            ) fwd_w (
            .clk(!clk), 
            .reset(reset), 
            .enable('b1), 
            .in(LOOP_IPNUT_FORWARD[m].LOOP_OUTPUT_FORWARD[n-1].wgt_in),
            .out(wgt_in_));
        reg_with_sync_en #(
            .WIDTH(WGT_WIDTH)
            ) fwd_w_ (
            .clk(clk), 
            .reset(reset), 
            .enable('b1), 
            .in(wgt_in_),
            .out(wgt_in));
        /*DELETE L.current+1 to match Behavior Simulation and post-synthesis simulation (additional consideration: acc_reg in pe trigger @ neg edge)*/
        //assign result_in = LOOP_IPNUT_FORWARD[m].LOOP_OUTPUT_FORWARD[n-1].result_out;
        reg_with_sync_en #(
            .WIDTH(PE_OUT_WIDTH)
            ) result_st (
            .clk(clk), 
            .reset(reset), 
            .enable('b1), 
            .in(LOOP_IPNUT_FORWARD[m].LOOP_OUTPUT_FORWARD[n-1].result_out),
            .out(result_in)
            ); 
    end
    if(n==ARRAY_N-1)
    begin
        assign result_data_set_out_delay_wire [m*PE_OUT_WIDTH+:PE_OUT_WIDTH] = result_out;
    end
    //==============================================

    pe #(
        .ACT_WIDTH              (ACT_WIDTH),
        .WGT_WIDTH              (WGT_WIDTH),
        .PE_OUT_WIDTH           (PE_OUT_WIDTH)
    ) pe_inst (
        .clk                                  ( !clk   ), //input
        .reset                                ( reset ), //input
        .operation_signal_in                  ( operation_signal_in ), //input
        .act_data_in                          ( act_in), //input
        .wgt_data_in                          ( wgt_in), //input
        .result_in                            ( result_in), //input 
        .result_out                           ( result_out) //output
    );

end
end
endgenerate

always @(posedge clk)begin
    result_data_set_out_delay_reg <= result_data_set_out_delay_wire;
end
assign result_data_set_out = result_data_set_out_delay_reg;

// ======
// Systlic Array - End
// ======
endmodule