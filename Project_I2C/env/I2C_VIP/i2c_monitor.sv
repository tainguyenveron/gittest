class i2c_monitor extends uvm_monitor;
	uvm_analysis_port#(i2c_base_item) mon_port;	
	`uvm_component_utils(i2c_monitor)
	virtual i2c_if vif;
		
	function new(string name = "i2c_monitor", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("MON","Inside Build phase",UVM_HIGH)	
		mon_port = new("mon_port",this);
		if(!uvm_config_db #(virtual i2c_if)::get(this,"","vif",vif))begin
				  `uvm_fatal("MON","Cant get vif")
				  end
		else begin
				  `uvm_info("MON","Get vif successfully",UVM_HIGH)
				  end


	endfunction
endclass



