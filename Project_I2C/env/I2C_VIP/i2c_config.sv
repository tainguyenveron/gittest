class i2c_config extends uvm_object; 
  `uvm_object_utils(i2c_config)
  
  function new(string name = "i2c_config");
    super.new(name);
  endfunction
  
  
  
  uvm_active_passive_enum is_active = UVM_ACTIVE;
  
 
endclass

