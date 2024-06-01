////////////////////////////////////////////////////////////////////////////////
// AS501
// Final Assignment
// Memory Map
////////////////////////////////////////////////////////////////////////////////
// Copyright Jiwon Choi
// All rights reserved.
//
//                            Written by Jiwon Choi(jw.choi@kaist.ac.kr)
////////////////////////////////////////////////////////////////////////////////

package pkg_memorymap;
    //Slave0 (Ext. Mem)
    localparam      Slave0_Start    = 32'h00000000;
    localparam      Slave0_Depth    = 32'h40000000;
    //localparam      Slave0_Depth    = 32'h01e57478;
    localparam      Slave0_End      = Slave0_Start + Slave0_Depth;

    //Slave1 (NPU Core)
    localparam      Slave1_Start    = 32'h80000000;
    localparam      Slave1_Depth    = 32'h10000000;
    localparam      Slave1_End      = Slave1_Start + Slave1_Depth;

    //Slave0 (Ext. Mem) Detail
    localparam      InstMem_Start   = 32'h00000000;
    localparam      InstMem_Depth   = 32'h00004000;
    localparam      InstMem_End     = InstMem_Start + InstMem_Depth;
    localparam      DataMem_Start   = InstMem_End;
    localparam      DataMem_Depth   = 32'h01e53478;
    localparam      DataMem_End     = DataMem_Start + DataMem_Depth;

    localparam      EXT_IMEM_Start  = DataMem_Start; 
    localparam      EXT_IMEM_LB_Start = 32'h01000000;
    //Slave1 (NPU Core) Detail
    localparam      NPU_IMEM_Start  = 32'h02000000;
    localparam      NPU_IMEM_Depth  = 32'h00003100;
    localparam      NPU_IMEM_End    = NPU_IMEM_Start + NPU_IMEM_Depth;

    localparam      NPU_WMEM_Start  = NPU_IMEM_End;
    localparam      NPU_WMEM_Depth  = 32'h00003100;
    localparam      NPU_WMEM_End    = NPU_WMEM_Start + NPU_WMEM_Depth;

    localparam      NPU_BMEM_Start  = NPU_WMEM_End;
    localparam      NPU_BMEM_Depth  = 32'h00000080;
    localparam      NPU_BMEM_End    = NPU_BMEM_Start + NPU_BMEM_Depth;

    localparam      NPU_OMEM_Start  = NPU_BMEM_End;
    localparam      NPU_OMEM_Depth  = 32'h00002000;
    localparam      NPU_OMEM_End    = NPU_OMEM_Start + NPU_OMEM_Depth;
endpackage