// -----------------------
// A_buffer.v
// 	?�� address_generator_A.v
// 	?�� ram.v
// -----------------------

`timescale 100ns/1ns
module A_buffer #(
    parameter integer   RAM_SIZE    = 1024,
    parameter integer   ADDR_WIDTH  = $clog2(RAM_SIZE),
    parameter integer   ARRAY_N    = 8,
    parameter integer   ARRAY_M    = 8,
    parameter integer   ACT_WIDTH   = 8,
    parameter integer   IBUF_DATA_WIDTH =  ARRAY_N * ACT_WIDTH
) (
    input wire                  clk,
    input wire                  reset,
    
    input wire                  on,
    input wire      [ADDR_WIDTH-1:0]        base_addr,  // WS : (Depth x max_iter_i) x iter_t + Depth x iter_i       OS: Length x iter_o
    input wire      [$clog2(ARRAY_N) : 0]   num_rows,   // default value ARRAY_N, but on the edge case num_rows is not ARRAY_N 
    //BRAM
    input wire      [ADDR_WIDTH-1:0]        bram_to_ram_w_addr,
    input wire      [ARRAY_N-1:0]           bram_to_ram_w_en,
    input wire      [ACT_WIDTH-1:0]         bram_to_ram_w_data,

    output wire     [IBUF_DATA_WIDTH-1:  0] act_data_set_out     
);
// wire 
wire [IBUF_DATA_WIDTH-1:0]      _act_data_set_out;
wire [ARRAY_N*ADDR_WIDTH-1:0]   _address_to_ram;
wire [ARRAY_N-1:0]                 enable_signal;

// address_generator
adderss_generator_A #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .ARRAY_N(ARRAY_N)
) address_generator_a (
    .clk        (clk),
    .reset      (reset),
    .on         (on),               //input
    .base_addr  (base_addr),        //input
    .num_rows   (num_rows),         //input

    .address    (_address_to_ram),         //output ARRAY_N*ADDR_WIDTH bits
    .enable     (enable_signal)           //output ARRAY_N bits
);


// ram x ARRAY_N
genvar n;
generate
for(n=0; n<ARRAY_N; n=n+1)
begin: RAM_ARRAY
    ram #(
        .DATA_WIDTH(ACT_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .OUTPUT_REG(0) // not use we keep read_addr 
    ) ram_data_provider (
        .clk(clk),
        .reset(reset),
        .read_req(1'b0),   //since we not use REG
        .read_addr(_address_to_ram[ADDR_WIDTH*n+:ADDR_WIDTH]),
        .read_data(_act_data_set_out[ACT_WIDTH*n+:ACT_WIDTH]),   //output
        .write_req(bram_to_ram_w_en[n]),
        .write_addr(bram_to_ram_w_addr),
        .write_data(bram_to_ram_w_data)
    );

    mux_2_to_1 #(
        .WIDTH(ACT_WIDTH)
    ) mux (
        .sel(enable_signal[n]),
        .data_in_t(_act_data_set_out[ACT_WIDTH*n+:ACT_WIDTH]),
        .data_in_f({ACT_WIDTH{1'b0}}),
        .data_out(act_data_set_out[ACT_WIDTH*n+:ACT_WIDTH])
    );
end
endgenerate
    
endmodule