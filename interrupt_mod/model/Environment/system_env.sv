class apb_m_env extends uvm_env;
    `uvm_component_utils(apb_m_env)

    virtual apb_if vif;
    apb_m_agent agent;
    apb_scoreboard scb;
    env_config e_cfg;

    function new(string name = "apb_m_env", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("ENV", "BUILD PHASE", UVM_NONE);
        
        // Create the agent
        agent = apb_m_agent::type_id::create("agent", this);
        if (!uvm_config_db #(virtual apb_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("ENV", "CANT GET VIF");
        end
        else
            `uvm_info("ENV", "GOT VIG",UVM_NONE)
        ///////////////////////////////////////

        if (!uvm_config_db #(env_config)::get(this, "", "env_config", e_cfg)) begin
            `uvm_fatal("ENV", "CANT GET ENV_CFG");
        end
        else
            `uvm_info("ENV","GOT ENV_CFG",UVM_NONE)
        ///////////////////////////////////////
        
            `uvm_info("ENV","PASSING CFG & VIF to AGNT",UVM_NONE)
        uvm_config_db #(agent_config)::set(this, "agent", "agent_config", e_cfg.cfg);
        uvm_config_db #(virtual apb_if)::set(this, "agent", "vif", vif);
        //////////////////////////////////////

        if(e_cfg.has_scb == 1) begin
            `uvm_info("ENV","SCB ENABLED",UVM_NONE)
        scb = apb_scoreboard::type_id::create("scb", this);
        end
        else
            `uvm_info("ENV","SCB DISABLED",UVM_NONE)
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("ENV", "Connect phase", UVM_NONE);
        if(e_cfg.has_scb == 1) begin
            `uvm_info("ENV","CONNECT MON & SCB PORT",UVM_NONE)
            agent.monitor.collected_port.connect(scb.analysis_port);
        end 
    endfunction
endclass
