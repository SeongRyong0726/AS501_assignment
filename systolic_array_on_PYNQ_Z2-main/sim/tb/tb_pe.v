`timescale 100ns/1ns

module tb_pe #(
    parameter integer   ACT_WIDTH       = 8,
    parameter integer   WGT_WIDTH       = 8, 
    parameter integer   MULT_OUT_WIDTH  = ACT_WIDTH + WGT_WIDTH,
    parameter integer   PE_OUT_WIDTH    = 32 
);
    reg clk;
    reg reset;
    reg [2:0] operation_signal_in;

    reg [ACT_WIDTH-1:0]     act_data_in;
    reg [WGT_WIDTH-1:0]     wgt_data_in;
    reg [PE_OUT_WIDTH-1:0]  result_in;

    wire [PE_OUT_WIDTH-1:0] result_out;

    pe #(
        .ACT_WIDTH(ACT_WIDTH),
        .WGT_WIDTH(WGT_WIDTH),
        .MULT_OUT_WIDTH(MULT_OUT_WIDTH),
        .PE_OUT_WIDTH(PE_OUT_WIDTH)
    ) pe_ (
        .clk(clk),
        .reset(reset),
        .operation_signal_in(operation_signal_in),
        
        .act_data_in(act_data_in),
        .wgt_data_in(wgt_data_in),
        .result_in(result_in),
        .result_out(result_out)
    );

    initial begin
        clk = 0;
        reset = 1;
        operation_signal_in=0;
        act_data_in =0;
        wgt_data_in =0;
        result_in =0;
        #1

        reset = 0;
        operation_signal_in=0;
        act_data_in =0;
        wgt_data_in =0;
        result_in =0;
        #1
        $display("----w_load----");
        operation_signal_in='b001;
        act_data_in =1; //fake_value
        wgt_data_in =3; //weight
        result_in =4;   //fake_value
        #1
        $display("----w_flow----");
        operation_signal_in='b000;
        act_data_in =1; //act
        wgt_data_in =5; //fake_value
        result_in   =0; //psum
        #1
        if(result_out == 3) begin
            $display("  PASS  ");
        end else begin
            $display("  FAIL  ");
            $display("Actual result is : %b", 3);
        end
        act_data_in =3; //act
        wgt_data_in =5; //fake_value
        result_in   =11; //psum
        #1
        if(result_out == 20) begin
            $display("  PASS  ");
        end else begin
            $display("  FAIL  ");
            $display("Actual result is : %b", 20);
        end
        act_data_in =6; //act
        wgt_data_in =5; //fake_value
        result_in   =3; //psum
        #1
        if(result_out == 21) begin
            $display("  PASS  ");
        end else begin
            $display("  FAIL  ");
            $display("Actual result is : %b", 21);
        end
        $display("acc_reset");
        reset = 1;
        #1
        $display("os_flow");
        reset =0;
        operation_signal_in='b100;
        act_data_in =10; //act
        wgt_data_in =10; //wgt
        result_in   =999; //fake_value
        #1 //result = xx
        act_data_in =10; //act
        wgt_data_in =10; //wgt
        result_in   =999; //fake_value
        #1  //result = xx
        $display("os_drain");
        operation_signal_in='b110;
        act_data_in =77; //fake
        wgt_data_in =77; //fake
        result_in   =0;
        if(result_out == 200) begin
            $display("  PASS  ");
        end else begin
            $display("  FAIL  ");
            $display("Actual result is : %b", 200);
        end
    end
    always #0.5 clk = !clk;

endmodule