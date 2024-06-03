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
    logic clk_i;
    logic rst_ni;

    logic cen_i;
    logic wen_i;
    logic [DWidth-1 : 0] addr_i;
    logic [DWidth-1 : 0] wdata_i;

    logic [DWidth-1 : 0] rdata_o;
    logic [DWidth-1 : 0] debug1_o;
    logic [DWidth-1 : 0] debug2_o;
    logic [4-1 : 0] debug3_o;
    logic [8*16-1:0]debug_output;

    localparam ClkPeriod     = 10;
    localparam ClkHalf       = ClkPeriod / 2;
    initial begin
        clk_i = 1'b0;
        forever #ClkHalf clk_i = ~clk_i;
    end

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
        .rdata_o(rdata_o),
        .debug1_o(debug1_o),
        .debug2_o(debug2_o),
        .debug3_o(debug3_o),
        .debug_output(debug_output)
    );

    
    initial begin
        $display("SIMULATION START");
        /* init */
        rst_ni = 0; //0일때 reset
        cen_i = 0;
        wen_i = 0;
        addr_i = 0;
        wdata_i = 0;
        #100
        rst_ni = 1; //0일때 reset
        /* set value into A buf */
        cen_i = 1;
        wen_i = 1;
        addr_i = NPU_IMEM_Start + 64;
        wdata_i = 2;
        #100
        /* set value into W buf */
        addr_i = NPU_WMEM_Start + 4*2;
        wdata_i = 2;
        #100
        /* set value into B buf */
        addr_i = NPU_BMEM_Start + 4*3;
        wdata_i = 0;
        #100
        /* set value into parameter */
        addr_i = NPU_PARA_Start + 'b001000;
        wdata_i = 0;    //a_base_addr
        #100
        addr_i = NPU_PARA_Start + 'b001100;
        wdata_i = 12;    //a_num_rows
        #100
        addr_i = NPU_PARA_Start + 'b010000;
        wdata_i = 0;   //w_base_addr
        #100
        addr_i = NPU_PARA_Start + 'b010100;
        wdata_i = 12;   //w_num_cols
        #100
        addr_i = NPU_PARA_Start + 'b011000;
        wdata_i = 0;   //o_base_addr
        #100
        addr_i = NPU_PARA_Start + 'b011100;
        wdata_i = 0;   //Intra_O_base_addr
        #100
        addr_i = NPU_PARA_Start + 'b100000;
        wdata_i = 0;   //Intra_A_base_addr
        #100
        addr_i = NPU_PARA_Start + 'b100100;
        wdata_i = 15;
        #100
        /* OS_operation start */
        addr_i = NPU_OP_Start;
        wdata_i = 1;
        #100
        addr_i = NPU_PARA_Start + 'b000100;
        #100

        $display("rdata_o = %h", rdata_o);
        while (rdata_o !== 32'h1) begin
            $display("debug3_o = %h", debug3_o);
            #10//@(posedge clk_i);
            addr_i = NPU_PARA_Start + 'b000100;
        end
        #100
       
        /* OS BUF to ACT BUF */
        $display("OS_BUF -> ACT_BUF START");
        $display("rdata_o = %h", rdata_o);
        addr_i = NPU_OP_Start + 4;
        wdata_i = 1;
        #10
        addr_i = NPU_PARA_Start +32'h4;
        while (rdata_o !== 32'h1) begin
            @(posedge clk_i);
        end
        $display("OS_BUF -> ACT_BUF END");
        
        #100
        $display("debug3_o = %h", debug3_o);
        
        
        $display("rdata_o = %h", rdata_o);
        #100

        /* GET MAX VALUE */
        addr_i = NPU_OMEM_Start;
        wdata_i = 1;
        #100
        $display("debug3_o = %h", debug3_o);
        $display("Final output = %h",rdata_o);
        $finish();
        
        
    end
    initial begin
        $fsdbDumpfile("./core.fsdb");
        $fsdbDumpvars("+mda", NPU_inst);
    end
    //always #0.5 clk_i = ~clk_i;
endmodule

// Waveform dump

/* set value into A buf */
/* set value into W buf */
/* set value into B buf */
/* set value into parameter */
/* OS_operation start : tile 1개*/
/* OS BUF to ACT BUF : 16x16만 보낸다. */ 
/* GET MAX VALUE : 한번에 하나 값 */
