#!/bin/bash
################################################################################
## AS501
## Final Project
## Run VCS Simulation Script
################################################################################
## Copyright (c) 2024 by Smart Energy-Efficient Design Lab. (SEED), KAIST
## All rights reserved.
##
##                            Written by Hyungjoon Bae (jo_on@kaist.ac.kr)
##                            Supervised by Wanyeong Jung (wanyeong@kaist.ac.kr)
################################################################################

################################################################################
## Don't touch
##
    THIS_SCRIPT_DIR="$(realpath "$(dirname "$BASH_SOURCE")")"
    RTL_DIR="$THIS_SCRIPT_DIR/../../rtl"
    TB_DIR="$THIS_SCRIPT_DIR"
    OUT_DIR="./out"

    if [ -n "$OUT_DIR" ]; then
        if [ -d "$OUT_DIR" ]; then
            # Clean the output directory
            rm -rf $OUT_DIR/*
        else
            # Make an output directory
            mkdir -p $OUT_DIR
        fi
    else
        echo "set OUT_DIR variable"
    fi

    # Make log file
    cd $OUT_DIR
    TIME=$(date +%Y-%m-%d_%H:%M)
    touch $TIME.txt
##
################################################################################

################################################################################
## Modify to fit your source file names
##
    # Simulated rtl list
    RTL_LIST=" $RTL_DIR/npu/Bias_ReLU/Bias_ReLU_simd.v \
               $RTL_DIR/npu/buf/A_buffer.v \
               $RTL_DIR/npu/buf/address_generator_A.v \
               $RTL_DIR/npu/buf/address_generator_O.v \
               $RTL_DIR/npu/buf/address_generator_W.v \
               $RTL_DIR/npu/buf/O_buffer.v \
               $RTL_DIR/npu/buf/W_buffer.v \
               $RTL_DIR/npu/core/pe.v \
               $RTL_DIR/npu/core/systolic_array.v \
               $RTL_DIR/npu/submodule/mux_2_to_1.v \
               $RTL_DIR/npu/submodule/ram.v \
               $RTL_DIR/npu/submodule/reg_with_sync_en.v \
               $TB_DIR/tb_systolic_system.v \
               $RTL_DIR/npu/systolic_system.v                   "
              

    # Timescale
    TIMESCALE="1ns/1ps"
##
################################################################################

################################################################################
## Modify as needed
##
    # Run vcs
    vcs -fgp                    \
        -full64                 \
        $RTL_LIST     \
        -timescale=$TIMESCALE   \
        +incdir+$DC/dw/sim_ver  \
        +define+SIM             \
        -debug_access+all       \
        -kdb                    \
        -l vcs.log
    #./simv -fgp=num_threads:1 -fgp=num_fsdb_threads:1 -fgp=fsdb_adjust_cores | tee vcs_sim.log
    ./simv -verdi &
##
################################################################################
