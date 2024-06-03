`timescale 100ns/1ns
module npu_controller #(
    parameter integer DWidth = 32,
    parameter integer ADDR_WIDTH = 32

) (
// EXT - CTRL
    // Basic signals
    input   wire                   clk_i,
    input   wire                   rst_ni,
    // From interface
    input   wire                   cen_i,
    input   wire                   wen_i,
    input   wire   [ADDR_WIDTH-1:0]    addr_i,
    input   wire   [DWidth-1:0]    wdata_i,
    // To master
    output  wire   [DWidth-1:0]    rdata_o
// CTRL - SYS_SYSTEM
    //A buf READ (BUF --> SA : FSM)
    output wire                          a_buf_on,
    output wire [ADDR_WIDTH-1:0]         a_base_addr,
    output wire [$clog2(ARRAY_N) : 0]    a_num_rows, //dimension (M)
    //A buf WRITE (EXT --> BUF)
    output wire [32-1:0]                 a_ram_w_data,
    output wire      [ADDR_WIDTH-1:0]    a_ram_w_addr,
    output wire      [ARRAY_N-1:0]       a_ram_w_en,

    //W_buf READ  (BUF --> SA : FSM)
    output wire                          mode,
    output wire                          w_buf_on,
    output wire [ADDR_WIDTH -1:0]        w_base_addr,
    output wire [$clog2(ARRAY_N):0]      w_num_cols, //dimension (N)
    //W buf WRITE   (EXT --> BUF)
    output wire [32-1:0]                 w_ram_w_data,
    output wire      [ADDR_WIDTH-1:0]    w_ram_w_addr,
    output wire      [ARRAY_M-1:0]       w_ram_w_en,

    //systolic array (FSM)
    output wire [2:0]                    operation_signal_in,

    //SIMD  (EXT --> BUF)
    output wire [$clog2(ARRAY_N) : 0]    w_index_bias,
    output wire [OUT_WIDTH -1 : 0]       w_data_bias,
    output wire                          w_en_bias,
    //O_buffer READ (SA --> BUF : FSM)
    output wire                          o_ag_o_on,
    output wire [ADDR_WIDTH -1 : 0]      o_base_addr,
    //O_buffer READ ( BUF --> EXT)
    output wire [$clog2(ARRAY_M)-1:0]    o_ram_idx,
    output wire [ADDR_WIDTH-1 : 0]       o_read_addr,
    //Intra_net  (O_BUF --> A_BUF : FSM)
    output wire                          Intranet_on,
    output wire                          Intra_sig_start,
    output wire[ADDR_WIDTH-1:0]          Intra_O_base_addr,
    output wire[ADDR_WIDTH-1:0]          Intra_A_base_addr,
    input wire                         Intra_sig_end, //??? 안쓰는 중
    //O_buf WRITE
    input wire [32-1:0]         data_in_o_bram,
    input wire [$clog2(ARRAY_N)-1 : 0] max_idx_value

);
    //REGISTERS
    reg [4:0] operation_type;
    reg [4:0] state_reg;
    reg [32:0] count;
        //parameter
    // reg op_start;                                   //addr0
    reg op_end;                                     //addr4
    reg [ADDR_WIDTH-1:0] a_base_addr; 
    reg [$clog2(ARRAY_N) : 0] a_num_rows;  
    reg [ADDR_WIDTH-1:0] w_base_addr; 
    reg [$clog2(ARRAY_N):0] w_num_cols;  
    reg [ADDR_WIDTH -1 : 0]  o_base_addr; 
    reg [ADDR_WIDTH-1:0] Intra_O_base_addr; 
    reg [ADDR_WIDTH-1:0] Intra_A_base_addr; 
    //DECODER
    npu_decoder #(
        .DWidth(DWidth),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) npu_decoder_inst (
        // Basic signals
        .clk_i(clk_i),
        .rst_ni(rst_ni),
        // From interface
        .cen_i(cen_i),
        .wen_i(wen_i),
        .addr_i(addr_i), //[DWidth]
        .wdata_i(wdata_i),//[DWidth]
        // 
        .op_type(op_type)
    );
        
    //FSM
        //instr _ get_max_data
        //instr _ st_data (parameter, bias, act, weight)
        
        //TODO decoding addr

        assign a_ram_w_addr = (operation_type=='b1000)? (addr_i - NPU_IMEM_Start)/(ARRAY_DIM*4) : 32'bz;
        assign a_ram_w_data = (operation_type=='b1000)? (wdata_i) : 8'bz;
        assign a_ram_w_en_pre = ((addr_i - NPU_IMEM_Start)/4)%ARRAY_DIM ;

        assign w_ram_w_addr = (operation_type=='b1001)? (addr_i - NPU_WMEM_Start)/(ARRAY_DIM*4) : 32'bz;
        assign w_ram_w_data = (operation_type=='b1001)? (wdata_i) : 8'bz;
        assign w_ram_w_en_pre = ((addr_i - NPU_WMEM_Start)/4)%ARRAY_DIM;

        assign w_index_bias = (operation_type=='b1010)? (addr_i - NPU_BMEM_Start)/ARRAY_DIM : 32'bz;
        assign w_data_bias = (operation_type=='b1010)? (wdata_i) : 8'bz;
        assign w_en_bias_pre = ((addr_i - NPU_BMEM_Start)/4)%ARRAY_DIM;

        wire [$clog2(ARRAY_DIM)-1:0] w_ram_w_en_pre;
        wire [$clog2(ARRAY_DIM)-1:0] w_en_bias_pre;
        wire [$clog2(ARRAY_DIM)-1:0] a_ram_w_en_pre;
        wire [$clog2(ARRAY_DIM)-1:0] decoder_in; 
        wire [$clog2(ARRAY_DIM)-1:0] decoder_out; 

        assign decoder_in = (operation_type=='b1000)? a_ram_w_en_pre : ((operation_type=='b1001)? w_ram_w_en_pre:w_en_bias_pre);
        onehot_encoder #(
            .DWidth(4)
        ) onehot_decoder_inst (
            .data_i(decoder_in),
            .data_o(decoder_out)
        );
        
        assign a_ram_w_en = (operation_type=='b1000)? decoder_out : 16'bz;
        assign w_ram_w_en = (operation_type=='b1001)? decoder_out : 16'bz;
        assign w_en_bias = (operation_type=='b1010)? decoder_out : 16'bz;
        
        o_ram_idx = {$clog2(ARRAY_M){'bz}};
        o_read_addr = (operation_type == 'b1010)? (addr_i - MEM_OMEM_Start): {ADDR_WIDTH{'bz}};
        
        rdata_o = (addr_i == NPU_PARA_Start +'b000100)? op_end : {12b'0,max_idx_value, data_in_o_bram[15:0]};
        //obuf

        //parameter
        always @(posedge clk or negedge reset)
        begin
            case(addr_i - NPU_PARA_Start)
                    // 'b000000:  
                    //     op_start <= wdata_i;
                    'b000100:  
                        op_end <= wdata_i;
                    'b001000:  
                        a_base_addr <= wdata_i;
                    'b001100:  
                        a_num_rows <= wdata_i;
                    'b010000: 
                        w_base_addr <= <= wdata_i;
                    'b010100:
                        w_num_cols <= wdata_i;
                    'b011000:
                        o_base_addr <= wdata_i;
                    'b011100:
                        Intra_O_base_addr <= wdata_i;
                    'b100000
                        Intra_A_base_addr <= wdata_i;
                    default: 

            endcase
        end
    //FSM    
        //instr _ os_op
        //instr _ out2act
        
        parameter idle          = 5'b00000;
        parameter OS_FLOW1      = 5'b10000;
        parameter OS_FLOW2      = 5'b10001;
        parameter OS_DRAIN      = 5'b10010;
        parameter OS_ST_RAM     = 5'b10011;
        parameter OS_END        = 5'b10100;
        parameter INTRA_START   = 5'b11000;
        parameter INTRA_END     = 5'b11001;

        always @(posedge clk or negedge reset)
        begin
                operation_type <= op_type;
                if (!reset)
                    state_reg <= idle;
                else
                    case (state_reg)
                        idle:
                            a_buf_on = 0;
                            // a_base_addr = 0; //reg
                            // a_num_rows = 0;  //reg
                            mode = 1; //OS mode
                            w_buf_on = 0;
                            // w_base_addr = 0; //reg
                            // w_num_cols = 0;  //reg
                            operation_signal_in = 0;
                            o_ag_o_on = 0;
                            // o_base_addr = 0; //reg
                            Intranet_on = 0;
                            Intra_sig_start = 0;
                            // Intra_O_base_addr = 0; //reg
                            // Intra_A_base_addr = 0; //reg
                            count <= 0;
                            if (operation_type == 'b0000/* os */)
                                state_reg <= OS_FLOW1;
                            else if (operation_type == 'b0001/* flow */)
                                state_reg <= INTRA_START;
                        OS_FLOW1:
                            a_buf_on    = 1;
                            w_buf_on    = 1;
                            operation_signal_in = 3'b100;
                            if (count == K)  //K
                                state_reg <= finish;
                                count <= 0;
                            else
                                count <= count +1;

                        OS_FLOW2:
                            a_buf_on    = 0;
                            w_buf_on    = 0;
                            operation_signal_in = 3'b100;
                            if (count == M + N -1)  //row_dim + col_dim -1
                                state_reg <= finish;
                                count <= 0;
                            else
                                count <= count +1;
                            
                        OS_DRAIN:
                            operation_signal_in = 3'b110;
                            if (count == 16 - M)  //ARRAY_DIM - row_dim
                                state_reg <= finish;
                                count <= 0;
                            else
                                count <= count +1;
                            
                            
                        OS_ST_RAM:
                            o_ag_o_on = 1;
                            if (count == M + 1)  // row_dim +1
                                state_reg <= finish;
                                count <= 0;
                            else
                                count <= count +1;
                        OS_END:
                            o_ag_o_on = 0;
                            op_end <= 1;
                            if (count == 0)
                                sa_reset <= 1;
                            else 
                                sa_reset <= 0;
                              
                            if (count == 3)  
                                state_reg <= idle;
                                count <= 0;
                            else   
                                count <= count +1;
                        INTRA_START:
                            Intranet_on = 1;
                            Intra_sig_start = 1;
                            Intra_O_base_addr = 0;
                            Intra_A_base_addr = 100;
                            
                            if (count == M+16-1)  // (row_dim + DIM - col_dim -1) + col_dim
                                state_reg <= INTRA_END;
                                count <= 0;
                            else 
                                count <= count +1;
                        INTRA_END:
                            Intranet_on = 0;
                            Intra_sig_start = 0;
                            Intra_O_base_addr = 0;
                            Intra_A_base_addr = 0;
                            op_end <= 1;
                            state_reg <= idle;
                        default:
                                state_reg <= idle;
                    endcase
        end

endmodule