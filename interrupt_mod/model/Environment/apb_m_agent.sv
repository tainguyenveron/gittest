class apb_m_agent extends uvm_agent;
    `uvm_component_utils(apb_m_agent)

    virtual apb_if vif;
    agent_config cfg;
    // Components
    apb_m_sequencer sequencer;
    apb_m_driver driver;
    apb_m_monitor monitor;

    // Constructor
    function new(string name = "apb_m_agent", uvm_component parent);
        super.new(name, parent);
        `uvm_info("AGNT", "Constructor", UVM_NONE);
    endfunction

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        //Always create monitor
        monitor = apb_m_monitor::type_id::create("monitor", this);
        
        //Get agent cfg
        if (!uvm_config_db #(agent_config)::get(this, "", "agent_config", cfg)) begin
            `uvm_fatal("AGNT", "CANT GET AGENT CFG")
        end
        else 
            `uvm_info("AGNT", "GOT AGENT CFG",UVM_NONE)
        //Debug cfg is null
        //if (cfg != null)
        //`uvm_info("CFG exists","CFG # NULL",UVM_MEDIUM)
        //else
        //`uvm_fatal("No CFG", "CFG NULL")

        //Build config by agent config
        if(cfg.is_active == UVM_ACTIVE) begin
            `uvm_info("AGNT", "UVM_ACTIVE",UVM_NONE)
            driver = apb_m_driver::type_id::create("driver", this);
            sequencer = apb_m_sequencer::type_id::create("sequencer", this);
        end
        else
            `uvm_info("AGNT", "UVM_PASSIVE",UVM_NONE)

        //Get virtual inf from env 
        if(!uvm_config_db #(virtual apb_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("AGNT", "CANT GET VIF");
        end
        else
            `uvm_info("AGNT", "GOT VIF",UVM_NONE) 

        //Pass virtual inf to all comp inside agent 
        uvm_config_db #(virtual apb_if)::set(this, "*", "vif", vif);
        
        //Pass agent config to all comp inside agent
        uvm_config_db #(agent_config)::set(this, "*", "agent_config", cfg);
        `uvm_info("AGNT", "BUILD PHASE", UVM_NONE);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_type_name(), "Connect phase", UVM_NONE);
        if(cfg.is_active == UVM_ACTIVE) begin
        driver.seq_item_port.connect(sequencer.seq_item_export);
        `uvm_info("AGENT", "CONNECT DRIVE & SEQR", UVM_NONE);
        end
    endfunction
endclass
