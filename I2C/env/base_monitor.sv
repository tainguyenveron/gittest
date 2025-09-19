class base_monitor_w extends uvm_monitor;
	`uvm_component_utils(base_monitor_w)

		function new(string name = "base_monitor", uvm_component parent =null);
			super.new(name,parent);
		endfunction
		
		uvm_analysis_port#(base_item) send_w;
		base_item item;
		virtual apb_if vif;

		virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		item = base_item::type_id::create("item");
		`uvm_info("BASE_MONW","INSIDE RUN PHASE",UVM_HIGH)
		send_w = new("send_w", this);
			if(!uvm_config_db#(virtual apb_if)::get(this,"","vif",vif))
			`uvm_error("base_monitor","Unable to access interface!");
		endfunction
		
		virtual task run_phase(uvm_phase phase);
		`uvm_info("BASE_MONW","INSIDE RUN PHASE",UVM_HIGH)
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
					send_w.write(item);
				end
			end
		endtask
endclass: base_monitor_w

class base_monitor_r extends uvm_monitor;
	`uvm_component_utils(base_monitor_r)

		function new(string name = "base_monitor_r", uvm_component parent =null);
			super.new(name,parent);
		endfunction

		uvm_analysis_port#(base_item) send_r;
		base_item item;
		virtual apb_if vif;

		virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		item = base_item::type_id::create("item");
		`uvm_info("BASE_MONR","INSIDE BUILD PHASE",UVM_HIGH)
		send_r = new("send_r", this);
			if(!uvm_config_db#(virtual apb_if)::get(this,"","vif",vif))
			`uvm_error("base_monitor","Unable to access interface!");
		endfunction
		
		virtual task run_phase(uvm_phase phase);
		`uvm_info("BASE_MONR","INSIDE RUN PHASE",UVM_HIGH)
			forever begin	
				@(posedge vif.pclk);
				if(!vif.presetn) begin
					item.op	= RESET;
					`uvm_info("base_monitor", "SYSTEM RESET DETECTED", UVM_NONE);
					send_r.write(item);
				end
				else if(vif.presetn && !vif.pwrite) begin
					@(negedge vif.pready);
					item.op 	= READ;
					item.PADDR	= vif.paddr;
					item.PRDATA	= vif.prdata;
					item.PSLVERR	= vif.pslverr;
					send_r.write(item);
				end
			end
		endtask
endclass: base_monitor_r


