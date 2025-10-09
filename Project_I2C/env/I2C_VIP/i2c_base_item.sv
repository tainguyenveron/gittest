class i2c_base_item extends uvm_sequence_item;
	bit start_bit;
	rand bit [6:0] addr_7;
	bit wr;
	bit ack;
	bit nack;
	rand bit [7:0] data;
	bit stop_bit;

	`uvm_object_utils_begin(i2c_base_item)
	`uvm_field_int (start_bit,UVM_ALL_ON)
	`uvm_field_int (addr_7,UVM_ALL_ON)
	`uvm_field_int (wr,UVM_ALL_ON)
	`uvm_field_int (ack,UVM_ALL_ON)
	`uvm_field_int (nack,UVM_ALL_ON)
	`uvm_field_int (data,UVM_ALL_ON)
	`uvm_field_int (stop_bit,UVM_ALL_ON)
	`uvm_object_utils_end

	function new(string name = "i2c_base_item");
		super.new(name);
	endfunction

endclass:i2c_base_item
