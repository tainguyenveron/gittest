class i2c_sequencer extends uvm_sequencer #(i2c_base_item);
	`uvm_component_utils(i2c_sequencer)

	function new(string name = "i2c_sequencer", uvm_component parent);
		super.new(name,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("SEQR","Inside Build phase",UVM_HIGH)
	endfunction

endclass
