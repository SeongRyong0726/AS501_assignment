////////////////////////////////////////////////////////////////////////////////
// AS501
// Final Project
// Header of multilayer perceptron
////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024 by Smart Energy-Efficient Design Lab. (SEED), KAIST
// All rights reserved.
//
//                            Written by Hyungjoon Bae (jo_on@kaist.ac.kr)
//                                       Youngin Park (young_in@kaist.ac.kr)
//                            Supervised by Wanyeong Jung (wanyeong@kaist.ac.kr)
////////////////////////////////////////////////////////////////////////////////

void fully_connected(int[], int[], int [], int [], int, int);
int max(int []);

// Define the dimensions of the model's layers
#define INPUT_SIZE   784
#define HIDDEN1_SIZE 128
#define HIDDEN2_SIZE 64
#define OUTPUT_SIZE  10
#define NUM_OF_TEST  10
#define I_EMA_SIZE 7840
#define W_FC1_TILE_EMA_SIZE 12544
#define W_FC2_TILE_EMA_SIZE 2048
#define W_FC3_TILE_EMA_SIZE 640
#define FC1_TILE_ITER (HIDDEN1_SIZE/TILE_SIZE)
#define FC2_TILE_ITER (HIDDEN2_SIZE/TILE_SIZE)
#define FC3_TILE_ITER 1

// Define the HW Characteristics
#define BATCH_SIZE   16
#define TILE_SIZE    16
#define NUM_OF_BATCH 1//(NUM_OF_TEST+BATCH_SIZE-1)/(BATCH_SIZE) 

#define INPUT_ADDR  0x00004000
#define FC1_W_ADDR  (INPUT_ADDR  + INPUT_SIZE   * NUM_OF_TEST  * sizeof(int)) // ba80
#define FC1_B_ADDR  (FC1_W_ADDR  + INPUT_SIZE   * HIDDEN1_SIZE * sizeof(int)) // 6_da80
#define FC1_O_ADDR  (FC1_B_ADDR  + HIDDEN1_SIZE * sizeof(int)) // 6_dc80
#define FC2_W_ADDR  (FC1_O_ADDR  + HIDDEN1_SIZE * sizeof(int)) // 6_de80
#define FC2_B_ADDR  (FC2_W_ADDR  + HIDDEN1_SIZE * HIDDEN2_SIZE * sizeof(int)) // 7_5e80
#define FC2_O_ADDR  (FC2_B_ADDR  + HIDDEN2_SIZE * sizeof(int)) // 7_5f80
#define FC3_W_ADDR  (FC2_O_ADDR  + HIDDEN2_SIZE * sizeof(int)) // 7_6080
#define FC3_B_ADDR  (FC3_W_ADDR  + HIDDEN2_SIZE * OUTPUT_SIZE  * sizeof(int)) // 7_6a80
#define OUTPUT_ADDR (FC3_B_ADDR  + OUTPUT_SIZE  * sizeof(int)) // 7_6aa8
#define LABEL_ADDR  (OUTPUT_ADDR + OUTPUT_SIZE  * sizeof(int)) // 7_6ad0
#define INPUT_LOOPBACK_ADDR  0x01000000

// Define NPU-related Variable & Address
#define IMEM_DATA_NUM 12544
#define WMEM_DATA_NUM 12544
#define BMEM_DATA_NUM 128
#define OMEM_DATA_NUM 2048

#define IMEM_SIZE 0x0000c400 //'h310*10*4
#define WMEM_SIZE 0x0000c400 //'h310*10*4
#define BMEM_SIZE 0x00000200 //'h80 * 4
#define OMEM_SIZE 0x00008000

#define IMEM_ADDR 0x10000000
#define WMEM_ADDR 0x1000c400
#define BMEM_ADDR 0x10018800
#define OMEM_ADDR 0x10018a00

#define IMEM_ADDR_END (IMEM_ADDR_BASE+IMEM_SIZE)
#define WMEM_ADDR_END (WMEM_ADDR_BASE+WMEM_SIZE)
#define BMEM_ADDR_END (BMEM_ADDR_BASE+BMEM_SIZE)
#define OMEM_ADDR_END (OMEM_ADDR_BASE+OMEM_SIZE)

#define TILE_START_ADDR 0x10020c00
#define TILE_END_ADDR 0x10020a04
#define OMEM2IMEM_START_ADDR 0x10020c04
#define OMEM2IMEM_END_ADDR 0x10020a04
#define NPU_CTRL_ADDR 0x10020a00
#define NPU_CTRL_SIZE 0x200


// JW ADDED (24.05.28)
//********* Memory Map (NUM_OF_TEST = 10000 case)*********/
// 0x0000_0000 ~ 0x0000_4000 Instruction    (Size: 0x0000_4000)
// 0x0000_4000 ~ 0x01de_c400 Input          (Size: 0x01de_8400)
// 0x01de_c400 ~ 0x01e4_e400 FC1 Weight     (Size: 0x0006_2000)
// 0x01e4_e400 ~ 0x01e4_e600 FC1 Bias       (Size: 0x0000_0200)
// 0x01e4_e600 ~ 0x01e4_e800 FC1 Output     (Size: 0x0000_0200)
// 0x01e4_e800 ~ 0x01e5_6800 FC2 Weight     (Size: 0x0000_8000) 
// 0x01e5_6800 ~ 0x01e5_6900 FC2 Bias       (Size: 0x0000_0100)
// 0x01e5_6900 ~ 0x01e5_6a00 FC2 Output     (Size: 0x0000_0100)
// 0x01e5_6a00 ~ 0x01e5_7400 FC3 Weight     (Size: 0x0000_0a00) 
// 0x01e5_7400 ~ 0x01e5_7428 FC3 Bias       (Size: 0x0000_0028)
// 0x01e5_7428 ~ 0x01e5_7450 Output         (Size: 0x0000_0028)
// 0x01e5_7450 ~ 0x01e5_7478 Label          (Size: 0x0000_0028)

// 0x0200_0000 ~ 0x0200_3100 IMEM           (Size: 0x0000_3100, 16x784x1B = 12544B)
// 0x0200_4000 ~ 0x0200_7100 WMEM           (Size: 0x0000_3100, 16x784x1B = 12544B)
// 0x0200_8000 ~ 0x0200_8080 BMEM           (Size: 0x0000_0080, 128x1B    = 128B  )
// 0x0200_9000 ~ 0x0200_b000 OMEM           (Size: 0x0000_2000, 16x128x4B = 8192B )