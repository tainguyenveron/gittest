class sequence_write extends uvm_sequence#(base_item);
	`uvm_object_utils(sequence_write)
base_item item;
	function new(string name = " sequence_write");
		super.new(name);
	endfunction
	
	virtual task body();
		repeat(10) begin
			item = base_item::type_id::create("item");
			item.addr_c.constraint_mode(1);
			start_item(item);
			assert(item.randomize);
			item.op = WRITE;
			finish_item(item);
			
		end
	endtask
endclass: sequence_write
