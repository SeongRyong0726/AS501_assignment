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
    RTL_DIR="$THIS_SCRIPT_DIR/../rtl"
    TB_DIR="$THIS_SCRIPT_DIR/tb_modified"
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
    RTL_LIST="$RTL_DIR/common/memory_map.sv                                 \
              $RTL_DIR/common/bus_package.sv                                \
              $RTL_DIR/common/core_package.sv                               \
              $RTL_DIR/common/d_flip_flop.sv                                \
              $RTL_DIR/common/mux2to1.sv                                    \
              $RTL_DIR/common/mux3to1.sv                                    \
              $RTL_DIR/common/mux4to1.sv                                    \
              $RTL_DIR/common/mux5to1.sv                                    \
              $RTL_DIR/common/counter.sv                                    \
              $TB_DIR/core_tb_10.sv                                         \
              $RTL_DIR/soc_top/soc_top.sv                                   \
              $RTL_DIR/cpu_top/cpu_top.sv                                   \
              $RTL_DIR/scalar_core_modified/cache/submodule/cache_sram.sv   \
              $RTL_DIR/scalar_core_modified/cache/instr_cache.sv            \
              $RTL_DIR/scalar_core_modified/core/submodule/alu.sv           \
              $RTL_DIR/scalar_core_modified/core/submodule/csr.sv           \
              $RTL_DIR/scalar_core_modified/core/submodule/decoder.sv       \
              $RTL_DIR/scalar_core_modified/core/submodule/regfile.sv       \
              $RTL_DIR/scalar_core_modified/core/scalar_core.sv             \
              $RTL_DIR/npu_top/npu_top.sv                                   \
              $RTL_DIR/npu_top/interface/npu_interface.sv                   \
              $RTL_DIR/npu_top/submodule/npu.sv                             \
              $RTL_DIR/npu_top/submodule/ram.sv                             \
              $RTL_DIR/memory/memory_top.sv                                 \
              /technology/SAED32/lib/sram/verilog/saed32sram.v              \
              $RTL_DIR/bus/bus_top.sv                                       \
              $RTL_DIR/bus/interconnect/interconnect.sv                     \
              $RTL_DIR/bus/interconnect/submodule/decoder.sv                \
              $RTL_DIR/bus/interconnect/submodule/multiplexer.sv            \
              $RTL_DIR/bus/default/default_slave.sv"

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
        -sverilog $RTL_LIST     \
        -timescale=$TIMESCALE   \
        +incdir+$DC/dw/sim_ver  \
        +define+SIM             \
        -debug_access+all       \
        -kdb                    \
        -l vcs.log
    ./simv -fgp=num_threads:1 -fgp=num_fsdb_threads:1 -fgp=fsdb_adjust_cores | tee vcs_sim.log
##
################################################################################
