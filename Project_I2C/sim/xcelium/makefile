ifndef hvl_top
override hvl_top:= testbench.sv
endif

ifndef hdl_top
override hdl_top:= design.sv 
endif 

ifndef compile_log
override compile_log:= compile.log
endif

ifndef test
override test:= base_test 
endif

ifndef test_folder
override test_folder := $(test)
endif

ifndef uvm_verbosity
override uvm_verbosity := UVM_MEDIUM
endif

ifndef seed
override seed = random
endif

.PHONY: all clean build run wave help

help:
	@echo "============================================"
	@echo "Usage: make <target>"
	@echo ""
	@echo "Target:"
	@echo "	all: clean + build + run"
	@echo "	clean: remove dumped files"
	@echo "	run: run simulation -> log/$(TESTNAME).log"
	@echo "	help: this message"
	@echo ""
	@echo "============================================"

all: clean build run

clean:
	rm -rf *_test *_compile.log *.history cov_work *.log xcelium.d

build:
	xrun -c	-timescale 1ns/1ps \
	-elaborate -access +rwc -64 -sv -uvm +access+rw	\
	-f ../filelist.f -access +r +vcd	\
	-coverage all \
	-sva 

run:
	mkdir $(test_folder) 
	xrun -R -64 -sv -uvm	\
	+sv_seed=$(seed) \
	+UVM_TESTNAME=$(test) \
	+UVM_VERBOSITY=$(uvm_verbosity) \
	-l $(test_folder)/$(test).log \
	-coverage all \
	-covtest $(test_folder)/ \
	+plusarg_ignore \
	mv *vcd $(test_folder)/$(test).vcd


