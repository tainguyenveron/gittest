class addr_align extends base_seq;

  `uvm_object_utils(addr_align)

  // Constructor
  function new(string name = "addr_align");
    super.new(name);
  endfunction
 
 virtual task body();
     rst_dut();
   	//Align/Unalign addr, expected 8 addr error
        write_seq(32'h0000_0000, 32'hFFFF_FFFF, 4'b1111);
        write_seq(32'h0000_0002, 32'h0000_0000, 4'b1111);
        read_seq(32'h0000_0000, read_data);
        read_seq(32'h0000_0002, read_data);
        write_seq(32'h0000_0004, 32'hFFFF_FFFF, 4'b1111);
        write_seq(32'h0000_0006, 32'h0000_0000, 4'b1111);
        read_seq(32'h0000_0004, read_data);
        read_seq(32'h0000_0006, read_data);
        write_seq(32'h0000_0008, 32'hFFFF_FFFF, 4'b1111);
        write_seq(32'h0000_000A, 32'h0000_0000, 4'b1111);
        read_seq(32'h0000_0008, read_data);
        read_seq(32'h0000_000A, read_data);
        write_seq(32'h0000_000C, 32'hFFFF_FFFF, 4'b1111);
        write_seq(32'h0000_000E, 32'h0000_0000, 4'b1111);
        read_seq(32'h0000_000C, read_data);
        read_seq(32'h0000_000E, read_data);
	
endtask
endclass
