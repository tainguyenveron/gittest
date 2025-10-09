export TEST_NAME = base_test
export LOG_FILE = log/$(TEST_NAME).log
export COMPILE_LOG = compile.log
export WAVE_DIR = log
export TOP = top
export RADIX = hex

.PHONY: all clean compile run wave help

help:
	@echo "============================================"
	@echo "Usage: make <target>"
	@echo ""
	@echo "Target:"
	@echo "	all: clean + compile + run"
	@echo "	clean: remove dumped files"
	@echo "	compile: compile only -> compile.log"
	@echo "	run: run simulation -> log/$(TESTNAME).log"
	@echo "	wave: open GUI"
	@echo "	help: this message"
	@echo ""
	@echo "Variables:"
	@echo "TEST_NAME: Set test name (default: base_test)"
	@echo "============================================"

all: clean compile run

clean:
	rm -rf *.ini work transcript *.dbg *.wlf log *.log

compile:
	vlib work | tee -a $(COMPILE_LOG)
	vlog -sv \
	-f ../filelist.f | tee -a $(COMPILE_LOG)

run:
	mkdir -p log
	vsim -c work.top \
	+UVM_VERBOSITY=UVM_HIGH -voptargs=+acc -assertdebug -debugDB \
	+UVM_TESTNAME=$(TEST_NAME) \
	-wlf $(WAVE_DIR)/$(TEST_NAME).wlf \
	-do "log -r /*; run -all; quit" \
	| tee $(LOG_FILE)

wave:
	@if [ ! -f $(WAVE_DIR)/$(TEST_NAME).wlf ]; then \
		echo "Waveform not found. Use make run TEST_NAME=$(TEST_NAME)' first."; \
	else \
		echo "Opening waveform for test: $(TEST_NAME)"; \
		vsim -i -view $(WAVE_DIR)/$(TEST_NAME).wlf \
			-do "if {[string match /* $(TOP)]} {add wave -r /$(TOP)/dut/*;} else {add wave -r /$(TOP);}; radix -$(RADIX)" & \
			fi

