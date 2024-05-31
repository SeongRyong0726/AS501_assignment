`timescale 100ns/1ns

module tb_bram_combine ();
    reg clk;
    reg reset;
    
    reg [31:0]sp_addr;
    reg [31:0]sp_data_in;
    reg [3:0]sp_web;
    
    reg [31:0]a_addr;
    reg [31:0]a_data_in;
    reg [3:0]a_web;

    reg [31:0]w_addr;
    reg [31:0]w_data_in;
    reg [3:0]w_web;
    
    reg [31:0]O_addr;
    wire [31:0]O_data;
    

    /* Check the name of your module 'CS411_task1_wrapper'. */
    /* If your module name differ form 'CS411_task1_wrapper', you have to change below name. */ 
    design_1_wrapper aaa (
        .clk(clk),
        .reset(reset),
        .sp_addr(sp_addr),
        .sp_data_in(sp_data_in),
        .sp_web(sp_web),
        .a_addr(a_addr),
        .a_data_in(a_data_in),
        .a_web(a_web),
        .w_addr(w_addr),
        .w_data_in(w_data_in),
        .w_web(w_web),
        .O_data(O_data),
        .O_addr(O_addr)    
    );
  
    integer i;
    integer j;
    initial begin
        clk = 1;
        reset = 1;
        sp_addr = 0;
        sp_data_in = 0;
        sp_web = 0;
        a_addr = 0;
        a_data_in = 0;
        a_web = 0;
        w_addr = 0;
        w_data_in = 0;
        w_web = 0;
        O_addr = 0;
        #10
        /* set SP BRAM */
        /* We will do 4 tests with this variables 
        TEST x : (mode, M, K, N) 
        TEST 1 : (0 and 1, 8, 8, 8)
        TEST 2 : (0 and 1, 7, 8, 3)
        TEST 3 : (0 and 1, 3, 4, 2)
        TEST 4 : (0 and 1, 6, 7, 3)
        */
        /* Following testbench code is for TEST 2 OS (1, 7, 8, 3) */
        reset = 0;
        sp_web=4'b1111;
        #1
        sp_addr=4; 
        sp_data_in=1; //MODE
        #1
        sp_addr=8; 
        sp_data_in=7; //M
        #1
        sp_addr=12; 
        sp_data_in=8; //K
        #1
        sp_addr=16; 
        sp_data_in=3; //N
        #1

        /* set inputs in A, W BRAM */
        sp_web = 4'b0000;
        a_web=4'b1111;
        w_web=4'b1111;

        #1
        /* (import) input value may be random values */
        for(i=0; i<8*8; i=i+1)
        begin
                a_addr = i*4;
                a_data_in = -2;  
                w_addr = i*4;
                w_data_in = 2;
        #1;
        end

        /* Set start SIGNAL */
        a_web=4'b0000;
        w_web=4'b0000;
        #10
        sp_web=4'b1111;
        sp_addr=0; 
        sp_data_in=1;
        #5 
        /*
            END value setting on BRAM
            After you generate bitstream and make FPGA work, 
            previous process is done by Jupyter notebook python code.
        */

        sp_web=4'b0000;
        a_web=4'b0000;
        w_web=4'b0000;

        /* Wait enough time to finish systolic array operation */
        #300
        /* Check the contents of O_BRAM, you have to use memory (O_BEAM) minimally */
        /* Inserting one element (1 byte) into each 4-byte space of O_BRAM is the default rule. 
           (It does not require inserting 4 elements into the 4-byte space.) 
           Refer to the code below to verify the results. */
        for(i=0; i< 7 * 3 ; i=i+1) /*7 x 3 = M x N*/
        begin
            O_addr = i*4;
            #0.5;
             if(O_data ==  8*(-4)) begin /* = K */
                 $display("  Right  ");
             end else begin
                 $display("  Wrong value  ");
             end
            #0.5;
        end

      
      
    end
  
  always #0.5 clk = !clk;
endmodule
