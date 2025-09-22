.IGNORE:
	compile
	simulate

# WE can also use the target where we WANT the silent mode
.SILENT:
	compile
	simulate
	usage

# First target will be executed incase the user doesn't mention
# the target to execute
# In this case, usage will be executed
# Usage
usage:
	@echo "";
	@echo "-----------------------------------------------------------------";
	@echo "------------------------- Usage ---------------------------------";
	@echo "";
	@echo "make target <options> <variable>=<value>";
	@echo "";
	@echo "To compile use:"
	@echo "make compile";
	@echo "";
	@echo "To simulate use:"
	@echo "make simulate test=<test_name> uvm_verbosity=<VERBOSITY_LEVEL>";
	@echo "";
	@echo "Example:":
	@echo "make simulate test=base_test uvm_verbosity=UVM_HIGH";
	@echo "";
	@echo "-----------------------------------------------------------------";
	@echo "-----------------------------------------------------------------";
	@echo "";
	@echo "To run regression:"
	@echo "make regression testlist_name=<regression_testlist_name.list>";
	@echo "";
	@echo "Example:":
	@echo "make regression testlist_name=apb_regression.list";
	@echo "";

all:
	make clean_compile; make compile; make simulate;

clean_compile: 
	rm -rf *_compile.log *_compile.history xcelium.d

clean_simulate:
	rm -rf *_test cov_work


compile:
	make clean_compile;

	xrun -c \
	-elaborate \
	-access +rwc \
	-64 \
	-sv \
	-uvm \
	+access+rw \
	-f ../filelist.f \
  -access +r +vcd \
	-l apb_compile.log \
	-top work.hvl_top ../../src/hvl_top/testbench.sv \
	-top work.hdl_top ../../src/hdl_top/design.sv \
	-coverage all \
	-sva 

	# -s means silent mode
	#  The command executed along with the output will be displayed on the terminal
	#  To get only the ouput use 'silent' mode
	# make compile_war_err -s
	# or use .SILENT
	make compile_war_err

# Setting a default test as base_test
ifndef test
override test := apb_base_test
endif

ifndef test_folder
override test_folder := $(test)
endif

# Setting the default uvm_verbosity to UVM_MEDIUM
ifndef uvm_verbosity
override uvm_verbosity := UVM_MEDIUM
endif

ifndef seed
override seed = random
endif

simulate:
	mkdir $(test_folder)

	xrun -R \
	-64 \
	-sv \
	-uvm \
  +sv_seed=$(seed) \
	+UVM_TESTNAME=$(test) \
	+UVM_VERBOSITY=$(uvm_verbosity) \
	-l $(test_folder)/$(test).log \
	-coverage all \
	-covoverwrite \
	-covtest $(test_folder)/ \
  +plusarg_ignore \

	mv *.vcd $(test_folder)/$(test).vcd
	# For checking and reporting simulation errors
	make simulate_war_err

## For Regression and coverage merge
regression:
	#Run compilation
	make compile
	#Run simualtion - regression
	python regression_handling.py $(testlist_name)
	#	# Get the tests from regression list
	#	Merge coverage
	#make merge_cov_report
 ## make clean


clean_all:
	make clean_compile
	make clean_simulate

compile_war_err:
	echo "";
	echo "-----------------------------------------------------------------";
	echo "------------------- Compilation Report --------------------------";
	echo "";
	grep "** " apb_compile.log;
	echo "";
	grep "*Error" apb_compile.log;
	echo "";
	echo "Log file path: apb_compile.log"
	echo "";
	echo "-----------------------------------------------------------------";
	echo "-----------------------------------------------------------------";
	echo "";

simulate_war_err:
	echo "";
	echo "-----------------------------------------------------------------";
	echo "-------------------- Simulation Report --------------------------";
	echo "";
	echo "Simulator Errors";
	grep "Error" $(test_folder)/$(test).log;
	echo "";
	echo "UVM Fatal";
	grep "UVM_FATAL" $(test_folder)/$(test).log;
	echo "";
	echo "UVM Errors";
	grep "UVM_ERROR" $(test_folder)/$(test).log;
	echo "";
	echo "UVM Warnings";
	grep "UVM_WARNING" $(test_folder)/$(test).log;
	echo "";
	echo "Testname: $(test)"
	echo "";
	echo "Log file path: $(test_folder)/$(test).log"
	echo "";
	echo "Waveform: simvision $(test_folder)/$(test).vcd &"
	echo "";
	echo "-----------------------------------------------------------------";
	echo "-----------------------------------------------------------------";
	echo "";
