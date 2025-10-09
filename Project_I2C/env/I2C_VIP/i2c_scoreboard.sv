class i2c_scoreboard extends uvm_scoreboard;
	uvm_analysis_imp #(i2c_base_item, i2c_scoreboard) scb_port;
	`uvm_component_utils(i2c_scoreboard)
	
	function new(string name = "i2c_scoreboard", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("SCB","Inside Build phase",UVM_HIGH)
		scb_port = new("scb_port",this);
	endfunction

	virtual function void write(i2c_base_item item);
	endfunction
endclass


