class base_driver extends uvm_driver #(base_item);
	`uvm_component_utils(base_driver)
	virtual apb_if vif;
	base_item item;
	
	function new(string name = "base_driver", uvm_component parent = null);
		super.new(name,parent);	
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		item = base_item::type_id::create("item");
		if(!uvm_config_db#(virtual apb_if)::get(this,"","vif",vif))
			`uvm_error("base_driver","Unable to access interface");
	endfunction
	
	task reset_dut();
		repeat(5) begin
		vif.presetn <= 1'b0;
		vif.paddr   <= 'h0;
		vif.pwdata  <= 'h0;
		vif.pwrite  <= 'b0;
		vif.psel    <= 'b0;
		vif.penable <= 'b0;
		`uvm_info("base_driver", "System Reset : Start of Simulation", UVM_MEDIUM);
		@(posedge vif.pclk);
		end	
	endtask

	task drive();
		reset_dut();
		forever begin
			seq_item_port.get_next_item(item);
				if(item.op == RESET) begin
					vif.presetn <= 1'b0;
					vif.paddr   <= 'h0;
					vif.pwdata  <= 'h0;
					vif.pwrite  <= 'b0;
					vif.psel    <= 'b0;
					vif.penable <= 'b0;
					@(posedge vif.pclk);
				end
				else if(item.op == WRITE) begin
					vif.psel 	<= 1'b1;
					vif.paddr	<= item.PADDR;
					vif.pwdata	<= item.PWDATA;
					vif.presetn	<= 1'b1;
					vif.pwrite	<= 1'b1;
					@(posedge vif.pclk);
					vif.penable	<= 1'b1;
	//	`uvm_info("base_driver", $sformatf("MODE : %s, addr: %h, wdata: %h, rdata:%h, slverr: %h", item.op, item.PADDR, item.PWDATA, item.PRDATA, item.PSLVERR),UVM_LOW);
					@(negedge vif.pready);
					vif.penable	<= 1'b0;
					item.PSLVERR	= vif.pslverr;
				end
				else if(item.op == READ) begin
					vif.psel	<= 1'b1;
					vif.paddr	<= item.PADDR;
					vif.presetn	<= 1'b1;
					vif.pwrite	<= 1'b0;
					@(posedge vif.pclk);
					vif.penable	<= 1'b1;
	//	`uvm_info("base_driver", $sformatf("MODE : %s, addr: %h, wdata: %h, rdata:%h, slverr: %h", item.op, item.PADDR, item.PWDATA, item.PRDATA, item.PSLVERR),UVM_LOW);
					@(negedge vif.pready);
					vif.penable	<= 1'b0;
					item.PRDATA	= vif.prdata;
					item.PSLVERR	= vif.pslverr;
	//	`uvm_info("base_driver", $sformatf("Nhat_debug : %s, addr: %h, wdata: %h, rdata:%h, slverr: %h", item.op, item.PADDR, item.PWDATA, item.PRDATA, item.PSLVERR),UVM_LOW);
				end
			seq_item_port.item_done();
				
		end
	endtask

	virtual task run_phase(uvm_phase phase);
		drive();
	endtask
endclass: base_driver
