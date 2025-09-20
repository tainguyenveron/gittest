class base_agent extends uvm_agent;
`uvm_component_utils(base_agent)

abp_config cfg;
base_driver d;
base_monitor_w m_w;
base_monitor_r m_r;
uvm_sequencer#(base_item) seqr;

	function new(string name = "base_agent", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		cfg = abp_config::type_id::create("cfg");
		m_w = base_monitor_w::type_id::create("m_w",this);
		m_r = base_monitor_r::type_id::create("m_r",this);
		if(cfg.is_active == UVM_ACTIVE) begin
		d = base_driver::type_id::create("d",this);
		seqr = uvm_sequencer#(base_item)::type_id::create("seqr",this);
		end
	endfunction

	virtual function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	if(cfg.is_active == UVM_ACTIVE) begin
		d.seq_item_port.connect(seqr.seq_item_export);
	end
	endfunction
endclass: base_agent
