`include "base_test.sv"
//`include "sequence_read.sv"
//`include "sequence_write.sv"
class top_test extends base_test;

  /** UVM component utility macro */
  `uvm_component_utils(top_test)
    writeb_readb wrb;
    i2c_default_virtual_sequence def_seq;

  /** Class constructor */
  function new(string name = "top_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
      super.build_phase(phase);
        wrb = writeb_readb::type_id::create("wrb");
        def_seq = i2c_default_virtual_sequence::type_id::create("def_seq");
  endfunction

   task run_phase(uvm_phase phase);
		phase.raise_objection(this);
        fork
            wrb.start(e.a.seqr);
            def_seq.start(env.i2c_system_env.sequencer);
        join
        phase.drop_objection(this);
	endtask

  function void end_of_elaboration_phase (uvm_phase phase);
    uvm_top.print_topology();
  endfunction
endclass

