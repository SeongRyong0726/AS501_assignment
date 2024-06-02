module tb_npu #(
    parameter DWidth = 32,
    parameter ARRAY_DIM=16,
    parameter ACT_WIDTH = 8,
    parameter WGT_WIDTH = 8,
    parameter PE_OUT_WIDTH = 32,
    parameter RAM_SIZE = 1<<10,
    parameter ADDR_WIDTH = 32 //??
);
    import pkg_memorymap::*;
    reg clk_i;
    reg rst_ni;

    reg cen_i;
    reg wen_i;
    reg [DWidth-1 : 0] addr_i;
    reg [DWidth-1 : 0] wdata_i;

    wire [DWidth-1 : 0] rdata_o;

    NPU #(
        .DWidth(DWidth),
        .ARRAY_N(ARRAY_DIM),
        .ARRAY_M(ARRAY_DIM),
        .ACT_WIDTH(ACT_WIDTH),
        .WGT_WIDTH(WGT_WIDTH),
        .PE_OUT_WIDTH(PE_OUT_WIDTH),
        .RAM_SIZE(RAM_SIZE),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) NPU_inst (
        .clk_i(clk_i),
        .rst_ni(rst_ni),
        .cen_i(cen_i),
        .wen_i(wen_i),
        .addr_i(addr_i),
        .wdata_i(wdata_i),
        .rdata_o(rdata_o)
    );

    
    initial begin
        /* init */
        clk_i = 1;
        rst_ni = 0; //0일때 reset
        cen_i = 0;
        wen_i = 0;
        addr_i = 0;
        wdata_i = 0;
        #1
        rst_ni = 1; //0일때 reset
        /* set value into A buf */
        cen_i = 1;
        wen_i = 1;
        addr_i = NPU_IMEM_Start + 64;
        wdata_i = 10;
        #1
        /* set value into W buf */
        addr_i = NPU_WMEM_Start + 4*2;
        wdata_i = 10;
        #1
        /* set value into B buf */
        addr_i = NPU_BMEM_Start + 4*3;
        wdata_i = 10;
        #1
        /* set value into parameter */
        addr_i = NPU_PARA_Start + 'b001000;
        wdata_i = 0;    //a_base_addr
        #1
        addr_i = NPU_PARA_Start + 'b001100;
        wdata_i = 15;    //a_num_rows
        #1
        addr_i = NPU_PARA_Start + 'b010000;
        wdata_i = 0;   //w_base_addr
        #1
        addr_i = NPU_PARA_Start + 'b010100;
        wdata_i = 15;   //w_num_cols
        #1
        addr_i = NPU_PARA_Start + 'b011000;
        wdata_i = 0;   //o_base_addr
        #1
        addr_i = NPU_PARA_Start + 'b011100;
        wdata_i = 0;   //Intra_O_base_addr
        #1
        addr_i = NPU_PARA_Start + 'b100000;
        wdata_i = 0;   //Intra_A_base_addr
        #1
        /* OS_operation start */
        addr_i = NPU_OP_Start;
        wdata_i = 1;
        #1
        addr_i = NPU_PARA_Start + 'b000100;
        while (rdata_o == 32'h1) begin
            @(posedge clk_i);
        end
        #1
        addr_i = NPU_PARA_Start + 'b000100;
        wdat_i = 0;
        #1

        /* OS BUF to ACT BUF */
        addr_i = NPU_OP_Start + 4;
        wdata_i = 1;
        #1
        while (rdata_o == 32'h1) begin
            @(posedge clk_i);
        end
        addr_i = NPU_PARA_Start + 'b000100;
        wdat_i = 0;
        #1
        /* GET MAX VALUE */
        addr_i = NPU_OMEM_Start;
        wdata_i = 1;
        $$display("Final output = %h",rdata_o);

        
        
    end
    always #0.5 clk = !clk;
endmodule

/* set value into A buf */
/* set value into W buf */
/* set value into B buf */
/* set value into parameter */
/* OS_operation start : tile 1개*/
/* OS BUF to ACT BUF : 16x16만 보낸다. */ 
/* GET MAX VALUE : 한번에 하나 값 */
