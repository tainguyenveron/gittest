class base_monitor_w extends uvm_monitor;
	`uvm_component_utils(base_monitor_w)
	uvm_analysis_port#(base_item) send_w;
	base_item item;
	virtual apb_if vif;
		function new(string name = "base_monitor", uvm_component parent =null);
			super.new(name,parent);
		endfunction
	
		virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		item = base_item::type_id::create("item");
		send_w = new("send_w", this);
			if(!uvm_config_db#(virtual apb_if)::get(this,"","vif",vif))
			`uvm_error("base_monitor","Unable to access interface!");
		endfunction
		
		virtual task run_phase(uvm_phase phase);
			forever begin	
				@(posedge vif.pclk);
				if(!vif.presetn) begin
					item.op	= RESET;
					`uvm_info("base_monitor", "SYSTEM RESET DETECTED", UVM_NONE);
					send_w.write(item);
				end
				else if(vif.presetn && vif.pwrite) begin
					@(negedge vif.pready);
					item.op 	= WRITE;
					item.PWDATA	= vif.pwdata;
					item.PADDR	= vif.paddr;
					item.PSLVERR	= vif.pslverr;
			//		`uvm_info("base_monitor", $sformatf("DATA WRITE add: %h data: %h slverr: %h", item.PADDR, item.PWDATA, item.PSLVERR),UVM_NONE);
					send_w.write(item);
				end
			end
		endtask
endclass: base_monitor_w

class base_monitor_r extends uvm_monitor;
	`uvm_component_utils(base_monitor_r)
	uvm_analysis_port#(base_item) send_r;
	base_item item;
	virtual apb_if vif;
		function new(string name = "base_monitor_r", uvm_component parent =null);
			super.new(name,parent);
		endfunction
	
		virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		item = base_item::type_id::create("item");
		send_r = new("send_r", this);
			if(!uvm_config_db#(virtual apb_if)::get(this,"","vif",vif))
			`uvm_error("base_monitor","Unable to access interface!");
		endfunction
		
		virtual task run_phase(uvm_phase phase);
			forever begin	
				@(posedge vif.pclk);
				if(!vif.presetn) begin
					item.op	= RESET;
					`uvm_info("base_monitor", "SYSTEM RESET DETECTED", UVM_NONE);
					send_r.write(item);
				end
				else if(vif.presetn && !vif.pwrite) begin
                    	`uvm_info("base_monitor","time",UVM_NONE);
					
					@(negedge vif.pready);
					item.op 	= READ;
					item.PADDR	= vif.paddr;
					item.PRDATA	= vif.prdata;
					item.PSLVERR	= vif.pslverr;
			//		`uvm_info("base_monitor", $sformatf("DATA READ add: %h data: %h slverr: %h", item.PADDR, item.PRDATA, item.PSLVERR),UVM_NONE);
					send_r.write(item);
				end
			end
		endtask
endclass: base_monitor_r


