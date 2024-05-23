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

#define INPUT_ADDR  0x00004000
#define FC1_W_ADDR  (INPUT_ADDR  + INPUT_SIZE   * NUM_OF_TEST  * sizeof(int))
#define FC1_B_ADDR  (FC1_W_ADDR  + INPUT_SIZE   * HIDDEN1_SIZE * sizeof(int))
#define FC1_O_ADDR  (FC1_B_ADDR  + HIDDEN1_SIZE * sizeof(int))
#define FC2_W_ADDR  (FC1_O_ADDR  + HIDDEN1_SIZE * sizeof(int))
#define FC2_B_ADDR  (FC2_W_ADDR  + HIDDEN1_SIZE * HIDDEN2_SIZE * sizeof(int))
#define FC2_O_ADDR  (FC2_B_ADDR  + HIDDEN2_SIZE * sizeof(int))
#define FC3_W_ADDR  (FC2_O_ADDR  + HIDDEN2_SIZE * sizeof(int))
#define FC3_B_ADDR  (FC3_W_ADDR  + HIDDEN2_SIZE * OUTPUT_SIZE  * sizeof(int))
#define OUTPUT_ADDR (FC3_B_ADDR  + OUTPUT_SIZE  * sizeof(int))
#define LABEL_ADDR  (OUTPUT_ADDR + OUTPUT_SIZE  * sizeof(int))