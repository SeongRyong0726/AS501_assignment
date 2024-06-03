
module max_16 #(
    parameter integer DATA_WIDTH = 8,
    parameter integer NUM_DATA = 16
)(
    input wire clk,
    input wire reset,
    input wire [DATA_WIDTH*NUM_DATA -1 : 0] input_data_set,
    output wire [DATA_WIDTH-1 : 0] output_data,
    output wire [$clog2(NUM_DATA)-1 : 0] max_idx_value
);
    wire [DATA_WIDTH*NUM_DATA/2 -1 : 0] level1;
    wire [DATA_WIDTH*NUM_DATA/4 -1 : 0] level2;
    wire [DATA_WIDTH*NUM_DATA/8 -1 : 0] level3;

    wire [$clog2(NUM_DATA) * NUM_DATA/2 -1 : 0] idx_level1;
    wire [$clog2(NUM_DATA) * NUM_DATA/4 -1 : 0] idx_level2;
    wire [$clog2(NUM_DATA) * NUM_DATA/8 -1 : 0] idx_level3;

    
    for(genvar i=0; i<NUM_DATA/2; i=i+1) begin
        assign level1[DATA_WIDTH*(i+1) -1 :DATA_WIDTH*i] = 
            input_data_set[DATA_WIDTH*(2*i+1) -1 :DATA_WIDTH*2*i]>input_data_set[DATA_WIDTH*(2*i+2) -1 :DATA_WIDTH*(2*i+1)]?
            input_data_set[DATA_WIDTH*(2*i+1) -1 :DATA_WIDTH*2*i] : input_data_set[DATA_WIDTH*(2*i+2) -1 :DATA_WIDTH*(2*i+1)];
        assign idx_level1[$clog2(NUM_DATA) * (i+1)-1 :$clog2(NUM_DATA) * i] = 
            input_data_set[DATA_WIDTH*(2*i+1) -1 :DATA_WIDTH*2*i]>input_data_set[DATA_WIDTH*(2*i+2) -1 :DATA_WIDTH*(2*i+1)]?
            2*i : 2*i+1 ;
    end
    for(genvar i=0; i<NUM_DATA/4; i=i+1) begin
        assign level2[DATA_WIDTH*(i+1) -1 :DATA_WIDTH*i] = 
            level1[DATA_WIDTH*(2*i+1) -1 :DATA_WIDTH*2*i]>level1[DATA_WIDTH*(2*i+2) -1 :DATA_WIDTH*(2*i+1)]?
            level1[DATA_WIDTH*(2*i+1) -1 :DATA_WIDTH*2*i]:level1[DATA_WIDTH*(2*i+2) -1 :DATA_WIDTH*(2*i+1)];
        assign idx_level2[$clog2(NUM_DATA) * (i+1)-1 :$clog2(NUM_DATA) * i] =
            level1[DATA_WIDTH*(2*i+1) -1 :DATA_WIDTH*2*i]>level1[DATA_WIDTH*(2*i+2) -1 :DATA_WIDTH*(2*i+1)]?
            idx_level1[$clog2(NUM_DATA) * (2*i+1)-1:$clog2(NUM_DATA) * 2*i] : idx_level1[$clog2(NUM_DATA) * (2*i+2)-1:$clog2(NUM_DATA) * (2*i+1)];
    end
    for(genvar i=0; i<NUM_DATA/8; i=i+1) begin
        assign level3[DATA_WIDTH*(i+1) -1 :DATA_WIDTH*i] = 
            level2[DATA_WIDTH*(2*i+1) -1 :DATA_WIDTH*2*i]>level2[DATA_WIDTH*(2*i+2) -1 :DATA_WIDTH*(2*i+1)]?
            level2[DATA_WIDTH*(2*i+1) -1 :DATA_WIDTH*2*i]:level2[DATA_WIDTH*(2*i+2) -1 :DATA_WIDTH*(2*i+1)];
        assign idx_level3[$clog2(NUM_DATA) * (i+1)-1 :$clog2(NUM_DATA) * i] =
            level2[DATA_WIDTH*(2*i+1) -1 :DATA_WIDTH*2*i]>level1[DATA_WIDTH*(2*i+2) -1 :DATA_WIDTH*(2*i+1)]?
            idx_level2[$clog2(NUM_DATA) * (2*i+1)-1:$clog2(NUM_DATA) * 2*i] : idx_level2[$clog2(NUM_DATA) * (2*i+2)-1:$clog2(NUM_DATA) * (2*i+1)];
    end

    assign output_data = level3[DATA_WIDTH-1:0] > level3[DATA_WIDTH*2-1:DATA_WIDTH]? level3[DATA_WIDTH-1:0] : level3[DATA_WIDTH*2-1:DATA_WIDTH];
    assign max_idx_value = idx_level3[$clog2(NUM_DATA)-1:0] > idx_level3[$clog2(NUM_DATA)*2-1:$clog2(NUM_DATA)]?
            idx_level3[$clog2(NUM_DATA)-1:0] : idx_level3[$clog2(NUM_DATA)*2-1:$clog2(NUM_DATA)];
endmodule
