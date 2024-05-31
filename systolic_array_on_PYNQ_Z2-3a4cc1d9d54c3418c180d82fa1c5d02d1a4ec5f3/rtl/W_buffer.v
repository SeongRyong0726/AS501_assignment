// -----------------------
// W_buffer.v
//	??? address_generator_W.v
//	??? ram.v
// -----------------------

// -----------------------
// A_buffer.v
// 	??? address_generator_A.v
// 	??? ram.v
// -----------------------

`timescale 100ns/1ns
module W_buffer #(
    parameter integer   RAM_SIZE    = 1<<8,
    parameter integer   ADDR_WIDTH  = $clog2(RAM_SIZE),
    parameter integer   ARRAY_N    = 8,
    parameter integer   ARRAY_M    = 8,
    parameter integer   WGT_WIDTH   = 8,
    parameter integer   WBUF_DATA_WIDTH =  ARRAY_N * WGT_WIDTH
) (
    input wire                  clk,
    input wire                  reset,

    input wire                          mode,       // 1: OS, 0: WS
    input wire                          on,         //1: on. 0: off  // on signal set 1 for LENGTH cycles
    input wire      [ADDR_WIDTH-1:0]        base_addr,  // WS : (Depth x max_iter_i) x iter_t + Depth x iter_i       OS: Length x iter_o
    input wire      [$clog2(ARRAY_M) : 0]   num_cols,   // default value ARRAY_N, but on the edge case num_rows is not ARRAY_N 
        //BRAM
    input wire      [ADDR_WIDTH-1:0]        bram_to_ram_w_addr,
    input wire      [ARRAY_M-1:0]           bram_to_ram_w_en,
    input wire      [WGT_WIDTH-1:0]         bram_to_ram_w_data,

    output wire     [WBUF_DATA_WIDTH-1:  0] wgt_data_set_out

);
// wire 
wire [WBUF_DATA_WIDTH-1:0]      _wgt_data_set_out;
wire [ARRAY_M*ADDR_WIDTH-1:0]   _address_to_ram;
wire [ARRAY_M-1:0]                 enable_signal;


// address_generator
adderss_generator_W #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .ARRAY_M(ARRAY_M)
) address_generator_w (
    .clk        (clk),
    .reset      (reset),
    .mode       (mode),
    .on         (on),               //input
    .base_addr  (base_addr),        //input
    .num_cols   (num_cols),         //input

    .address    (_address_to_ram),         //output ARRAY_N*ADDR_WIDTH bits
    .enable     (enable_signal)           //output ARRAY_N bits
);


// ram x ARRAY_M
genvar m;
generate
for(m=0; m<ARRAY_M; m=m+1)
begin: RAM_ARRAY
    ram #(
        .DATA_WIDTH(WGT_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .OUTPUT_REG(0) // not use we keep read_addr 
    ) ram_data_provider (
        .clk(clk),
        .reset(reset),
        .read_req(1'b0),   //since we not use REG
        .read_addr(_address_to_ram[ADDR_WIDTH*m+:ADDR_WIDTH]),
        .read_data(_wgt_data_set_out[WGT_WIDTH*m+:WGT_WIDTH]),   //output
        .write_req(bram_to_ram_w_en[m]),
        .write_addr(bram_to_ram_w_addr),
        .write_data(bram_to_ram_w_data)
    );

    mux_2_to_1 #(
        .WIDTH(WGT_WIDTH)
    ) mux (
        .sel(enable_signal[m]),
        .data_in_t(_wgt_data_set_out[WGT_WIDTH*m+:WGT_WIDTH]),
        .data_in_f({WGT_WIDTH{1'b0}}),
        .data_out(wgt_data_set_out[WGT_WIDTH*m+:WGT_WIDTH])
    );
end
endgenerate
    
endmodule