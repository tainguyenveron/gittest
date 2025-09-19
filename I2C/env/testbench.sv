`timescale 1ns/1ns

  import uvm_pkg::*;
`include "uvm_macros.svh"
`include "apb_pkg.sv"
`include "apb_if.sv"	
import apb_pkg::*;

module testbench;

apb_if vif();

initial begin
	#5;
	forever begin
	#5 vif.pclk = ~vif.pclk;	
	end
end

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

endmodule
