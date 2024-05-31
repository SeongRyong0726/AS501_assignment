#==== Testbench & Tester ====#
./tb_modified/core_tb_10.sv

#==== DUT Top ====#
../rtl/soc_top/soc_top.sv

#==== CPU Top ====#
../rtl/cpu_top/cpu_top.sv

#==== Scalar Core ====#
../rtl/scalar_core_modified/cache/submodule/cache_sram.sv  
../rtl/scalar_core_modified/cache/instr_cache.sv   
../rtl/scalar_core_modified/core/submodule/alu.sv                      
../rtl/scalar_core_modified/core/submodule/csr.sv                      
../rtl/scalar_core_modified/core/submodule/decoder.sv                  
../rtl/scalar_core_modified/core/submodule/regfile.sv                  
../rtl/scalar_core_modified/core/scalar_core.sv    

#==== NPU Core ====#
../rtl/npu_top/npu_top.sv
../rtl/npu_top/interface/npu_interface.sv
../rtl/npu_top/submodule/npu.sv

#==== Memory ====#
../rtl/memory/memory_top.sv                    
/technology/SAED32/lib/sram/verilog/saed32sram.v  

#==== Bus ====#
../rtl/bus/bus_top.sv
../rtl/bus/interconnect/interconnect.sv
../rtl/bus/interconnect/submodule/decoder.sv
../rtl/bus/interconnect/submodule/multiplexer.sv
../rtl/bus/default/default_slave.sv

#==== Common ====#
../rtl/common/memory_map.sv
../rtl/common/bus_package.sv
../rtl/common/core_package.sv                  
../rtl/common/d_flip_flop.sv                   
../rtl/common/mux2to1.sv                       
../rtl/common/mux3to1.sv                       
../rtl/common/mux4to1.sv                       
../rtl/common/mux5to1.sv                       
../rtl/common/counter.sv                                         

     




              