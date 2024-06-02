module npu_decoder #(
    parameter integer DWidth = 8,
    parameter integer ADDR_WIDTH = 32

) (
    input wire clk,
    input wire rst_ni,
    input wire cen_i,
    input wire wen_i,
    input wire [ADDR_WIDTH-1:0] addr_i,
    input wire [DWidth-1:0] wdata_i,

    output wire [3:0] op_type,
);
    import pkg_memorymap::*;

    always_comb begin
        if (addr_i >= NPU_IMEM_Start && addr_i < NPU_IMEM_End) begin
            op_type = 'b1000;
        end else if (addr_i >= NPU_WMEM_Start && addr_i < NPU_WMEM_End) begin
            op_type = 'b1001;
        end else if (addr_i >= NPU_BMEM_Start && addr_i < NPU_BMEM_End) begin
            op_type = 'b1010;
        end else if (addr_i >= NPU_OMEM_Start && addr_i < NPU_OMEM_End) begin
            op_type = 'b1011;
        end else if (addr_i >= NPU_PARA_Start && addr_i < NPU_PARA_Start)
            op_type = 'b1100;
        end else begin
            if(addr_i == NPU_OP_Start) begin//operation 1 OS
                op_type = 'b0000;
            end
            else if (addr_i == NPU_OP_Start + 4) begin//operation 2 data move
                op_type = 'b0001;
            end 
        end
    end
endmodule