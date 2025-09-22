`timescale 1ns/1ns

`include "../apb_master/apb_pkg.sv"
import apb_pkg::*;

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

endmodule: top
