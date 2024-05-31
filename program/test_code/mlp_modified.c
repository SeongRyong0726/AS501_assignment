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

#include "mlp.h"
#include <stdint.h>
#include <inttypes.h>

int main(void){
    int* input       = (int*)(INPUT_ADDR);
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
    int* input_loopback = (int*)(INPUT_LOOPBACK_ADDR);
    // JW ADD (24.05.29)
    uint8_t* imem    = (uint8_t*)(IMEM_ADDR);
    uint8_t* wmem    = (uint8_t*)(WMEM_ADDR);
    uint8_t* bmem    = (uint8_t*)(BMEM_ADDR);
    int* omem        = (int*)(OMEM_ADDR);

////////////////////////////////////////////////////////////////////////////////
//  IMEM Loopback Test
    for (int i = 0; i < IMEM_DATA_NUM; ++i){
        imem[i] = input[i]
    }
    for (int i = 0; i < IMEM_DATA_NUM; ++i){
        input_loopback[i] = imem[i]
    }
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

    for (image_idx = 0; image_idx < NUM_OF_TEST; ++image_idx){
        fully_connected(&input[INPUT_SIZE * image_idx], fc1_weight,
                        fc1_bias, fc1_output, INPUT_SIZE, HIDDEN1_SIZE);
        fully_connected(fc1_output, fc2_weight, fc2_bias, fc2_output,
                        HIDDEN1_SIZE, HIDDEN2_SIZE);
        fully_connected(fc2_output, fc3_weight, fc3_bias, output,
                        HIDDEN2_SIZE, OUTPUT_SIZE);

        if (max(output) == label[image_idx]){
            ++correct_count;
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

void fully_connected(int input[], int weight[], int bias[], int output[],
                     int input_size, int output_size){
    for (int i = 0; i < output_size; ++i) {
        output[i] = 0;
        for (int j = 0; j < input_size; j++) {
            output[i] += input[j] * weight[i * input_size + j];
        }
        output[i] += bias[i];
        // ReLU
        output[i] = (output[i] > 0) ? output[i] : 0;
    }
}

int max(int input[]) {
    int max_value = input[0];
    int max_index = 0;
    for (int i = 1; i < OUTPUT_SIZE; ++i) {
        if (input[i] > max_value) {
            max_value = input[i];
            max_index = i;
        }
    }
    return max_index;
}