// hardik's code
/*
OUTPUT_REG = 1
    register exist and read takes 1 cycle
OUTPUT_REG = 0
    feed read_addr and get data immediately
*/
`timescale 100ns/1ns
module ram
#(
  parameter integer DATA_WIDTH    = 32,
  parameter integer ADDR_WIDTH    = 12,     // 2048
  parameter integer OUTPUT_REG    = 0
)
(
  input  logic                         clk,
  input  logic                         reset,

  input  logic                         read_req,
  input  logic [ ADDR_WIDTH  -1 : 0 ]  read_addr,
  output signed [ DATA_WIDTH  -1 : 0 ]  read_data,

  input  logic                         write_req,
  input  logic [ ADDR_WIDTH  -1 : 0 ]  write_addr,
  input  logic [ DATA_WIDTH  -1 : 0 ]  write_data
);

logic signed [ DATA_WIDTH -1 : 0 ] mem [0:(1<<ADDR_WIDTH)-1];
//   DEBUG start
 integer i=0;
 initial begin
   for (i = 0; i < (1 << ADDR_WIDTH); i = i + 1) begin
     mem[i] = 32'b1;
   end
 end
//   DEBUG end

  always @(posedge clk)
  begin: RAM_WRITE
    if (write_req)
      mem[write_addr] <= write_data;
  end

  generate
    if (OUTPUT_REG == 0)
      assign read_data = mem[read_addr];
    else begin
      logic [DATA_WIDTH-1:0] _read_data;
      always @(posedge clk)
      begin
        if (reset)
          _read_data <= 0;
        else if (read_req)
          _read_data <= mem[read_addr];
      end
      assign read_data = _read_data;
    end
  endgenerate
endmodule
