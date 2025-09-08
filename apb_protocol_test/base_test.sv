
`ifndef GUARD_I2C_BASE_TEST_SV
`define GUARD_I2C_BASE_TEST_SV
`include "cust_svt_i2c_master_transaction.sv"
`include "cust_svt_i2c_slave_transaction.sv"
`include "cust_svt_i2c_system_configuration.sv"
`include "i2c_basic_env.sv"
`include "i2c_default_mst_sequence.sv"
`include "i2c_default_slv_sequence.sv"
`include "i2c_default_virtual_sequence.sv"
`include "i2c_simple_reset_sequence.sv"
`include "base_env.sv"


class base_test extends uvm_test;
`uvm_component_utils(base_test)
	function new(string name = "base_test", uvm_component parent = null);
		super.new(name,parent);
	endfunction
    i2c_basic_env env;
    base_env e;
   
//    writeb_readb wrb;
//    i2c_default_virtual_sequence def_seq;
    cust_svt_i2c_system_configuration cfg;

    virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
    /** replace blueprint of svt_i2c_master_transaction with cust_svt_i2c_master_transaction using factories in UVM */
    set_type_override_by_type(svt_i2c_master_transaction::get_type(),cust_svt_i2c_master_transaction::get_type());
    
    /** replace blueprint of svt_i2c_slave_transaction with cust_svt_i2c_slave_transaction using factories in UVM */
    set_type_override_by_type(svt_i2c_slave_transaction::get_type(),cust_svt_i2c_slave_transaction::get_type());

    /** Create the configuration object for Master agent */
    cfg = cust_svt_i2c_system_configuration::type_id::create("cfg");

    /** Configure Master and Slave configurations */
    cfg.set_bus_speed(STANDARD_MODE);                           // Set Bus-Speed
    cfg.master_cfg[0].master_code       = 3'b101             ;  // Set Master Code
    cfg.slave_cfg[0].slave_address      = 10'h333;  // Set Slave Address     
    cfg.slave_cfg[0].enable_10bit_addr  =  0                 ;  // disable 10-bit Addressing
 //   cfg.master_cfg[0].enable_10bit_addr  =  1                 ;  // disable 10-bit Addressing
    cfg.slave_cfg[0].slave_type         = `SVT_I2C_GENERIC       ;  // Set Slave as Generic 

    /** Set Master configuration in environment */
    uvm_config_db#(cust_svt_i2c_system_configuration)::set(this,"env", "i2c_system_cfg", cfg);

    /** Create the environment */
    env = i2c_basic_env::type_id::create("env", this);
    e = base_env::type_id::create("e",this);

    uvm_config_db#(uvm_object_wrapper)::set(this, "env.sequencer.reset_phase", "default_sequence", i2c_simple_reset_sequence::type_id::get());

    `uvm_info("build_phase", "i2c_base_test BUILD-FLOW: Finishing...",UVM_LOW)

	endfunction

    function void connect_phase(uvm_phase phase);
        `uvm_info("connect_phase","connect phase in base test",UVM_LOW)
//        env.i2c_system_env.master[0].monitor.xact_observed_port.connect(e.sb.item_collected_master);

    endfunction
/*	
    virtual task run_phase(uvm_phase phase);
		phase.raise_objection(this);
        //wrb.start(e.a.seqr);
        wrb = writeb_readb::type_id::create("wrb");
        def_seq = i2c_default_virtual_sequence::type_id::create("def_seq");
        fork
            wrb.start(env.e.a.seqr);
            def_seq.start(env.i2c_system_env.sequencer);
        join
        phase.drop_objection(this);
	endtask
*/
endclass: base_test
`endif
