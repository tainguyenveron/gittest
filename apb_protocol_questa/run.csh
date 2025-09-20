mkdir -p log
source /home/eda/snps_setup

export TEST_NAME=top_test
export LOG_FILE=log/$TEST_NAME.log

vcs -sverilog -full64 -ntb_opts uvm-1.2 -timescale=1ps/1ps -notice \
+incdir+/home/dtvlsi/Desktop/apb_protocol_cust/apb_protocol_test/sequence_files \
testbench.sv design.sv +vcs+dupvars+verilog.vpd -debug_all -kdb -fsdb

 # Run simulation
 ./simv -cm line+cond+fsm +ntb_random_seed=$SEED +UVM_TESTNAME=$TEST_NAME > $LOG_FILE
     
