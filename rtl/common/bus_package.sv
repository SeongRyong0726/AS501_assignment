////////////////////////////////////////////////////////////////////////////////
// AS501
// Lab 7
// Bus Package
////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024 by Smart Energy-Efficient Design Lab. (SEED), KAIST
// All rights reserved.
//
//                            Written by Hyungjoon Bae (jo_on@kaist.ac.kr)
//                            Supervised by Wanyeong Jung (wanyeong@kaist.ac.kr)
////////////////////////////////////////////////////////////////////////////////

package pkg_trans;
    localparam      IDLE   = 1'b0; // No data transfer is required
    localparam      NONSEQ = 1'b1; // Single transfer
endpackage

package pkg_resp;
    localparam      PENDING = 2'b00;
    localparam      SUCCESS = 2'b01;
    localparam      ERROR_1 = 2'b10;
    localparam      ERROR_2 = 2'b11;
endpackage