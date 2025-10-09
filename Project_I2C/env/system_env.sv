import apb_pkg::*;
class system_env extends uvm_env;
	`uvm_component_utils(system_env)

	i2c_agent agent;
	apb_agent a_agent;
	i2c_scoreboard scoreboard;
	apb_scoreboard a_scoreboard;
	function new(string name = "system_env", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agent = i2c_agent::type_id::create("agent",this);
		a_agent = apb_agent::type_id::create("a_agent",this);
		scoreboard = i2c_scoreboard::type_id::create("scoreboard",this);
		a_scoreboard = apb_scoreboard::type_id::create("apb_scoreboard",this);
		`uvm_info("ENV","Inside Build phase",UVM_HIGH) 
	endfunction

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		agent.monitor.mon_port.connect(scoreboard.scb_port);
		a_agent.a_mon_w.send_w.connect(a_scoreboard.PW);
		a_agent.a_mon_r.send_r.connect(a_scoreboard.PR);
		`uvm_info("ENV","Inside Connect phase",UVM_HIGH)
	endfunction
endclass
