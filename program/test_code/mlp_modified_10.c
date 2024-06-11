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
    volatile int* input       = (volatile int*)(INPUT_ADDR);
    volatile int* fc1_weight  = (volatile int*)(FC1_W_ADDR);
    volatile int* fc1_bias    = (volatile int*)(FC1_B_ADDR);
    volatile int* fc1_output  = (volatile int*)(FC1_O_ADDR);
    volatile int* fc2_weight  = (volatile int*)(FC2_W_ADDR);
    volatile int* fc2_bias    = (volatile int*)(FC2_B_ADDR);
    volatile int* fc2_output  = (volatile int*)(FC2_O_ADDR);
    volatile int* fc3_weight  = (volatile int*)(FC3_W_ADDR);
    volatile int* fc3_bias    = (volatile int*)(FC3_B_ADDR);
    volatile int* output      = (volatile int*)(OUTPUT_ADDR);
    volatile int* label       = (volatile int*)(LABEL_ADDR);
    
    // JW ADD (24.05.29)
    volatile int* input_loopback = (volatile int*)(INPUT_LOOPBACK_ADDR);

    volatile int* imem    = (volatile int*)(IMEM_ADDR);
    volatile int* wmem    = (volatile int*)(WMEM_ADDR);
    volatile int* bmem    = (volatile int*)(BMEM_ADDR);
    volatile int* omem    = (volatile int*)(OMEM_ADDR);

    volatile int* tile_start        = (volatile int*)(TILE_START_ADDR);
    volatile int* tile_end          = (volatile int*)(TILE_END_ADDR);   
    volatile int* omem2imem_start   = (volatile int*)(OMEM2IMEM_START_ADDR); 
    volatile int* omem2imem_end     = (volatile int*)(OMEM2IMEM_END_ADDR); 
    volatile int* npu_ctrl          = (volatile int*)(NPU_CTRL_ADDR);
    
    int NPUCtrlSize = 16;

    int InputSize     = 784;
    int Hidden1Size   = 128;
    int Hidden2Size   = 64;
    int OutputSize    = 10;



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
    unsigned int batch_size = 0;

    for (batch_idx = 0; batch_idx < NUM_OF_BATCH; ++batch_idx){
        if ((batch_idx == NUM_OF_BATCH-1) && (NUM_OF_TEST%BATCH_SIZE!=0)){
            batch_size = NUM_OF_TEST%BATCH_SIZE;
        }
        else{
            batch_size = 16;
        }
   
        batch_inference(&input[INPUT_SIZE*BATCH_SIZE*batch_idx], 
                        fc1_weight, fc2_weight, fc3_weight,
                        fc1_bias, fc2_bias, fc3_bias, 
                        &output[BATCH_SIZE*batch_idx],
                        imem, wmem, bmem, omem, 
                        tile_start, tile_end, omem2imem_start, omem2imem_end, 
                        npu_ctrl, batch_size);

        for (image_idx_offset = 0; image_idx_offset < batch_size; ++image_idx_offset){
            if (output[image_idx] == label[image_idx]){
                ++correct_count;
            }
            ++image_idx;
        }
        
    }
    //}

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


void batch_inference(   volatile int input[], volatile int fc1_weight[], volatile int fc2_weight[], volatile int fc3_weight[],
                        volatile int fc1_bias[], volatile int fc2_bias[], volatile int fc3_bias[], volatile int output[], 
                        volatile int imem[], volatile int wmem[], volatile int bmem[], volatile int omem[],
                        volatile int tile_start[], volatile int tile_end[], volatile int omem2imem_start[], volatile int omem2imem_end[],
                        volatile int npu_ctrl[], int batch_size){
    
    npu_ctrl[9] = INPUT_SIZE;  //ich                                                 
    imem_transfer(input, imem, INPUT_SIZE, batch_size, I_EMA_SIZE);
    
    layer1_inference(fc1_weight, fc1_bias, wmem, bmem, tile_start, tile_end, omem2imem_start, omem2imem_end, npu_ctrl, batch_size);
    layer2_inference(fc2_weight, fc2_bias, wmem, bmem, tile_start, tile_end, omem2imem_start, omem2imem_end, npu_ctrl, batch_size);
    layer3_inference(fc3_weight, fc3_bias, wmem, bmem, tile_start, tile_end, npu_ctrl, batch_size);
    
    //omem_transfer(omem, output, batch_size);
    output[9] = omem[0];
    output[8] = omem[1];
    output[7] = omem[2];
    output[6] = omem[3];
    output[5] = omem[4];
    output[4] = omem[5];
    output[3] = omem[6];
    output[2] = omem[7];
    output[1] = omem[8];
    output[0] = omem[9];
    // output[0] = omem[15];
    // output[1] = omem[14];
    // output[2] = omem[13];
    // output[3] = omem[12];
    // output[4] = omem[11];
    // output[5] = omem[10];
    // output[6] = omem[9];
    // output[7] = omem[8];
    // output[8] = omem[7];
    // output[9] = omem[6];
    // output[10] = omem[5];
    // output[11] = omem[4];
    // output[12] = omem[3];
    // output[13] = omem[2];
    // output[14] = omem[1];
    // output[15] = omem[0];
}

void imem_transfer(volatile int input[], volatile int imem[], int ich_size, int batch_size, int i_ema_size){
    for (int i = 0; i < I_EMA_SIZE; i=i+1){
        //volatile int temp = input[i];
        //imem[i] = temp;
        imem[i] = input[i];
        //imem[(i/ich_size)+(i%ich_size)*BATCH_SIZE] = input[i];
    }
}

void wmem_transfer(volatile int weight[], volatile int wmem[], int ich_size, int tile_size, int w_ema_size){
    for (volatile int i = 0; i < w_ema_size; i=i+1){
        //volatile int temp = weight[i];
        //wmem[i] = temp;
        wmem[i] = weight[i];
        //wmem[(i/ich_size)+(i%ich_size)*tile_size] = weight[i];
        //volatile int temp = (i/ich_size)+(i%ich_size)*tile_size;
        //wmem[temp] = weight[i];
    }
}
void bias_transfer(volatile int bias[], volatile int bmem[], int bias_size){
    for (volatile int i = 0; i < bias_size; i=i+1){
        bmem[i] = bias[i];
    }
}

void omem_transfer(volatile int omem[], volatile int output[], int output_size){
    for (volatile int i = 0; i < output_size; i=i+1){
        output[i] = omem[i];
    }
}


void layer1_inference(  volatile int fc1_weight[], volatile int fc1_bias[], volatile int wmem[], volatile int bmem[], 
                        volatile int tile_start[], volatile int tile_end[], volatile int omem2imem_start[], volatile int omem2imem_end[],
                        volatile int npu_ctrl[], int batch_size){

    // Contrl Signal Transfer 
    npu_ctrl[2] = 0; 
    npu_ctrl[3] = batch_size; //batch 
    npu_ctrl[4] = 0; 
    npu_ctrl[5] = 16;  //output ch
    npu_ctrl[9] = INPUT_SIZE;  //ich
    npu_ctrl[10] = 1; //cliff_8_on
    
    for (volatile int i = 0; i<FC1_TILE_ITER; i=i+1){
        npu_ctrl[6] = 16*i;
        wmem_transfer(&fc1_weight[INPUT_SIZE*TILE_SIZE*i], wmem, INPUT_SIZE, TILE_SIZE, W_FC1_TILE_EMA_SIZE);
        bias_transfer(&fc1_bias[TILE_SIZE*i], bmem, TILE_SIZE);
        tile_start[0] = 0x00000001;
        
        while(tile_end[0] != 0x00000001){
            ;
        }
    }
    
    for (volatile int i = 0; i<FC1_TILE_ITER; i=i+1){
        npu_ctrl[7] = (i)*16; //Intra_O 
        npu_ctrl[8] = (i)*16; //Intra_A
        omem2imem_start[0] = 0x00000001; // OMEM --> IMEM Transfer
        while(omem2imem_end[0] == 0x00000001){
            ;
        }
    }

}
void layer2_inference(  volatile int fc2_weight[], volatile int fc2_bias[], volatile int wmem[], volatile int bmem[], 
                        volatile int tile_start[], volatile int tile_end[], volatile int omem2imem_start[], volatile int omem2imem_end[],
                        volatile int npu_ctrl[], int batch_size){

    // Contrl Signal Transfer
    npu_ctrl[2] = 0; 
    npu_ctrl[3] = batch_size; //batch 
    npu_ctrl[4] = 0; 
    npu_ctrl[5] = 16;
    npu_ctrl[9] = HIDDEN1_SIZE; 
    npu_ctrl[10] = 1; //cliff_8_on

    // Tile-wise Operation
    for (volatile int i = 0; i<FC2_TILE_ITER; i=i+1){
        npu_ctrl[6] = 16*i; 
        wmem_transfer(&fc2_weight[HIDDEN1_SIZE*TILE_SIZE*i], wmem, HIDDEN1_SIZE, TILE_SIZE, W_FC2_TILE_EMA_SIZE);
        bias_transfer(&fc2_bias[TILE_SIZE*i], bmem, TILE_SIZE);
        tile_start[0] = 0x00000001;
        while(tile_end[0] != 0x00000001){
            ;
        }
    }
    for (volatile int i = 0; i<FC2_TILE_ITER; i=i+1){
        npu_ctrl[7] = i*16; //Intra_O 
        npu_ctrl[8] = (i)*16; //Intra_A
        omem2imem_start[0] = 0x00000001; // OMEM --> IMEM Transfer
        while(omem2imem_end[0] == 0x00000001){
            ;
        }
    }
}
void layer3_inference(  volatile int fc3_weight[], volatile int fc3_bias[], volatile int wmem[], volatile int bmem[], 
                        volatile int tile_start[], volatile int tile_end[], volatile int npu_ctrl[], int batch_size){

    // Contrl Signal Transfer
    npu_ctrl[2] = 0; 
    npu_ctrl[3] = batch_size; //batch 
    npu_ctrl[4] = 0; 
    npu_ctrl[5] = 10;
    npu_ctrl[7] = 0; 
    npu_ctrl[8] = 0;    
    npu_ctrl[9] = HIDDEN2_SIZE; 
    npu_ctrl[10] = 0; //cliff_8_on
    
    // Tile-wise Operation
    for (volatile int i = 0; i<1; i=i+1){
        npu_ctrl[6] = 16*i; 
        wmem_transfer(&fc3_weight[HIDDEN2_SIZE*10*i], wmem, HIDDEN2_SIZE, 10, W_FC3_TILE_EMA_SIZE);
        bias_transfer(&fc3_bias[TILE_SIZE*i], bmem, TILE_SIZE);
        tile_start[0] = 0x00000001;
        while(tile_end[0] != 0x00000001){
            ;
        }
    }
}

