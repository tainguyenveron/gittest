class base_test extends uvm_test;
	`uvm_component_utils(base_test)
	system_env env;
			
	function new(string name = "base_test", uvm_component parent = null);
		super.new(name,parent);
	endfunction
   
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = system_env::type_id::create("env",this);
		`uvm_info("TEST","Inside Build phase",UVM_HIGH)
	endfunction

 	function void end_of_elaboration_phase (uvm_phase phase);
    		uvm_top.print_topology();
	endfunction

endclass
