`include "base_env.sv"
class base_test extends uvm_test;
`uvm_component_utils(base_test)
	function new(string name = "base_test", uvm_component parent = null);
		super.new(name,parent);
	endfunction
    base_env e;
   
    virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
    /** Create the environment */
    e = base_env::type_id::create("e",this);
    `uvm_info("build_phase", "i2c_base_test BUILD-FLOW: Finishing...",UVM_LOW)
	endfunction

    endclass: base_test
