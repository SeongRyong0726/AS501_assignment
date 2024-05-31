`timescale 100ns/1ns
module fsm_copy #(

    parameter integer NUM_VAR = 8,
    

    parameter integer ARRAY_N = 8,
    parameter integer ARRAY_M = 8,

    parameter integer ACT_WIDTH = 8,
    parameter integer WGT_WIDTH = 8,
    parameter integer PE_OUT_WIDTH = 32,

    parameter integer RAM_SIZE = 1024,
    parameter integer ADDR_WIDTH = $clog2(RAM_SIZE),
    
    parameter integer DEPTH = 8,
    parameter integer DATA_WIDTH = 32,
    parameter integer OUT_WIDTH = 32
    
    

) ( 
    input wire clk,

    
        //special purpose BRAM
    output reg [32-1:0]         addr_sp_bram,
    output reg                  enable_sp_bram,
    input wire [32-1:0]          data_out_sp_bram,
    output reg [4-1 :0]         w_enable_sp_bram,
    output reg [32-1:0]         data_in_sp_bram,
    output wire [5:0]            DEBUG_state        

);
    // =========== STATES =============
    parameter [5:0] IDLE = 6'b0;
    parameter [5:0] NEXT = 6'b1;
    // ============= STATES ===============


    reg [5:0] state; 
    assign DEBUG_state = state;
    // turn on switch
    reg start;

    
    // =========== FSM ==============
    always @(posedge clk)
    begin
        if(start)
        begin
            if(state == IDLE)
            begin
                //bram
                addr_sp_bram    <= 0;
                enable_sp_bram  = 1;
                w_enable_sp_bram <= 'b0;
                data_in_sp_bram <= 0;
                //system
                start <= data_out_sp_bram;
                state <= NEXT;
            end
        end
        else
        begin
            addr_sp_bram    <= 0;
            enable_sp_bram  = 1;
            w_enable_sp_bram <= 'b0;
            data_in_sp_bram <= 0;

            start <= data_out_sp_bram;//data_out_sp_bram;
            state <= IDLE ;
        end

    end
    

endmodule