`timescale 1ns/1ns

  import uvm_pkg::*;
  

`include "uvm_macros.svh"


//--------------------------------------------------------
//Include Files
//--------------------------------------------------------
`include "apb_if.sv"
`include "base_item.sv"
//`include "sequence_write.sv"
//`include "sequence_read.sv"
//`include "sequencer.sv"
`include "sequence_top.sv"
`include "apb_config.sv"
`include "base_driver.sv"
`include "base_monitor.sv"
`include "base_agent.sv"
`include "base_scoreboard.sv"
`include "top_test.sv"



module top;
  
  parameter simulation_cycle = 10;
  
  /** Signal to generate the clock */
  bit SystemClock;

  assign vif.pclk = SystemClock; 

  // ----------------------------------------------------------------------
  // Testbench 'System' Clock Generator
  // ----------------------------------------------------------------------
  initial begin
    #(simulation_cycle/2); // No clock edge at T=0
    SystemClock = 0 ;
    forever begin
      #(simulation_cycle/2)
      SystemClock = ~SystemClock ;
    end
  end


apb_if vif();
apb_ram dut (.pclk(vif.pclk),
	     .presetn(vif.presetn), .psel(vif.psel), .penable(vif.penable), .pwrite(vif.pwrite), .paddr(vif.paddr),
	     .pwdata(vif.pwdata),.prdata(vif.prdata),.pready(vif.pready), .pslverr(vif.pslverr)
     );

	initial begin
		uvm_config_db#(virtual apb_if)::set(null,"*","vif",vif);
		run_test();
	end
	
	initial begin
		$dumpfile("dump.fsdb");
		$dumpvars;
	end

endmodule: top
