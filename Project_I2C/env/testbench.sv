`timescale 1ns/1ps

	import uvm_pkg::*;
	import i2c_pkg::*;
	import apb_pkg::*;

`include "i2c_if.sv"
`include "apb_if.sv"
`include "uvm_macros.svh"

module top;
  
  parameter simulation_cycle = 10;
  bit SystemClock;
		
	initial begin
    		#(simulation_cycle/2); 
    		SystemClock = 0 ;
    		forever begin
      			#(simulation_cycle/2)
      			SystemClock = ~SystemClock ;
    		end
  	end

apb_if a_vif();
i2c_if vif();

apb_ram dut (.presetn(a_vif.presetn),.pclk(SystemClock),.paddr(a_vif.paddr),.pwrite(a_vif.pwrite),.pwdata(a_vif.pwdata),.penable(a_vif.penable),.psel(a_vif.psel),.prdata(a_vif.prdata),.pslverr(a_vif.pslverr),.pready(a_vif.pready),.SCL(vif.scl),.SDA(vif.sda)
     );

	initial begin
		uvm_config_db#(virtual apb_if)::set(null,"uvm_test_top.env.a_agent.*","a_vif",a_vif);
		uvm_config_db#(virtual i2c_if)::set(null,"uvm_test_top.env.agent.*","vif",vif);
		run_test();
	end

endmodule
