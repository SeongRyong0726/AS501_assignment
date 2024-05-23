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
  parameter integer DATA_WIDTH    = 8,
  parameter integer ADDR_WIDTH    = 12,     // 2048
  parameter integer OUTPUT_REG    = 0
)
(
  input  wire                         clk,
  input  wire                         reset,

  input  wire                         read_req,
  input  wire [ ADDR_WIDTH  -1 : 0 ]  read_addr,
  output signed [ DATA_WIDTH  -1 : 0 ]  read_data,

  input  wire                         write_req,
  input  wire [ ADDR_WIDTH  -1 : 0 ]  write_addr,
  input  wire [ DATA_WIDTH  -1 : 0 ]  write_data
);
  (* ram_style = "block" *)
  reg signed [ DATA_WIDTH -1 : 0 ] mem [ 0 : 1<<ADDR_WIDTH ];
 //  DEBUG start
//  initial begin
//    for (integer i = 0; i < (1 << ADDR_WIDTH); i = i + 1) begin
//      mem[i] = 1;
//    end
//  end//  initial begin
//    for (integer i = 0; i < (1 << ADDR_WIDTH); i = i + 1) begin
//      mem[i] = 1;
//    end
//  end
 //  DEBUG end

integer i;
initial begin
  for (i=0;i<=1<<ADDR_WIDTH;i=i+1)
    mem[i] = 0;
end
integer j;

  always @(posedge clk)
  begin: RAM_WRITE
    /// THIS CAUSE REG OVER UTIL 
    // if(reset) begin
    //   for(j = 0; j < (1 <<ADDR_WIDTH); j = j +1) begin 
    //     mem[i] <= 0;
    //   end
    // end else begin
    if (write_req)
      mem[write_addr] <= write_data;
    // end
    
  end

  generate
    if (OUTPUT_REG == 0)
      assign read_data = mem[read_addr];
    else begin
      reg [DATA_WIDTH-1:0] _read_data;
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
