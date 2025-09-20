class initial_test extends uvm_test; 
  
    `uvm_component_utils(initial_test) 
    virtual apb_if vif;
    apb_m_env env;
    env_config e_cfg;
    initial_value ini;
    function new (string name = "initial_test", uvm_component parent);
    
        super.new(name, parent);
        `uvm_info("TEST", "Constructor", UVM_NONE);
    
    endfunction
  

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("TEST","BUILD PHASE",UVM_NONE) 
        env = apb_m_env::type_id::create("env", this);
        e_cfg = env_config::type_id::create("e_cfg");
        
        //User - Define
        e_cfg.cfg.is_active = UVM_ACTIVE;
        e_cfg.has_scb = 1;
        `uvm_info("TEST","CONFIGURATION",UVM_NONE) 
        e_cfg.print();

        //Get vif from tb top
        if(!uvm_config_db #(virtual apb_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("TEST", "CANT GET VIF");
        end
        else
            `uvm_info("TEST","GOT VIF",UVM_NONE)

        //Pass env_config & vif to env
            `uvm_info("TEST","PASSING CFG & VIF to ENV",UVM_NONE)
        uvm_config_db #(env_config)::set(this, "env", "env_config", e_cfg);
        uvm_config_db #(virtual apb_if)::set(this, "env", "vif", vif);
        
    endfunction

    virtual function void end_of_elaboration();
        `uvm_info("TEST", "topology", UVM_NONE);
        print();
    endfunction


    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name(), "run phase", UVM_MEDIUM);

        phase.raise_objection(this, "Starting reset sequence");
        
        ini = initial_value::type_id::create("ini");

        ini.start(env.agent.sequencer);
        
        phase.drop_objection(this, "Reset sequence completed");
        
        `uvm_info(get_type_name(), "Test completed", UVM_MEDIUM);
    endtask

endclass

