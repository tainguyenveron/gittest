//`timescale 1ns/1ns
`timescale 100ps/100ps
`define SVT_I2C_GLOBAL_TIMEOUT 1000ms 
`include "svt_i2c.uvm.pkg"
`include "i2c_reset_if.svi"

  import uvm_pkg::*;
  /** Import the SVT UVM Package */
  import svt_uvm_pkg::*;
  
  /** Import I2C SVT UVM Package */
  import svt_i2c_uvm_pkg::*;
  
  /** Import I2C SVT ENUM Package */
  import svt_i2c_enum_pkg::*;

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
`include "abp_config.sv"
`include "base_driver.sv"
`include "base_monitor.sv"
`include "base_agent.sv"
`include "base_scoreboard.sv"
`include "top_test.sv"



module top;
  // Global 
  bit reset=1'b0;
  
  /** 
   * Parameter defines the clock frequency. The value of 10 given
   * to this parameter is to generate clock with time period 1ns
   * as per the timescale resolution set to 100ps.
   * Values of all timing variables are given in ns as per the 
   * time period of this clk.
   */
  parameter simulation_cycle = 10;
  
  /** Signal to generate the clock */
  bit SystemClock;
  svt_i2c_if i2c_if (SystemClock);
  
  /** Intantiate Master Wrapper */
//  svt_i2c_master_wrapper Master (i2c_if);
  
  /** Intantiate Slave Wrapper */
//  svt_i2c_slave_wrapper Slave (i2c_if);


    svt_i2c_master_wrapper #(.I2C_AGENT_ID(0)) Master0 (i2c_if);
    svt_i2c_slave_wrapper #(.I2C_AGENT_ID(0)) Slave0 (i2c_if);


  /** TB Interface instance to provide access to the reset signal */
  i2c_reset_if i2c_reset_if();
  assign i2c_reset_if.clk = SystemClock; 
  assign i2c_if.RST = i2c_reset_if.reset;
  assign vif.pclk = SystemClock; 
//  assign vif.presetn = ~i2c_reset_if.reset;

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
	     .pwdata(vif.pwdata),.prdata(vif.prdata),.pready(vif.pready), .pslverr(vif.pslverr),
         .SDA(i2c_if.SDA), .SCL(i2c_if.SCL)
     );

	initial begin
		uvm_config_db#(virtual apb_if)::set(null,"*","vif",vif);
    /** Set the Master Interface to factory */
    uvm_config_db#(virtual svt_i2c_if)::set(uvm_root::get(),  
                                            "uvm_test_top.env", 
                                            "vif", i2c_if);
    
    /** Set the reset interface on the virtual sequencer */
    uvm_config_db#(virtual i2c_reset_if.i2c_reset_modport)::set(uvm_root::get(), 
                                                                "uvm_test_top.env.sequencer", 
                                                                "reset_mp", 
                                                                i2c_reset_if.i2c_reset_modport);
  
		run_test();
	end
	
	initial begin
		$dumpfile("dump.fsdb");
		$dumpvars;
	#`SVT_I2C_GLOBAL_TIMEOUT;
			$finish;
	end

endmodule: top
