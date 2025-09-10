class env_config extends uvm_object;
//    `uvm_object_utils(env_config)
    agent_config cfg;
    bit has_scb;

function new(string name = "env_config");
    super.new(name);
    cfg = agent_config::type_id::create("cfg");
endfunction
    `uvm_object_param_utils_begin(env_config)
    `uvm_field_object(cfg,UVM_ALL_ON)
    `uvm_field_int(has_scb,UVM_ALL_ON)
    `uvm_object_utils_end

endclass
