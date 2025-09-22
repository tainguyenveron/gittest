# ---------------------
# Configurable Variables
# ---------------------
TESTNAME    ?= base_test
TOP         ?= testbench
RADIX       = hex
EXCLUDE_TCL = exclude_coverage.tcl

# ---------------------
# Directories
# ---------------------
LOG_DIR     = log
WAVE_DIR    = waveform
DB_DIR      = db
COV_DIR     = coverage

# ---------------------
# Default Target
# ---------------------
all: clean build

# ---------------------
# Compile Design and Testbench
# ---------------------
build:
	@echo "[BUILD] Compiling design and testbench..."
	vlib work
	vmap work work
	vlog -sv +cover=bcesft +acc -f ../filelists.f | tee compile.log

# ---------------------
# Run UVM Simulation without coverage
# ---------------------
run:
	@echo "[SIM] Running UVM test: $(TESTNAME)"
	mkdir -p $(LOG_DIR) $(WAVE_DIR)
	vsim -c +UVM_VERBOSITY=UVM_HIGH -voptargs=+acc -assertdebug -debugDB -l $(LOG_DIR)/$(TESTNAME).log $(TOP) \
	     -wlf $(WAVE_DIR)/$(TESTNAME).wlf \
	     -do "log -r /*; run -all; quit" \
	     +UVM_TESTNAME=$(TESTNAME)

# ---------------------
# Open Waveform Viewer
# ---------------------
wave:
	@if [ ! -f $(WAVE_DIR)/$(TESTNAME).wlf ]; then \
		echo "[WAVE] Waveform not found. Run 'make run TESTNAME=$(TESTNAME)' first."; \
	else \
		echo "[WAVE] Opening waveform viewer for test: $(TESTNAME)"; \
		vsim -i -view $(WAVE_DIR)/$(TESTNAME).wlf \
		     -do "if {[string match /* $(TOP)]} {add wave -r /$(TOP)/dut/*;} else {add wave -r /$(TOP);}; radix -$(RADIX)" & \
	fi

# ---------------------
# Clean all generated files
# ---------------------
clean:
	@echo "[CLEAN] Cleaning all generated files..."
	rm -rf *.ini work transcript *.dbg *.wlf \
	       $(LOG_DIR) $(WAVE_DIR) $(DB_DIR) $(COV_DIR)


