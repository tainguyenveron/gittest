class apb_monitor_w extends uvm_monitor;
	`uvm_component_utils(apb_monitor_w)
	virtual apb_if a_vif;
	
	uvm_analysis_port#(apb_base_item) send_w;

		function new(string name = "apb_monitor_w", uvm_component parent);
			super.new(name,parent);
		endfunction
		
		virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
			`uvm_info("APB_MON_W","Inside Build phase",UVM_HIGH)
		send_w = new("send_w",this);
		if(!uvm_config_db #(virtual apb_if)::get(this,"","a_vif",a_vif))begin
				  `uvm_fatal("APB_MON_W","Cant get vif")
				  end
		else begin
				  `uvm_info("APB_MON_W","Get vif successfully",UVM_HIGH)
				  end

		endfunction
		
endclass: apb_monitor_w

class apb_monitor_r extends uvm_monitor;
	`uvm_component_utils(apb_monitor_r)
	virtual apb_if a_vif;
	
	uvm_analysis_port#(apb_base_item) send_r;
		function new(string name = "apb_monitor_r", uvm_component parent);
			super.new(name,parent);
		endfunction

		virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
			`uvm_info("APB_MON_R","Inside Build phase",UVM_HIGH)
		send_r = new("send_r",this);
		if(!uvm_config_db #(virtual apb_if)::get(this,"","a_vif",a_vif))begin
				  `uvm_fatal("APB_MON_R","Cant get vif")
				  end
		else begin
				  `uvm_info("APB_MON_R","Get vif successfully",UVM_HIGH)
				  end
		
		endfunction
		
	endclass: apb_monitor_r


