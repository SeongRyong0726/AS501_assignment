module npu_decoder #(
    parameter integer DWidth = 8,
    parameter integer ADDR_WIDTH = 32

) (
    input logic clk_i,
    input logic rst_ni,
    input logic cen_i,
    input logic wen_i,
    input logic [ADDR_WIDTH-1:0] addr_i,
    input logic [DWidth-1:0] wdata_i,

    output logic [3:0] op_type
);
    import pkg_memorymap::*;

    always_comb begin
        if ((addr_i >= NPU_IMEM_Start) && (addr_i < NPU_IMEM_End) && (cen_i==1'b1) && (wen_i==1'b1)) begin
            op_type = 4'b1000;
        end else if ((addr_i >= NPU_WMEM_Start) && (addr_i < NPU_WMEM_End)&& (cen_i==1'b1) && (wen_i==1'b1)) begin
            op_type = 4'b1001;
        end else if ((addr_i >= NPU_BMEM_Start) && (addr_i < NPU_BMEM_End)&& (cen_i==1'b1) && (wen_i==1'b1)) begin
            op_type = 4'b1010;
        end else if ((addr_i >= NPU_OMEM_Start) && (addr_i < NPU_OMEM_End)&& (cen_i==1'b1)) begin
            op_type = 4'b1011;
        end else if ((addr_i >= NPU_PARA_Start) && (addr_i < NPU_PARA_Start)&& (cen_i==1'b1)) begin
            op_type = 4'b1100;
        end else begin
            if((addr_i == NPU_OP_Start)&& (cen_i==1'b1) && (wen_i==1'b1)) begin//operation 1 OS
                op_type = 4'b1111;
            end
            else if ((addr_i == NPU_OP_Start + 4) && (cen_i==1'b1) && (wen_i==1'b1)) begin//operation 2 data move
                op_type = 4'b0001;
            end else begin
                op_type = 4'b0000; // 기본값 설정 (필요시)
            end
        end
    end
endmodule