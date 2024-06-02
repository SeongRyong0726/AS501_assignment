`timescale 100ns/1ns
module mux_2_to_1 #(
  parameter integer WIDTH     = 8        // Data Width
) (
  input  wire                                     sel,
  input  wire        [ WIDTH       -1 : 0 ]    data_in_t,
  input  wire        [ WIDTH       -1 : 0 ]    data_in_f,
  output wire        [ WIDTH       -1 : 0 ]    data_out
);

assign data_out = sel ? data_in_t : data_in_f;

endmodule