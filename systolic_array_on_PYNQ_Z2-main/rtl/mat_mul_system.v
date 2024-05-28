`timescale 100ns/1ns
module mat_mul_system #(
    parameter integer NUM_VAR = 11,
    

    parameter integer ARRAY_N = 8,
    parameter integer ARRAY_M = 8,

    parameter integer ACT_WIDTH = 16,
    parameter integer WGT_WIDTH = 16,
    parameter integer PE_OUT_WIDTH = 32,

    parameter integer RAM_SIZE = 1024,
    parameter integer ADDR_WIDTH = $clog2(RAM_SIZE),
    
    parameter integer DEPTH = 8,
    parameter integer DATA_WIDTH = 32,
    parameter integer OUT_WIDTH = 32,
    parameter integer IBUF_DATA_WIDTH = ACT_WIDTH * ARRAY_N
    
) (
    input wire clk,

    //SP_BRAM
    output wire [32-1:0]         ext_addr_sp_bram,//[32-1:0][5:0]
    output wire                  enable_sp_bram,
    input wire [32-1:0]          ext_data_out_sp_bram,//[32-1:0][8-1:0]    
    output wire [4-1 :0]         w_enable_sp_bram,
    output wire [32-1:0]         ext_data_in_sp_bram,//[32-1:0][8-1:0]
    //A_BRAM
    output wire [32-1:0]        ext_addr_a_bram,//[32-1:0][9-1:0] 
    output wire                  enable_a_bram,
    input wire [32-1:0]         ext_data_out_a_bram,//[32-1:0][8-1:0]
    //W_BRAM
    output wire [32-1:0]         ext_addr_w_bram,//[32-1:0][9-1:0]
    output wire                  enable_w_bram,
    input wire [32-1:0]         ext_data_out_w_bram,//[32-1:0][8-1:0]
    //O_BRAM
    output wire [32-1:0]         ext_addr_o_bram,//[32-1:0][9-1:0]
    output wire                  enable_o_bram,
    output wire [4-1 :0]         w_enable_o_bram,
    output wire [32-1:0]         data_in_o_bram,
    //DEBUG
    output wire [5:0]            DEBUG_state,
    output wire [IBUF_DATA_WIDTH-1:0]   DEBUG_act_data_set,
    output wire [IBUF_DATA_WIDTH-1:0]   DEBUG_wgt_data_set,
    output wire [PE_OUT_WIDTH*ARRAY_M-1:0] DEBUG_result_data_set
);
//====DESCRIBE I/O port================================================
//      SP num of data (max) < 8            (3bit addr)
//      ACT / WGT num of data (max) => 32x8 = 512 (9bit addr)
//      ACT / WGT data (1byte) => data_width  8
//      OUT num of data (const) 8x8 = 64
//      
// //SP_BRAM
//     wire [32-1:0]           ext_addr_sp_bram;//   [3:0] 
//     assign addr_sp_bram =  ext_addr_sp_bram [5:0];
// //    assign ext_addr_sp_bram = {{29'b0},addr_sp_bram};
//     //wire [32-1:0]          ext_data_out_sp_bram;//[8-1:0]   yyyyyyyyyyy
//     //assign ext_data_out_sp_bram = {{24'b0},data_out_sp_bram};//yyyyyyyyyyy
//     wire [32-1:0]           ext_data_in_sp_bram;//[8-1:0]  
//     assign data_in_sp_bram = ext_data_in_sp_bram[7:0]; 
// //    assign  ext_data_in_sp_bram = {{24'b0},data_in_sp_bram};
//     //A_BRAM
//     wire [32-1:0]           ext_addr_a_bram;//[9-1:0] 
//     assign addr_a_bram = ext_addr_a_bram [8:0];
// //    assign ext_addr_a_bram = {{23'b0},addr_a_bram};
//     //wire [32-1:0]           ext_data_out_a_bram;//[8-1:0]yyyyy
//     //assign ext_data_out_a_bram = {{24'b0},data_out_a_bram};   yyyyyyyyyy
//     //W_BRAM
//     wire [32-1:0]           ext_addr_w_bram;//[[9-1:0] 
//     assign addr_w_bram = ext_addr_w_bram[8:0];
//    assign ext_addr_w_bram = {{23'b0},addr_w_bram};
    ///////wire [32-1:0]         ext_data_out_w_bram;//[8-1:0]/yyyyyyyy
    ////////assign ext_data_out_w_bram = {{24'b0},data_out_w_bram}; yyyyyyyyyyy
    //O_BRAM
    // wire [32-1:0]           ext_addr_o_bram;//[9-1:0] 
    // assign addr_o_bram = ext_addr_o_bram[8:0];
//    assign ext_addr_o_bram = {{23'b0},addr_o_bram};
     
//==================================================================
    //====  not use port  =======

//    assign w_enable_a_bram = 4'b0000;
//    assign data_in_a_bram = 32'b0;
//    assign w_enable_w_bram =  4'b0000;
//    assign data_in_w_bram = 32'b0;

    //===========================     
    wire                          a_buf_on;
    wire  [ADDR_WIDTH-1:0]         a_base_addr;
    wire [$clog2(ARRAY_N) : 0]    a_num_rows;
    wire                          mode;
    wire                          w_buf_on;
    wire [ADDR_WIDTH -1:0]        w_base_addr;
    wire [$clog2(ARRAY_N):0]      w_num_cols;
    wire [2:0]                    operation_signal_in;
    wire                          o_idx_gen_on;
    wire                          o_ag_o_on;
    wire                          o_drain;
    wire [ADDR_WIDTH -1 : 0]      o_base_addr;
    wire [$clog2(ARRAY_M)-1:0]    o_ram_idx;
    wire [ADDR_WIDTH-1 : 0]       o_read_addr;
    wire [ARRAY_N-1:0] bram_to_a_ram_w_en;
    wire [ARRAY_M-1:0] bram_to_w_ram_w_en;
    wire [31:0]     DEBUG_matmul_var_1;
    wire [31:0]     DEBUG_matmul_var_2;
    wire [31:0]     DEBUG_matmul_var_3;
    wire [31:0]     DEBUG_matmul_var_4;    

    //DEBUG
    //assign DEBUG_bram_to_a_ram_w_en = bram_to_a_ram_w_en;
    fsm_copy #(
        .NUM_VAR(NUM_VAR),
        .ARRAY_M(ARRAY_M),
        .ARRAY_N(ARRAY_N),
        .ACT_WIDTH(ACT_WIDTH),
        .WGT_WIDTH(WGT_WIDTH),
        .PE_OUT_WIDTH(PE_OUT_WIDTH),
        .RAM_SIZE(RAM_SIZE),
        .DEPTH(DEPTH),
        .DATA_WIDTH(DATA_WIDTH),
        .OUT_WIDTH(OUT_WIDTH)
    ) fsm_inst_ (
        .clk(clk),
        .addr_sp_bram(ext_addr_sp_bram),
        .enable_sp_bram(enable_sp_bram),
        .data_out_sp_bram(ext_data_out_sp_bram),
        .w_enable_sp_bram(w_enable_sp_bram),
        .data_in_sp_bram(ext_data_in_sp_bram),
            //A_BRAM
        .addr_a_bram(ext_addr_a_bram),                  //
        .enable_a_bram(enable_a_bram),              //
        .bram_to_a_ram_w_en(bram_to_a_ram_w_en),    //
            //W_BRAM
        .addr_w_bram(ext_addr_w_bram),                  //
        .enable_w_bram(enable_w_bram),              //
        .bram_to_w_ram_w_en(bram_to_w_ram_w_en),    //
            //O_BRAM
        .addr_o_bram(ext_addr_o_bram),
        .enable_o_bram(enable_o_bram),
        .w_enable_o_bram(w_enable_o_bram),

        .system_reset(system_reset),
        .acc_reset(acc_reset),
        .A_ram_reset(A_ram_reset),
        .W_ram_reset(W_ram_reset),
        .O_ram_reset(O_ram_reset),
        .array_contents_reset(array_contents_reset),
        //A buf
        .a_buf_on(a_buf_on),///
        .a_base_addr(a_base_addr),///
        .a_num_rows(a_num_rows),///
        //W_buf
        .mode(mode),///
        .w_buf_on(w_buf_on),///
        .w_base_addr(w_base_addr),///
        .w_num_cols(w_num_cols),///
        //systolic array
        .operation_signal_in(operation_signal_in),///
        //O_buffer
        .o_idx_gen_on(o_idx_gen_on),///
        .o_ag_o_on(o_ag_o_on),///
        .o_drain(o_drain),///
        .o_base_addr(o_base_addr),///
        .o_ram_idx(o_ram_idx),///
        .o_read_addr(o_read_addr), ///
        // //DEBUG
        .DEBUG_state(DEBUG_state),
        .DEBUG_matmul_var_1(DEBUG_matmul_var_1), //mode
        .DEBUG_matmul_var_2(DEBUG_matmul_var_2), // M
        .DEBUG_matmul_var_3(DEBUG_matmul_var_3), // K
        .DEBUG_matmul_var_4(DEBUG_matmul_var_4)  // N
    );
    reg [31:0] delay_ext_addr_a_bram;
    reg [ARRAY_M-1:0] delay_bram_to_a_ram_w_en;
    reg [31:0] delay_ext_addr_w_bram;
    reg [ARRAY_M-1:0] delay_bram_to_w_ram_w_en;
    //delay due to bram read take 1 cycle
    always @(posedge clk)
    begin
        if(system_reset)
        begin    
            delay_ext_addr_a_bram <= 0;
            delay_bram_to_a_ram_w_en <= 0;
            delay_ext_addr_w_bram <= 0;
            delay_bram_to_w_ram_w_en <= 0;
        end
        else
        begin
            delay_ext_addr_a_bram <= ext_addr_a_bram;
            delay_bram_to_a_ram_w_en <= bram_to_a_ram_w_en;
            delay_ext_addr_w_bram <= ext_addr_w_bram;
            delay_bram_to_w_ram_w_en <= bram_to_w_ram_w_en;
        end
    end
    

    systolic_system #(
        .ARRAY_M(ARRAY_M),
        .ARRAY_N(ARRAY_N),
        .ACT_WIDTH(ACT_WIDTH),
        .WGT_WIDTH(WGT_WIDTH),
        .PE_OUT_WIDTH(PE_OUT_WIDTH),
        .RAM_SIZE(RAM_SIZE),
        .DEPTH(DEPTH),
        .DATA_WIDTH(DATA_WIDTH),
        .OUT_WIDTH(OUT_WIDTH)
    ) sys_sys_inst_ (
        .clk(clk),
        .reset(system_reset),
        .acc_reset(acc_reset),
        .A_ram_reset(A_ram_reset),
        .W_ram_reset(W_ram_reset),
        .O_ram_reset(O_ram_reset),
        .array_contents_reset(array_contents_reset),

        .a_buf_on(a_buf_on),///
        .a_base_addr(a_base_addr),///
        .a_num_rows(a_num_rows),///
        .bram_to_a_ram_w_data(ext_data_out_a_bram),             //
        .bram_to_a_ram_w_addr(delay_ext_addr_a_bram),                 // delayed addr
        .bram_to_a_ram_w_en(delay_bram_to_a_ram_w_en),            // delay enable


        .mode(mode),///
        .w_buf_on(w_buf_on),///
        .w_base_addr(w_base_addr),///
        .w_num_cols(w_num_cols),///
        .bram_to_w_ram_w_data(ext_data_out_w_bram),             //
        .bram_to_w_ram_w_addr(delay_ext_addr_w_bram),                 //
        .bram_to_w_ram_w_en(delay_bram_to_w_ram_w_en),            //

        .operation_signal_in(operation_signal_in),///
        
        .o_idx_gen_on(o_idx_gen_on),///
        .o_ag_o_on(o_ag_o_on),///
        .o_drain(o_drain),///
        .o_base_addr(o_base_addr),///
        .o_ram_idx(o_ram_idx),///
        .o_read_addr(o_read_addr),///

        .data_in_o_bram(data_in_o_bram), //O_BRAM
        .M(DEBUG_matmul_var_2),
        .K(DEBUG_matmul_var_3),
        .N(DEBUG_matmul_var_4),
        // .DEBUG_data(DEBUG_data),
        .DEBUG_act_data_set(DEBUG_act_data_set),
        .DEBUG_wgt_data_set(DEBUG_wgt_data_set),
        .DEBUG_result_data_set(DEBUG_result_data_set)
    );

endmodule