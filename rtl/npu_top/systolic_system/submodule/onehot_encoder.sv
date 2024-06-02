////////////////////////////////////////////////////////////////////////////////
// AS501
// Final Assignment
// One-Hot Encoder
////////////////////////////////////////////////////////////////////////////////
//
//                            Written by Jiwon Choi (jw.choi@kaist.ac.kr)
////////////////////////////////////////////////////////////////////////////////

module onehot_encoder #(
    parameter DWidth = 4
)(
    // INPUT
    input   logic   [DWidth-1:0]    data_i,
    // OUTPUT
    output  logic   [2**DWidth-1:0]    data_o
);
    localparam OWidth = 2**DWidth;

    always_comb begin
        for (int i = 0; i < OWidth; i++) begin
            if (i==data_i) begin
                data_o[i] = 1'b1;
            end
            else begin
                data_o[i] = 1'b0;
            end
        end
    end
////////////////////////////////////////////////////////////////////////////////

endmodule