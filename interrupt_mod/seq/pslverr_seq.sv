class pslverr_seq extends base_seq;

    `uvm_object_utils(pslverr_seq)

    function new(string name="pslverr_seq");
        super.new(name);
    endfunction
    bit [31:0] read_data;
    bit [31:0] write_data;
    bit [3:0]  write_strb;

    task body();
//        `uvm_info(get_type_name(), "Starting PSL Error Sequence", UVM_LOW)
//        // Implement PSL error sequence logic here
//        rst_dut();
//
//        for(int i = 1; i < 32; i+=4) begin
//            write_data = $urandom;
//            write_strb = $urandom;
//
//            `uvm_info(get_type_name(), $sformatf("Writing data into address: %0h", i * 4), UVM_LOW)
//            write_seq(1 << i, write_data, write_strb);
//            read_seq(1 << i, read_data);
//        end
//
	rst_dut();
//Test 1- Out of bound addr 
    `uvm_info(get_type_name(), "Phase 4: Testing invalid addresses (expecting PSLVERR)", UVM_MEDIUM);
    
    // Test out-of-bounds addresses
    write_seq(32'h00000010, 32'h00000001, 4'hF); // Address 16 (invalid)
	read_seq(32'h0000_0010, read_data);
    write_seq(32'h00000020, 32'h00000001, 4'hF); // Address 32 (invalid)
	read_seq(32'h0000_0020, read_data);
    write_seq(32'h000000FF, 32'h00000001, 4'hF); // Address 255 (invalid)
	read_seq(32'h0000_0030, read_data);

//Test 2 - Unaligned addr
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
//Test 3 - Parity type error
        parity_error_test();
        read_seq(32'h0000_0008, read_data);//expected PSLVERR 
	
endtask	
endclass
