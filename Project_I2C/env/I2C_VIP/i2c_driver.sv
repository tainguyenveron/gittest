class i2c_driver extends uvm_driver #(i2c_base_item);
	`uvm_component_utils(i2c_driver)
	virtual i2c_if vif;
	
	function new(string name = "i2c_driver", uvm_component parent);
		super.new(name,parent);	
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("DRIVER","Inside Build phase",UVM_HIGH)
		if(!uvm_config_db #(virtual i2c_if)::get(this,"","vif",vif))begin
				  `uvm_fatal("DRIVER","Cant get vif")
				  end
		else begin
				  `uvm_info("DRIVER","Get vif successfully",UVM_HIGH)
				  end

	endfunction
	
endclass
