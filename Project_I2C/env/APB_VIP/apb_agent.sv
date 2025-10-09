class apb_agent extends uvm_agent;
`uvm_component_utils(apb_agent)
	apb_driver a_driver;
	apb_sequencer a_sequencer;
	apb_monitor_w a_mon_w;
	apb_monitor_r a_mon_r;

	function new(string name = "apb_agent", uvm_component parent);
		super.new(name,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("APB_AGENT","Inside Build Phase",UVM_HIGH)
		a_driver = apb_driver::type_id::create("a_driver",this);
		a_sequencer = apb_sequencer::type_id::create("a_sequencer",this);
		a_mon_w = apb_monitor_w::type_id::create("a_mon_w",this);
		a_mon_r = apb_monitor_r::type_id::create("a_mon_r",this);
	endfunction

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		a_driver.seq_item_port.connect(a_sequencer.seq_item_export);
	endfunction
endclass
