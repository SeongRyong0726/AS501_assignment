`timescale 100ns/1ns

module tb_systolic_array #(
    parameter integer   ARRAY_N         = 8,
    parameter integer   ARRAY_M         = 8,

    parameter integer   ACT_WIDTH       = 8,
    parameter integer   WGT_WIDTH       = 8, 
    parameter integer   PE_OUT_WIDTH    = 32,
    
    parameter integer   IBUF_DATA_WIDTH = ARRAY_N * ACT_WIDTH,
    parameter integer   WBUF_DATA_WIDTH = ARRAY_M * WGT_WIDTH,
    parameter integer   OUT_DATA_WIDTH  = ARRAY_M * PE_OUT_WIDTH
);
    reg clk;
    reg reset;
    reg [IBUF_DATA_WIDTH-1:0] act_data_set_in;
    reg [WBUF_DATA_WIDTH-1:0] wgt_data_set_in; 
    reg [2:0] operation_signal_in;

    wire [OUT_DATA_WIDTH-1:0] result_data_set_out;

    systolic_array #(
        .ARRAY_N(ARRAY_N),
        .ARRAY_M(ARRAY_M),
        .ACT_WIDTH(ACT_WIDTH),
        .WGT_WIDTH(WGT_WIDTH),
        .PE_OUT_WIDTH(PE_OUT_WIDTH)
    ) sys_to (
        .clk(clk),
        .reset(reset),
        .act_data_set_in(act_data_set_in),
        .wgt_data_set_in(wgt_data_set_in),
        .operation_signal_in(operation_signal_in),
        .result_data_set_out(result_data_set_out)        
    );
    integer i ;
    integer j ;
    initial begin
        clk = 1;
        reset = 1;
        act_data_set_in = 64'h0000000000000000;
        wgt_data_set_in = 64'h0000000000000000;
        operation_signal_in = 3'b000;
        #1
        $display("RESET OFF");
        $display("operation mode : Output Stationary");
        reset = 0;
        operation_signal_in = 3'b100;
        #1
        
        $display("OS FLOW");
        act_data_set_in = 64'h0000000000000001;
        wgt_data_set_in = 64'h0000000000000001;
        #1
        act_data_set_in = 64'h0000000000000101;
        wgt_data_set_in = 64'h0000000000000101;
        #1
        act_data_set_in = 64'h0000000000010101;
        wgt_data_set_in = 64'h0000000000010101;
        #1
        act_data_set_in = 64'h0000000001010101;
        wgt_data_set_in = 64'h0000000001010101;
        #1
        act_data_set_in = 64'h0000000101010101;
        wgt_data_set_in = 64'h0000000101010101;
        #1
        act_data_set_in = 64'h0000010101010101;
        wgt_data_set_in = 64'h0000010101010101;
        #1
        act_data_set_in = 64'h0001010101010101;
        wgt_data_set_in = 64'h0001010101010101;
        #1
        act_data_set_in = 64'h0101010101010101;
        wgt_data_set_in = 64'h0101010101010101;
        #1
        act_data_set_in = 64'h0101010101010100;
        wgt_data_set_in = 64'h0101010101010100;
        #1
        act_data_set_in = 64'h0101010101010000;
        wgt_data_set_in = 64'h0101010101010000;
        #1
        act_data_set_in = 64'h0101010101000000;
        wgt_data_set_in = 64'h0101010101000000;
        #1
        act_data_set_in = 64'h0101010100000000;
        wgt_data_set_in = 64'h0101010100000000;
        #1
        act_data_set_in = 64'h0101010000000000;
        wgt_data_set_in = 64'h0101010000000000;
        #1
        act_data_set_in = 64'h0101000000000000;
        wgt_data_set_in = 64'h0101000000000000;
        #1
        act_data_set_in = 64'h0100000000000000;
        wgt_data_set_in = 64'h0100000000000000;
        #1 //#
        act_data_set_in = 64'h0000000000000000;
        wgt_data_set_in = 64'h0000000000000000;
        #7 //# ARRAY_M == ARRAY_N
        $display("drain output");
        operation_signal_in = 3'b110;
        $display("output value row direction dimension : 8 ");
        // $display("process to get result : case 8 differ from other case (1~7) ");

        for(i=0; i<8; i=i+1) begin
                if(result_data_set_out == 256'h0000000800000008000000080000000800000008000000080000000800000008)begin
                        $display("[%d] result right",8-i);
                end
                else begin
                        $display ("wrong");
                        $display ("%h", result_data_set_out);
                end
                #1;
        end
                
        $display("-------reset system-------");
        reset = 1;
        #1
        reset = 0;
        operation_signal_in = 3'b001;
        $display("W_LOAD");
        for(i=0;i<(8+1);i=i+1) begin
                act_data_set_in = 64'h0000000000000000;
                wgt_data_set_in = 64'h0101010101010101;
                #1;
        end

        operation_signal_in = 3'b000;
        $display("W_FLOW");
        act_data_set_in = 64'h0000000000000001;
        wgt_data_set_in = 64'h0000000000000001;
        #1
        act_data_set_in = 64'h0000000000000101;
        wgt_data_set_in = 64'h0000000000000101;
        #1
        act_data_set_in = 64'h0000000000010101;
        wgt_data_set_in = 64'h0000000000010101;
        #1
        act_data_set_in = 64'h0000000001010101;
        wgt_data_set_in = 64'h0000000001010101;
        #1
        act_data_set_in = 64'h0000000101010101;
        wgt_data_set_in = 64'h0000000101010101;
        #1
        act_data_set_in = 64'h0000010101010101;
        wgt_data_set_in = 64'h0000010101010101;
        #1
        act_data_set_in = 64'h0001010101010101;
        wgt_data_set_in = 64'h0001010101010101;
        #1
        act_data_set_in = 64'h0101010101010101;
        wgt_data_set_in = 64'h0101010101010101;
        #1
        act_data_set_in = 64'h0101010101010100;
        wgt_data_set_in = 64'h0101010101010100;
        if(result_data_set_out == 256'h0000000000000000000000000000000000000000000000000000000000000008)begin
                $display("[1] result right");
        end
        else begin
                $display ("wrong");
                $display ("%h", result_data_set_out);
        end
        #1
        act_data_set_in = 64'h0101010101010000;
        wgt_data_set_in = 64'h0101010101010000;
        if(result_data_set_out == 256'h0000000000000000000000000000000000000000000000000000000800000008)begin
                $display("[2] result right");
        end
        else begin
                $display ("wrong");
                $display ("%h", result_data_set_out);
        end
        #1
        act_data_set_in = 64'h0101010101000000;
        wgt_data_set_in = 64'h0101010101000000;
        if(result_data_set_out == 256'h0000000000000000000000000000000000000000000000080000000800000008)begin
                $display("[3] result right");
        end
        else begin
                $display ("wrong");
                $display ("%h", result_data_set_out);
        end
        #1
        act_data_set_in = 64'h0101010100000000;
        wgt_data_set_in = 64'h0101010100000000;
        if(result_data_set_out == 256'h0000000000000000000000000000000000000008000000080000000800000008)begin
                $display("[4] result right");
        end
        else begin
                $display ("wrong");
                $display ("%h", result_data_set_out);
        end
        #1
        act_data_set_in = 64'h0101010000000000;
        wgt_data_set_in = 64'h0101010000000000;
        if(result_data_set_out == 256'h000000000000000000000000000000800000008000000080000000800000008)begin
                $display("[5] result right");
        end
        else begin
                $display ("wrong");
                $display ("%h", result_data_set_out);
        end
        #1
        act_data_set_in = 64'h0101000000000000;
        wgt_data_set_in = 64'h0101000000000000;
        if(result_data_set_out == 256'h0000000000000000000000080000000800000008000000080000000800000008)begin
                $display("[6] result right");
        end
        else begin
                $display ("wrong");
                $display ("%h", result_data_set_out);
        end
        #1
        act_data_set_in = 64'h0100000000000000;
        wgt_data_set_in = 64'h0100000000000000;
        if(result_data_set_out == 256'h0000000000000008000000080000000800000008000000080000000800000008)begin
                $display("[7] result right");
        end
        else begin
                $display ("wrong");
                $display ("%h", result_data_set_out);
        end
        #1 //#
        act_data_set_in = 64'h0000000000000000;
        wgt_data_set_in = 64'h0000000000000000;
        if(result_data_set_out == 256'h0000000800000008000000080000000800000008000000080000000800000008)begin
                $display("[8] result right");
        end
        else begin
                $display ("wrong");
                $display ("%h", result_data_set_out);
        end
    end
    always #0.5 clk = !clk;

endmodule