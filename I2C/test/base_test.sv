class base_test extends uvm_test;
`uvm_component_utils(base_test)
	
	function new(string name = "base_test", uvm_component parent = null);
		super.new(name,parent);
	endfunction
	
	base_env e;
	writeb_readb wrb;  	
 
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
    		e = base_env::type_id::create("e",this);
		wrb = writeb_readb::type_id::create("wrb");
        	`uvm_info("BASE_TEST","INSIDE BUILD PHASE",UVM_HIGH)
	endfunction

	virtual task run_phase(uvm_phase phase);
		phase.raise_objection(this);
        	`uvm_info("BASE_TEST","INSIDE RUN PHASE",UVM_HIGH)
		wrb.start(e.a.seqr);
		phase.drop_objection(this);
	endtask

	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();
	endfunction
endclass: base_test
