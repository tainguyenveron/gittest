class addralign_test extends base_test;

  `uvm_component_utils(addralign_test)
  addr_align seq_align;
  // Constructor
  function new(string name = "addralign_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), "Building addralign_test test", UVM_MEDIUM);
  endfunction

  // Run phase - Execute the one-hot sequence
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    
    // Create and execute the one-hot sequence
    seq_align = addr_align::type_id::create("seq_align");
    
   seq_align.start(env.agent.sequencer);
    // Add some delay to ensure all transactions are processed
    #1us;
    
    phase.drop_objection(this);
  endtask


endclass
