`timescale 100ns/10ns

module tb_bram_combine ();
    reg clk;

    
    reg [31:0]addr;
    reg [31:0]data_in;
    reg [3:0]web;


    wire [5:0] DEBUG_STATE;

    

    /* Check the name of your module 'CS411_task1_wrapper'. */
    /* If your module name differ form 'CS411_task1_wrapper', you have to change below name. */ 
    design_1_wrapper aaa (
        .clk(clk),

        .addr(addr),
        .data_in(data_in),
        .web(web),
        .DEBUG_state(DEBUG_STATE)
    );

    initial begin
        clk = 1;
        addr = 0;
        data_in = 0;
        web = 0;
        #10
        web=4'b1111;
        #1
        addr=0; 
        data_in=1; //MODE 0

        #1
        /* set inputs in A, W BRAM */
        web = 4'b0000;

      
      
    end
  
  always #0.5 clk = !clk;
endmodule
