package i2c_pkg;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	`include "i2c_base_item.sv"
	`include "i2c_config.sv"
	`include "sequence_top.sv"
	`include "i2c_driver.sv"
	`include "i2c_monitor.sv"
	`include "i2c_sequencer.sv"
	`include "i2c_agent.sv"
	`include "i2c_scoreboard.sv"
	`include "../system_env.sv"
	`include "top_test.sv"
endpackage
