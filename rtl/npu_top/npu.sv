module NPU #(
    parameter DWidth = 32,
    parameter ARRAY_N=16,
    parameter ARRAY_M=16,
    parameter ACT_WIDTH = 8,
    parameter WGT_WIDTH = 8,
    parameter PE_OUT_WIDTH = 32,
    parameter RAM_SIZE = 1<<10,
    parameter ADDR_WIDTH = 32 //??
)(
    // Basic signals
    input   logic                   clk_i,
    input   logic                   rst_ni,
    // From interface
    input   logic                   cen_i,
    input   logic                   wen_i,
    input   logic   [DWidth-1:0]    addr_i,
    input   logic   [DWidth-1:0]    wdata_i,
    // To master
    output  logic   [DWidth-1:0]    rdata_o
);
    wire                          a_buf_on;
    wire [ADDR_WIDTH-1:0]         a_base_addr;
    wire [$clog2(ARRAY_N) : 0]    a_num_rows; //dimension (M)
    wire [32-1:0]                 a_ram_w_data;
    wire      [ADDR_WIDTH-1:0]    a_ram_w_addr;
    wire      [ARRAY_N-1:0]       a_ram_w_en;
    wire                          mode;
    wire                          w_buf_on;
    wire [ADDR_WIDTH -1:0]        w_base_addr;
    wire [$clog2(ARRAY_N):0]      w_num_cols; //dimension (N)
    wire [32-1:0]                 w_ram_w_data;
    wire      [ADDR_WIDTH-1:0]    w_ram_w_addr;
    wire      [ARRAY_M-1:0]       w_ram_w_en;
    wire [2:0]                    operation_signal_in;
    wire [$clog2(ARRAY_N) : 0]    w_index_bias;
    wire [OUT_WIDTH -1 : 0]       w_data_bias;
    wire                          w_en_bias;
    wire                          o_ag_o_on;
    wire [ADDR_WIDTH -1 : 0]      o_base_addr;
    wire [$clog2(ARRAY_M)-1:0]    o_ram_idx;
    wire [ADDR_WIDTH-1 : 0]       o_read_addr;

    wire                          Intranet_on;
    wire                          Intra_sig_start;
    wire[ADDR_WIDTH-1:0]          Intra_O_base_addr;
    wire[ADDR_WIDTH-1:0]          Intra_A_base_addr;
    wire                         Intra_sig_end; //??? 안쓰는 중

    wire [32-1:0]         data_in_o_bram;
    wire [$clog2(ARRAY_N)-1 : 0] max_idx_value;


    npu_controller #(
        .DWidth(DWidth),
        .ADDR_WIDTH(DWidth)
    ) npu_controller_inst (
        .clk_i(clk_i),
        .rst_ni(rst_ni),
        .cen_i(cen_i),
        .wen_i(wen_i),
        .addr_i(addr_i),
        .wdata_i(wdata_i),
        .rdata_o(rdata_o),

        .a_buf_on(a_buf_on),
        .a_base_addr(a_base_addr),
        .a_num_rows(a_num_rows),
        .a_ram_w_data(a_ram_w_data),
        .a_ram_w_addr(a_ram_w_addr),
        .a_ram_w_en(a_ram_w_en),

        .mode(mode),
        .w_buf_on(w_buf_on),
        .w_base_addr(w_base_addr),
        .w_num_cols(w_num_cols),
        .w_ram_w_data(w_ram_w_data),
        .w_ram_w_en(w_ram_w_en),

        .operation_signal_in(operation_signal_in),

        .w_index_bias(w_index_bias),
        .w_data_bias(w_data_bias),
        .w_en_bias(w_en_bias),

        .o_ag_o_on(o_ag_o_on),
        .o_base_addr(o_base_addr),
        .o_ram_idx(o_ram_idx),
        .o_read_addr(o_read_addr),

        .Intranet_on(Intranet_on),
        .Intra_sig_start(Intra_sig_start),
        .Intra_O_base_addr(Intra_O_base_addr),
        .Intra_A_base_addr(Intra_A_base_addr),
        .Intra_sig_end(Intra_sig_end),

        .data_in_o_bram(data_in_o_bram),
        .max_idx_value(max_idx_value)
    );
    
    systolic_system_adv #(
        .ARRAY_N(ARRAY_N),
        .ARRAY_M(ARRAY_M),
        .ACT_WIDTH(ACT_WIDTH),
        .WGT_WIDTH(WGT_WIDTH),
        .PE_OUT_WIDTH(PE_OUT_WIDTH),
        .RAM_SIZE(RAM_SIZE),
        .DATA_WIDTH(PE_OUT_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) systolic_system_adv_inst (
        .clk(clk),
        .reset(!rst_ni),
        .sa_reset(sa_reset),

        .a_buf_on(a_buf_on),
        .a_base_addr(a_base_addr),
        .a_num_rows(a_num_rows),
        .a_ram_w_data(a_ram_w_data),
        .a_ram_w_addr(a_ram_w_addr),
        .a_ram_w_en(a_ram_w_en),

        .mode(mode),
        
        .w_buf_on(w_buf_on),
        .w_base_addr(w_base_addr),
        .w_num_cols(w_num_cols),
        .w_ram_w_data(w_ram_w_data),
        .w_ram_w_addr(w_ram_w_addr),
        .w_ram_w_en(w_ram_w_en),

        .operation_signal_in(operation_signal_in),

        .w_index_bias(w_index_bias),
        .w_data_bias(w_data_bias),
        .w_en_bias(w_en_bias),
        
        .o_ag_o_on(o_ag_o_on),
        .o_base_addr(o_base_addr),
        .o_ram_idx(o_ram_idx),
        .o_read_addr(o_read_addr),

        .Intranet_on(Intranet_on),
        .Intra_sig_start(Intra_sig_start),
        .Intra_O_base_addr(Intra_O_base_addr),
        .Intra_A_base_addr(Intra_A_base_addr),
        .Intra_sig_end(Intra_sig_end),

        .data_in_o_bram(data_in_o_bram),
        .max_idx_value(max_idx_value)
    )

////////////////////////////////////////////////////////////////////////////////

endmodule