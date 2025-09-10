class agent_config extends uvm_object;
//    `uvm_object_utils(agent_config)
    
virtual apb_if vif;
uvm_active_passive_enum is_active = UVM_ACTIVE;

function new(string name = "agent_config");
    super.new(name);
endfunction
    `uvm_object_param_utils_begin(agent_config)
`uvm_field_enum(uvm_active_passive_enum, is_active,UVM_ALL_ON)
    `uvm_object_utils_end
    
endclass

