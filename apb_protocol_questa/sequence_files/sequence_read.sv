class sequence_read extends uvm_sequence#(base_item);
  `uvm_object_utils(sequence_read)
  
  base_item item;

  function new(string name = "sequence_read");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(10)
      begin
        item = base_item::type_id::create("item");
        item.addr_c.constraint_mode(1);
        
        start_item(item);
        assert(item.randomize);
        item.op = READ;
        finish_item(item);
	
      end
  endtask
  

endclass: sequence_read

class read_after_write extends uvm_sequence#(base_item); //////read after write
  `uvm_object_utils(read_after_write)
  
  base_item item;

  function new(string name = "read_after_write");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(15)
      begin
        item = base_item::type_id::create("item");
        item.addr_c.constraint_mode(1);
        //item.addr_c_err.constraint_mode(0);
        
        start_item(item);
        assert(item.randomize);
        item.op = WRITE;
        finish_item(item);
        
        start_item(item);
        assert(item.randomize);
        item.op = READ;
        finish_item(item);

      end
  endtask
endclass: read_after_write

class writeb_readb extends uvm_sequence#(base_item); // write_read bulk same address
  `uvm_object_utils(writeb_readb)
  
  base_item item;
  int addr_queue[$]; 

	  function new(string name = "writeb_readb");
	    super.new(name);
	    
	  endfunction
	  
	  virtual task body();
	    item = base_item::type_id::create("item");
		    repeat(15) begin
			item.addr_c.constraint_mode(0);
			start_item(item);
			assert(item.randomize);
            item.op = WRITE;
			finish_item(item);
		    addr_queue.push_back(item.PADDR);
		    end
		      
		    foreach (addr_queue[i]) begin
			item.addr_c.constraint_mode(0);
			start_item(item);
			assert(item.randomize);
            item.PADDR = addr_queue[i];
			item.op = READ;
			finish_item(item);
		    end
	  endtask
  

endclass: writeb_readb

