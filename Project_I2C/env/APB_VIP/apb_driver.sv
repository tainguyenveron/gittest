class apb_driver extends uvm_driver #(apb_base_item);
	`uvm_component_utils(apb_driver)
	virtual apb_if a_vif;

	function new(string name = "apb_driver", uvm_component parent);
		super.new(name,parent);	
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("APB_DRV","Inside Build Phase",UVM_HIGH)
		if(!uvm_config_db #(virtual apb_if)::get(this,"","a_vif",a_vif))begin
				  `uvm_fatal("APB_DRV","Cant get vif")
				  end
		else begin
				  `uvm_info("APB_DRV","Get vif successfully",UVM_HIGH)
				  end
							 
	endfunction
	
	virtual task run_phase(uvm_phase phase);
	endtask
endclass: apb_driver
