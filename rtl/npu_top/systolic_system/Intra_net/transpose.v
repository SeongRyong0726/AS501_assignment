`timescale 100ns/1ns
module transpose #(
    parameter integer ROW_DIM = 16,
    parameter integer COL_DIM = 16,
    parameter integer DATA_WIDTH = 8
)(
    input wire clk,
    input wire reset,
    input wire T_start,
    input wire [$clog2(COL_DIM) : 0]      A,
    input wire [$clog2(COL_DIM) : 0]      B,

    input wire [ROW_DIM*DATA_WIDTH -1 : 0] data_in,
    output wire [COL_DIM*DATA_WIDTH -1 : 0] data_out,
    output wire T_end
);

reg [$clog2(COL_DIM)+1 : 0] count;
always @(posedge clk)
begin
    if(T_start)
        count <= count +1;
    else
        count <= 0;    
end

wire state; //[in, out]
assign state = (count < A+1)? 1 : 0;
assign T_end = (count > A + ROW_DIM -1)? 1 : 0;

genvar r, c;
generate
    for (r=0; r<ROW_DIM; r=r+1)
    begin: ROW
        for(c=0; c<COL_DIM; c=c+1)
        begin: COL
            wire [DATA_WIDTH -1 :0] H_in;
            wire [DATA_WIDTH -1 :0] V_in;
            wire [DATA_WIDTH -1 :0] H_out;
            wire [DATA_WIDTH -1 :0] V_out;

            wire [DATA_WIDTH -1 :0] reg_in;
            wire [DATA_WIDTH -1 :0] reg_out;

            assign reg_in = (state)? H_in : V_in;
            assign H_out = (state)? reg_out : 8'bz;
            assign V_out = (state)? 8'bz : reg_out;

            reg [DATA_WIDTH-1:0] st;
            always @(posedge clk)
            begin
                if(T_start)
                    st <= reg_in;
                else
                    st <= 0;
            end
            assign reg_out = st;

            if(r==0 && c==0)
            begin
                assign ROW[r].COL[c].V_in = ROW[r+1].COL[c].V_out;
                assign ROW[r].COL[c].H_in = data_in[DATA_WIDTH*(r+1)-1 : DATA_WIDTH*r];
                assign data_out[DATA_WIDTH*(c+1)-1 : DATA_WIDTH*c] = ROW[r].COL[c].V_out;
                assign ROW[r].COL[c+1].H_in = ROW[r].COL[c].H_out;
            end
            else if(r==0 && c==COL_DIM-1) 
            begin
                assign ROW[r].COL[c].V_in = ROW[r+1].COL[c].V_out;
                assign ROW[r].COL[c].H_in = ROW[r].COL[c- 1].H_out;
                assign data_out[DATA_WIDTH*(c+1)-1 : DATA_WIDTH*c] = ROW[r].COL[c].V_out;
                //assign ROW[r].COL[c+1].H_in = ROW[r].COL[c].H_out;
            end
            else if(r==ROW_DIM-1 && c==0)
            begin
                assign ROW[r].COL[c].V_in = 8'b0; //ROW[r+1].COL[c].V_out;
                assign ROW[r].COL[c].H_in = data_in[DATA_WIDTH*(r+1)-1 : DATA_WIDTH*r];
                assign ROW[r-1].COL[c].V_in = ROW[r].COL[c].V_out;
                assign ROW[r].COL[c+1].H_in = ROW[r].COL[c].H_out;
            end
            else if(r==ROW_DIM-1 && c==COL_DIM-1)
            begin
                assign ROW[r].COL[c].V_in = 8'b0; //ROW[r+1].COL[c].V_out;
                assign ROW[r].COL[c].H_in = ROW[r].COL[c- 1].H_out;
                assign ROW[r-1].COL[c].V_in = ROW[r].COL[c].V_out;
                //assign ROW[r].COL[c+1].H_in = ROW[r].COL[c].H_out;
            end
            else if(c==0)
            begin
                assign ROW[r].COL[c].V_in = ROW[r+1].COL[c].V_out;
                assign ROW[r].COL[c].H_in = data_in[DATA_WIDTH*(r+1)-1 : DATA_WIDTH*r];
                assign ROW[r-1].COL[c].V_in = ROW[r].COL[c].V_out;
                assign ROW[r].COL[c+1].H_in = ROW[r].COL[c].H_out;
            end
            else if (r==0)
            begin
                assign ROW[r].COL[c].V_in = ROW[r+1].COL[c].V_out;
                assign ROW[r].COL[c].H_in = ROW[r].COL[c- 1].H_out;
                assign data_out[DATA_WIDTH*(c+1)-1 : DATA_WIDTH*c] = (c < A)? ROW[r].COL[c].V_out : {DATA_WIDTH{1'b0}};
                assign ROW[r].COL[c+1].H_in = ROW[r].COL[c].H_out;
            end
            else if (c==COL_DIM-1)
            begin
                assign ROW[r].COL[c].V_in = ROW[r+1].COL[c].V_out;
                assign ROW[r].COL[c].H_in = ROW[r].COL[c- 1].H_out;
                assign ROW[r-1].COL[c].V_in = ROW[r].COL[c].V_out;
                //assign ROW[r].COL[c+1].H_in = ROW[r].COL[c].H_out;
            end
            else if (r==ROW_DIM-1)
            begin
                assign ROW[r].COL[c].V_in = 8'b0;//ROW[r+1].COL[c].V_out;
                assign ROW[r].COL[c].H_in = ROW[r].COL[c- 1].H_out;
                assign ROW[r-1].COL[c].V_in = ROW[r].COL[c].V_out;
                assign ROW[r].COL[c+1].H_in = ROW[r].COL[c].H_out;
            end
            else 
            begin
                assign ROW[r].COL[c].V_in = ROW[r+1].COL[c].V_out;
                assign ROW[r].COL[c].H_in = ROW[r].COL[c- 1].H_out;
                assign ROW[r-1].COL[c].V_in = ROW[r].COL[c].V_out;
                assign ROW[r].COL[c+1].H_in = ROW[r].COL[c].H_out;
            end
            
        end
    end
endgenerate

endmodule