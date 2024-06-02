////////////////////////////////////////////////////////////////////////////////
// AS501
// Final Project
// Code of multilayer perceptron
////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024 by Smart Energy-Efficient Design Lab. (SEED), KAIST
// All rights reserved.
//
//                            Written by Hyungjoon Bae (jo_on@kaist.ac.kr)
//                                       Youngin Park (young_in@kaist.ac.kr)
//                            Supervised by Wanyeong Jung (wanyeong@kaist.ac.kr)
////////////////////////////////////////////////////////////////////////////////

#include "mlp_modified.h"
#include <stdint.h>
#include <inttypes.h>
#include <math.h>

int main(void){
    volatile int* input       = (int*)(INPUT_ADDR);
    int* fc1_weight  = (int*)(FC1_W_ADDR);
    int* fc1_bias    = (int*)(FC1_B_ADDR);
    int* fc1_output  = (int*)(FC1_O_ADDR);
    int* fc2_weight  = (int*)(FC2_W_ADDR);
    int* fc2_bias    = (int*)(FC2_B_ADDR);
    int* fc2_output  = (int*)(FC2_O_ADDR);
    int* fc3_weight  = (int*)(FC3_W_ADDR);
    int* fc3_bias    = (int*)(FC3_B_ADDR);
    int* output      = (int*)(OUTPUT_ADDR);
    int* label       = (int*)(LABEL_ADDR);
    
    // JW ADD (24.05.29)
    volatile int* input_loopback = (int*)(INPUT_LOOPBACK_ADDR);

    volatile int* imem    = (int*)(IMEM_ADDR);
    volatile int* wmem    = (int*)(WMEM_ADDR);
    volatile int* bmem    = (int*)(BMEM_ADDR);
    volatile int* omem    = (int*)(OMEM_ADDR);

    volatile int* tile_start        = (int*)(TILE_START_ADDR);
    volatile int* tile_end          = (int*)(TILE_END_ADDR);   
    volatile int* omem2imem_start   = (int*)(OMEM2IMEM_START_ADDR); 
    volatile int* omem2imem_end     = (int*)(OMEM2IMEM_END_ADDR); 
    volatile int* layer_start       = (int*)(TILE_START_ADDR);
    volatile int* layer_end         = (int*)(TILE_END_ADDR);

    volatile int* npu_ctrl = (int*)(NPU_CTRL_ADDR);
    
    int NPUCtrlSize = 16;

    int InputSize     = 784;
    int Hidden1Size   = 128;
    int Hidden2Size   = 64;
    int OutputSize    = 10;

    int IMEM_DATA_SIZE = 784*NUM_OF_TEST;
////////////////////////////////////////////////////////////////////////////////
//  IMEM Loopback Test
    /*
    for (int i = 0; i < IMEM_DATA_SIZE; i=i+1){
        imem[i] = input[i];
    }
    for (int i = 0; i < IMEM_DATA_SIZE; i=i+1){
        input_loopback[i] = imem[i];
    }
    return 0;
    */

    /*
    while (TILE_END_CSR == 0){
        ;
    }
    TILE_START_CSR = 1
    */
/*    
//  WMEM Loopback Test
    for (int i = 0; i < WMEM_DATA_NUM; ++i){
        wmem[i] = fc1_weight[i]
    }
//  BMEM Loopback Test
    for (int i = 0; i < BMEM_DATA_NUM; ++i){
        bmem[i] = fc1_bias[i]
    }  
//  OMEM Loopback Test
    for (int i = 0; i < OMEM_DATA_NUM; ++i){
        omem[i] = fc1_output[i]
    }
*/
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////


//  Inference
    register unsigned int image_idx asm("x26");
    register unsigned int correct_count asm("x27") = 0;
    unsigned int start_clow, start_chigh;
    unsigned int start_ilow, start_ihigh;
    unsigned int end_clow, end_chigh;
    unsigned int end_ilow, end_ihigh;

    asm volatile("csrrs %0, mcycle, x0" : "=r" (start_clow));
    asm volatile("csrrs %0, mcycleh, x0" : "=r" (start_chigh));
    asm volatile("csrrs %0, minstret, x0" : "=r" (start_ilow));
    asm volatile("csrrs %0, minstreth, x0" : "=r" (start_ihigh));

    unsigned int batch_idx = 0;
    unsigned int image_idx_offset = 0;
    unsigned int batch_remainder = 0;
    for (batch_idx = 0; batch_idx < NUM_OF_BATCH; ++batch_idx){
        
        batch_remainder = (NUM_OF_TEST)%1;

        batch_inference(&input[INPUT_SIZE*BATCH_SIZE*batch_idx], 
                        fc1_weight, fc2_weight, fc3_weight,
                        fc1_bias, fc2_bias, fc3_bias, 
                        output[OUTPUT_SIZE*BATCH_SIZE*batch_idx],
                        imem, wmem, bmem, omem, 
                        tile_start, tile_end, omem2imem_start, omem2imem_end, 
                        npu_ctrl, batch_remainder);

        for (image_idx_offset = 0; image_idx_offset < BATCH_SIZE; ++image_idx_offset){
            if (max(output) == label[image_idx]){
                ++correct_count;
            }
            ++image_idx;
        }
    }

    asm volatile("csrrs %0, mcycle, x0" : "=r" (end_clow));
    asm volatile("csrrs %0, mcycleh, x0" : "=r" (end_chigh));
    asm volatile("csrrs %0, minstret, x0" : "=r" (end_ilow));
    asm volatile("csrrs %0, minstreth, x0" : "=r" (end_ihigh));
//
////////////////////////////////////////////////////////////////////////////////

    // Total clock
    register unsigned int cycle_low asm("x28") = end_clow - start_clow;
    if (cycle_low > end_clow){
        --end_chigh;
    }
    register unsigned int cycle_high asm("x29") = end_chigh - start_chigh;

    // Total instruction-retired count
    register unsigned int inst_low asm("x30") = end_ilow - start_ilow;
    if (inst_low > end_ilow){
        --end_ihigh;
    }
    register unsigned int inst_high asm("x31") = end_ihigh - start_ihigh;

    // Testbench uses this register to check the end of the simulation
    register unsigned int finish asm("x25") = 99999;

    return 0;
};

void batch_inference(   int input[], int fc1_weight[], int fc2_weight[], int fc3_weight[],
                        int fc1_bias[], int fc2_bias[], int fc3_bias, int output[], 
                        int imem[], int wmem[], int bmem[], int omem[],
                        int tile_start[], int tile_end[], int omem2imem_start[], int omem2imem_end[],
                        int npu_ctrl[], int batch_remainder){

    imem_transfer(input, imem, INPUT_SIZE, BATCH_SIZE);
    layer1_inference(fc1_weight, fc1_bias, wmem, bmem, tile_start, tile_end, omem2imem_start, omem2imem_end, npu_ctrl, batch_remainder);
    layer2_inference(fc2_weight, fc2_bias, wmem, bmem, tile_start, tile_end, omem2imem_start, omem2imem_end, npu_ctrl, batch_remainder);
    layer3_inference(fc3_weight, fc3_bias, wmem, bmem, tile_start, tile_end, npu_ctrl, batch_remainder);
    omem_transfer(omem, output, OUTPUT_SIZE*BATCH_SIZE);
}

void layer1_inference(  int fc1_weight[], int fc1_bias[], int wmem[], int bmem[], 
                        int tile_start[], int tile_end[], int omem2imem_start[], int omem2imem_end[],
                        int npu_ctrl[], int batch_remainder){

    // Contrl Signal Transfer
    npu_ctrl[0] = 0;
    npu_ctrl[1] = 0; 
    npu_ctrl[2] = 0; 
    npu_ctrl[3] = 0; 
    npu_ctrl[4] = 0; 
    npu_ctrl[5] = 0; 
    npu_ctrl[6] = 0; 
    npu_ctrl[7] = 0; 
    npu_ctrl[8] = 0; 
    npu_ctrl[9] = 0; 
    npu_ctrl[10] = 0;

    for (int i = 0; i<HIDDEN1_SIZE/TILE_SIZE; i=i+1){
        wmem_transfer(&fc1_weight[INPUT_SIZE*TILE_SIZE*i], wmem, INPUT_SIZE, TILE_SIZE);
        bias_transfer(&fc1_bias[TILE_SIZE*i], bmem, TILE_SIZE);
        tile_start[0] = 0x00000001;
        while(tile_end[0] == 0x00000001){
            ;
        }
    }
    omem2imem_start[0] = 0x00000001; // OMEM --> IMEM Transfer
    while(omem2imem_end[0] == 0x00000001){
        ;
    }
}
void layer2_inference(  int fc2_weight[], int fc2_bias[], int wmem[], int bmem[], 
                        int tile_start[], int tile_end[], int omem2imem_start[], int omem2imem_end[],
                        int npu_ctrl[], int batch_remainder){

    // Contrl Signal Transfer
    npu_ctrl[0] = 0;
    npu_ctrl[1] = 0; 
    npu_ctrl[2] = 0; 
    npu_ctrl[3] = 0; 
    npu_ctrl[4] = 0; 
    npu_ctrl[5] = 0; 
    npu_ctrl[6] = 0; 
    npu_ctrl[7] = 0; 
    npu_ctrl[8] = 0; 
    npu_ctrl[9] = 0; 
    npu_ctrl[10] = 0;

    // Tile-wise Operation
    for (int i = 0; i<HIDDEN2_SIZE/16; i=i+1){
        wmem_transfer(&fc2_weight[HIDDEN1_SIZE*TILE_SIZE*i], wmem, HIDDEN1_SIZE, TILE_SIZE);
        bias_transfer(&fc2_bias[TILE_SIZE*i], bmem, TILE_SIZE);
        tile_start[0] = 0x00000001;
        while(tile_end[0] == 0x00000001){
            ;
        }
    }
    omem2imem_start[0] = 0x00000001; // OMEM --> IMEM Transfer
    while(omem2imem_end[0] == 0x00000001){
        ;
    }
}
void layer3_inference(  int fc3_weight[], int fc3_bias[], int wmem[], int bmem[], 
                        int tile_start[], int tile_end[], int npu_ctrl[], int batch_remainder){

    // Contrl Signal Transfer
    npu_ctrl[0] = 0;
    npu_ctrl[1] = 0; 
    npu_ctrl[2] = 0; 
    npu_ctrl[3] = 0; 
    npu_ctrl[4] = 0; 
    npu_ctrl[5] = 0; 
    npu_ctrl[6] = 0; 
    npu_ctrl[7] = 0; 
    npu_ctrl[8] = 0; 
    npu_ctrl[9] = 0; 
    npu_ctrl[10] = 0;
    
    // Tile-wise Operation
    for (int i = 0; i<OUTPUT_SIZE/16; i=i+1){
        wmem_transfer(&fc3_weight[HIDDEN2_SIZE*TILE_SIZE*i], wmem, HIDDEN2_SIZE, TILE_SIZE);
        bias_transfer(&fc3_bias[TILE_SIZE*i], bmem, TILE_SIZE);
        tile_start[0] = 0x00000001;
        while(tile_end[0] == 0x00000001){
            ;
        }
    }
}

void imem_transfer(int input[], int imem[], int ich_size, int batch_size){
    for (int i = 0; i < ich_size*batch_size; i=i+1){
        imem[(i/ich_size)+(i%ich_size)*batch_size] = input[i];
    }
}
void wmem_transfer(int weight[], int wmem[], int ich_size, int tile_size){
    for (int i = 0; i < ich_size*tile_size; i=i+1){
        wmem[(i/ich_size)+(i%ich_size)*tile_size] = weight[i];
    }
}
void bias_transfer(int bias[], int bmem[], int bias_size){
    for (int i = 0; i < bias_size; i=i+1){
        bmem[i] = bias[i];
    }
}

void omem_transfer(int omem[], int output[], int output_size){
    for (int i = 0; i < output_size; i=i+1){
        output[i] = omem[i]; // TODO
    }
}