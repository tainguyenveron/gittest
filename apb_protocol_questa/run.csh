####################################VCS###########################################
#mkdir -p log
#source /home/eda/snps_setup
#
#export TEST_NAME=top_test
#export LOG_FILE=log/$TEST_NAME.log
#
#vcs -sverilog -full64 -ntb_opts uvm-1.2 -timescale=1ps/1ps -notice \
#+incdir+/home/dtvlsi/Desktop/apb_protocol_cust/apb_protocol_test/sequence_files \
#testbench.sv design.sv +vcs+dupvars+verilog.vpd -debug_all -kdb -fsdb
#
# # Run simulation
# ./simv -cm line+cond+fsm +ntb_random_seed=$SEED +UVM_TESTNAME=$TEST_NAME > $LOG_FILE
#  
#!/bin/bash

#####################################Questasim#####################################
mkdir -p log


export TEST_NAME=top_test
export LOG_FILE=log/$TEST_NAME.log

vlib work
vlog -sv -timescale=1ps/1ps \
    +incdir+/home/tai/Desktop/gittest/apb_protocol_questa/sequence_files \
    testbench.sv design.sv
vsim -c work.top \
    +UVM_VERBOSITY=UVM_HIGH -voptargs=+acc -assertdebug -debugDB \
    +UVM_TESTNAME=$TEST_NAME \
    -do "log -r /*; run -all; quit" \
    > $LOG_FILE
