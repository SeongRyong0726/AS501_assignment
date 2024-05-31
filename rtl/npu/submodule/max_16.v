
module max_16 #(
    parameter integer DATA_WIDTH = 8,
    parameter integer NUM_DATA = 16,
)(
    input wire clk,
    input wire reset,
    input wire [DATA_WIDTH*NUM_DATA -1 : 0] input_data_set,
    output wire [DATA_WIDTH-1 : 0] output_data
);
    wire [DATA_WIDTH*NUM_DATA/2 -1 : 0] level1;
    wire [DATA_WIDTH*NUM_DATA/4 -1 : 0] level2;
    wire [DATA_WIDTH*NUM_DATA/8 -1 : 0] level3;
    integer i;
    for(i=0; i<NUM_DATA/2; i=i+1) begin
        assign level1[DATA_WIDTH*(i+1) -1 :DATA_WIDTH*i] = 
            input_data_set[DATA_WIDTH*(2i+1) -1 :DATA_WIDTH*2i]>input_data_set[DATA_WIDTH*(2i+2) -1 :DATA_WIDTH*(2i+1)]?
            input_data_set[DATA_WIDTH*(2i+1) -1 :DATA_WIDTH*2i] : input_data_set[DATA_WIDTH*(2i+2) -1 :DATA_WIDTH*(2i+1)];
    end

    for(i=0; i<NUM_DATA/4; i=i+1) begin
        assign level2[DATA_WIDTH*(i+1) -1 :DATA_WIDTH*i] = 
            level1[DATA_WIDTH*(2i+1) -1 :DATA_WIDTH*2i]>level1[DATA_WIDTH*(2i+2) -1 :DATA_WIDTH*(2i+1)]?
            level1[DATA_WIDTH*(2i+1) -1 :DATA_WIDTH*2i]:level1[DATA_WIDTH*(2i+2) -1 :DATA_WIDTH*(2i+1)];
    end
    for(i=0; i<NUM_DATA/8; i=i+1) begin
        assign level3[DATA_WIDTH*(i+1) -1 :DATA_WIDTH*i] = 
            level2[DATA_WIDTH*(2i+1) -1 :DATA_WIDTH*2i]>level2[DATA_WIDTH*(2i+2) -1 :DATA_WIDTH*(2i+1)]?
            level2[DATA_WIDTH*(2i+1) -1 :DATA_WIDTH*2i]:level2[DATA_WIDTH*(2i+2) -1 :DATA_WIDTH*(2i+1)];
    end

endmodule
