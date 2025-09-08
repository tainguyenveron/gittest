class base_env extends uvm_env;
`uvm_component_utils(base_env)
	function new(string name = "base_env", uvm_component parent = null);
		super.new(name,parent);
	endfunction
base_agent a;
base_scoreboard sb;
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		a = base_agent::type_id::create("a",this);
		sb = base_scoreboard::type_id::create("sb",this);
	endfunction

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		a.m_w.send_w.connect(sb.PW);
		a.m_r.send_r.connect(sb.PR);
	endfunction
endclass: base_env
