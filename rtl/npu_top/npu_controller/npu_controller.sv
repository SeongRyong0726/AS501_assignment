`timescale 100ns/1ns
module npu_controller #(
    parameter DWidth = 32,
    parameter ADDR_WIDTH = 32,
    parameter ARRAY_N=16,
    parameter ARRAY_M=16,
    parameter PE_OUT_WIDTH=32
) (
// EXT - CTRL
    // Basic signals
    input   logic                            clk_i,
    input   logic                            rst_ni,
    // From interface
    input   logic                            cen_i,
    input   logic                            wen_i,
    input   logic    [ADDR_WIDTH-1:0]        addr_i,
    output   logic    [ADDR_WIDTH-1:0]       debug1_o,
    output  logic    [ADDR_WIDTH-1:0]        debug2_o,
    input   logic    [DWidth-1:0]            wdata_i,
    // To master
    output  logic    [DWidth-1:0]            rdata_o,
// CTRL - SYS_SYSTEM
    //A buf READ (BUF --> SA : FSM)
    output logic                              a_buf_on,
    output logic      [ADDR_WIDTH-1:0]        a_base_addr,
    output logic      [$clog2(ARRAY_N):0]     a_num_rows, //dimension (M)
    //A buf WRITE (EXT --> BUF)
    output logic     [32-1:0]                a_ram_w_data,
    output logic     [ADDR_WIDTH-1:0]        a_ram_w_addr,
    output logic     [ARRAY_N-1:0]           a_ram_w_en,

    //W_buf READ  (BUF --> SA : FSM)
    output logic                              mode,
    output logic                              w_buf_on,
    output logic      [ADDR_WIDTH-1:0]        w_base_addr,
    output logic      [$clog2(ARRAY_N):0]     w_num_cols, //dimension (N)
    //W buf WRITE   (EXT --> BUF)
    output logic     [32-1:0]                w_ram_w_data,
    output logic     [ADDR_WIDTH-1:0]        w_ram_w_addr,
    output logic     [ARRAY_M-1:0]           w_ram_w_en,

    //systolic array (FSM)
    output logic      [2:0]                   operation_signal_in,

    //SIMD  (EXT --> BUF)
    output logic     [$clog2(ARRAY_N):0]     w_index_bias,
    output logic     [PE_OUT_WIDTH -1:0]     w_data_bias,
    output logic     [ARRAY_N-1:0]           w_en_bias,
    //O_buffer READ (SA --> BUF : FSM)
    output logic                              o_ag_o_on,
    output logic      [ADDR_WIDTH -1:0]       o_base_addr,
    output logic                              sa_reset,
    //O_buffer READ ( BUF --> EXT)
    output logic     [$clog2(ARRAY_M)-1:0]   o_ram_idx,
    output logic     [ADDR_WIDTH-1:0]        o_read_addr,
    //Intra_net  (O_BUF --> A_BUF : FSM)
    output logic                              Intranet_on,
    output logic                              Intra_sig_start,
    output logic      [ADDR_WIDTH-1:0]        Intra_O_base_addr,
    output logic      [ADDR_WIDTH-1:0]        Intra_A_base_addr,
    input logic                              Intra_sig_end, //??? 안쓰는 중
    //O_buf WRITE
    input logic      [8-1:0]                data_in_o_bram,
    input logic      [$clog2(ARRAY_N)-1:0]   max_idx_value,
    //DEBUG
    output logic [3:0] debug3_o
);
    
    import pkg_memorymap::*;
    
    localparam ARRAY_DIM=16;

    enum {
        IDLE,
        OS_FLOW1,
        OS_FLOW2,
        OS_DRAIN,
        OS_ST_RAM,
        OS_END,
        INTRA_START,
        INTRA_END
    } state, state_next;
    
    //logicISTERS
    logic [4:0] operation_type;
    logic [3:0] op_type;
    logic [31:0] count;
    assign debug3_o = state;
    //parameter
    // logic op_start;                                   //addr0
    logic op_end;                                     //addr4
    logic [31:0] K;
    logic [$clog2(ARRAY_DIM)-1:0] w_ram_w_en_pre;
    logic [$clog2(ARRAY_DIM)-1:0] w_en_bias_pre;
    logic [$clog2(ARRAY_DIM)-1:0] a_ram_w_en_pre;
    logic [$clog2(ARRAY_DIM)-1:0] decoder_in; 
    logic [ARRAY_DIM-1:0]         decoder_out; 
    logic [10-1:0]                imem_write_cnt;
    logic [10-1:0]                imem_batch_cnt;
    logic [10-1:0]                wmem_write_cnt;
    logic [10-1:0]                wmem_batch_cnt;
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

    // assign a_ram_w_addr = (operation_type=='b1000)? (addr_i - NPU_IMEM_Start)/(ARRAY_DIM*4) : 32'bz;
    // assign a_ram_w_data = (operation_type=='b1000)? (wdata_i) : 8'bz;
    // assign a_ram_w_en_pre = ((addr_i - NPU_IMEM_Start)/4)%ARRAY_DIM ;

    // assign w_ram_w_addr = (operation_type=='b1001)? (addr_i - NPU_WMEM_Start)/(ARRAY_DIM*4) : 32'bz;
    // assign w_ram_w_data = (operation_type=='b1001)? (wdata_i) : 8'bz;
    // assign w_ram_w_en_pre = ((addr_i - NPU_WMEM_Start)/4)%ARRAY_DIM;

    assign a_ram_w_addr = (operation_type=='b1000)? (addr_i - NPU_IMEM_Start)/(4)-K*imem_batch_cnt : 32'bz;
    assign a_ram_w_data = (operation_type=='b1000)? (wdata_i) : 8'bz;
    assign a_ram_w_en_pre = imem_batch_cnt;

    assign w_ram_w_addr = (operation_type=='b1001)? (addr_i - NPU_WMEM_Start)/(4)-K*wmem_batch_cnt : 32'bz;
    assign w_ram_w_data = (operation_type=='b1001)? (wdata_i) : 8'bz;
    assign w_ram_w_en_pre = wmem_batch_cnt;

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
    
    assign o_ram_idx = {$clog2(ARRAY_M){'bz}};
    assign o_read_addr = (operation_type == 'b1011)? (addr_i - NPU_OMEM_Start)/4: {ADDR_WIDTH{'bz}};
    
    //assign rdata_o = (addr_i == NPU_PARA_Start +'b000100)? op_end : {12'b0,max_idx_value, data_in_o_bram[15:0]};
    //obuf


    
    assign debug1_o = addr_i;
    assign debug2_o  = (NPU_PARA_Start +32'h4);
    always_comb begin
        if (addr_i == (NPU_PARA_Start +32'h4)) begin
            rdata_o = {31'b0 , op_end};
        end
        else begin
            rdata_o = {28'h0, max_idx_value};
            //rdata_o = {12'h000, max_idx_value, 8'h00, data_in_o_bram};
        end
    end

    //assign rdata_o = (addr_i == (NPU_PARA_Start +32'h4))? {31'b0 , op_end} : {12'b0, max_idx_value, 8'b0, data_in_o_bram};
    //obuf

//FSM    
    //instr _ os_op
    //instr _ out2act

    // Stage Transition

     always @ (posedge clk_i or negedge rst_ni) begin
         if (~rst_ni) begin
             imem_write_cnt <= 0;
         end
         else if (state == IDLE) begin
             if ((operation_type=='b1000)&&(wen_i==1'b1)&&(state==IDLE))begin
                 if (imem_write_cnt == K-1) begin
                     imem_write_cnt <= 0;
                 end
                 else begin
                     imem_write_cnt <= imem_write_cnt + 1;
                 end
             end
         end
         else begin
             imem_write_cnt <= 0;
         end
     end
     always @ (posedge clk_i or negedge rst_ni) begin
         if (~rst_ni) begin
             wmem_write_cnt <= 0;
         end
         else if (state == IDLE) begin
             if ((operation_type=='b1001)&&(wen_i==1'b1))begin
                 if (wmem_write_cnt == K-1) begin
                     wmem_write_cnt <= 0;
                 end
                 else begin
                     wmem_write_cnt <= wmem_write_cnt + 1;
                 end
             end
         end
         else begin
             wmem_write_cnt <= 0;
         end
     end
     always @ (posedge clk_i or negedge rst_ni) begin
         if (~rst_ni) begin
             imem_batch_cnt <= 0;
         end
         else if (state == IDLE) begin
             if ((operation_type=='b1000)&&(wen_i==1'b1))begin
                 if (imem_write_cnt == K-1) begin
                     imem_batch_cnt <= imem_batch_cnt + 1;
                 end
             end
         end
         else begin
             imem_batch_cnt <= 0;
         end        
     end
     always @ (posedge clk_i or negedge rst_ni) begin
         if (~rst_ni) begin
             wmem_batch_cnt <= 0;
         end
         else if (state == IDLE) begin
             if ((operation_type=='b1001)&&(wen_i==1'b1))begin
                 if (wmem_write_cnt == K-1) begin
                     wmem_batch_cnt <= wmem_batch_cnt + 1;
                 end
             end
         end
         else begin
             wmem_batch_cnt <= 0;
         end  
     end

    always @ (posedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            state <= IDLE;
        end
        else begin
            state <= state_next;
        end
    end

    always @ (posedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            count <= 0;
        end
        else if (state_next != state) begin
            count <= 0;
        end
        else begin
            count <= count + 1;
        end
    end

    // FSM State Transition
    always_comb
    begin
        operation_type = op_type;
        case (state)
            IDLE:
            begin
                sa_reset = 1;
                a_buf_on = 0;
                mode = 1; //OS mode
                w_buf_on = 0;
                operation_signal_in = 0;
                o_ag_o_on = 0;
                Intranet_on = 0;
                Intra_sig_start = 0;
                op_end = 0;
                if (operation_type == 4'b1111/* os */)
                    state_next = OS_FLOW1;
                else if (operation_type == 4'b0001/* flow */)
                    state_next = INTRA_START;
                else
                    state_next = IDLE;
            end
            OS_FLOW1:
            begin
                sa_reset = 0;
                a_buf_on    = 1;
                w_buf_on    = 1;
                operation_signal_in = 3'b100;
                if (count == K-1) begin  //K
                    state_next = OS_FLOW2;
                end
            end
            OS_FLOW2:
            begin
                a_buf_on    = 0;
                w_buf_on    = 0;
                operation_signal_in = 3'b100;
                if (count == a_num_rows + w_num_cols -1-1) begin //row_dim + col_dim -1
                    if(a_num_rows == ARRAY_N) begin
                        state_next = OS_ST_RAM;
                    end else begin
                        state_next = OS_DRAIN;
                    end
                end
            end
            OS_DRAIN:
            begin
                operation_signal_in = 3'b110;
                if (count == 16 - a_num_rows-1) begin  //ARRAY_DIM - row_dim
                    state_next = OS_ST_RAM;
                end
            end    
            OS_ST_RAM:
            begin
                operation_signal_in = 3'b110;
                o_ag_o_on = 1;
                if (count == a_num_rows + 1-1) begin // row_dim +1
                    state_next = OS_END;
                end
            end
            OS_END:
            begin
                o_ag_o_on = 0;
                op_end = 1;
                if (count == 0) begin
                    sa_reset = 1;
                end
                else begin
                    sa_reset = 0;
                end    
                if (count == 3) begin 
                    state_next <= IDLE;
                end
            end
            INTRA_START:
            begin
                Intranet_on = 1;
                Intra_sig_start = 1;
                
                if (count == a_num_rows+w_num_cols) begin // (row_dim + col_dim -1)
                    state_next = INTRA_END;
                end
            end
            INTRA_END:
            begin
                Intranet_on = 0;
                Intra_sig_start = 0;
                op_end = 1;
                state_next = IDLE;
                operation_type = 0;
            end
            default:
            begin
                state_next = state;
            end
        endcase
    end

    //parameter
    always @(posedge clk_i or negedge rst_ni)
    begin
        case(addr_i - NPU_PARA_Start)
            // 'b000000:  [0]
            //     op_start <= wdata_i;
            // 'b000100:  [1]
            //     op_end <= wdata_i;
            'b001000:  //[2]
                a_base_addr <= wdata_i;
            'b001100:  //[3]
                a_num_rows <= wdata_i; //M
            'b010000: 
                w_base_addr <= wdata_i;
            'b010100:
                w_num_cols <= wdata_i; //N
            'b011000:
                o_base_addr <= wdata_i;
            'b011100:
                Intra_O_base_addr <= wdata_i;
            'b100000:
                Intra_A_base_addr <= wdata_i;
            'b100100:
                K <= wdata_i;  
            // default: 
            //     op_end <= op_end;
        endcase  
    end

endmodule