class apb_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(apb_scoreboard)
    uvm_analysis_imp #(apb_transaction, apb_scoreboard) analysis_port;
	apb_transaction read_q[$], write_q[$], item_r;
	int write_count,read_count = 0;
    // Constructor
    function new(string name = "apb_scoreboard", uvm_component parent);
        super.new(name, parent);
        analysis_port = new("analysis_port", this);
        `uvm_info(get_type_name(), "Constructor", UVM_MEDIUM);
    endfunction

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "Build phase", UVM_MEDIUM);
    endfunction

    function void write(apb_transaction tr);
	if(!tr.PRESETn)begin
	`uvm_info(get_type_name(), "RESET DETECTED",UVM_LOW)
	end

       else if(tr.PWRITE) begin
            // Write transaction
	write_count++;
            `uvm_info(get_type_name(), $sformatf("addr=0x%h, data=0x%h, strb=0x%h, write_count:%0d", tr.PADDR, tr.PWDATA, tr.PSTRB, write_count), UVM_MEDIUM);
	write_q.push_back(tr); 


       end else begin
            // Read transaction
	read_count++;
            `uvm_info(get_type_name(), $sformatf("addr=0x%h, data=0x%h, read_count:%0d",tr.PADDR, tr.PRDATA, read_count), UVM_MEDIUM);
	read_q.push_back(tr);
       end 
        // Check for slave error (PSLVERR) assertion behavior
        if (tr.PSLVERR) begin
             `uvm_error(get_type_name(), $sformatf("PSLVERR ERROR addr=0x%h",  tr.PADDR));
	end
   endfunction
		
	task run_phase(uvm_phase phase);
		wait(read_q.size() >= 20)
		`uvm_info("SCB",$sformatf("read size: %0d, write size: %0d",read_q.size(),write_q.size()),UVM_LOW)
		for(int i=0; i < 20; i++)begin
		item_r = read_q.pop_front();
	        `uvm_info(get_type_name(), $sformatf("addr=0x%h, data=0x%h",item_r.PADDR, item_r.PRDATA), UVM_MEDIUM);
		end
	endtask

    // Report function for end of test
    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info(get_type_name(), "=== SCOREBOARD SUMMARY ===", UVM_LOW);
        `uvm_info(get_type_name(), $sformatf("Total Writes: %0d", write_count), UVM_LOW);
        `uvm_info(get_type_name(), $sformatf("Total Reads: %0d", read_count), UVM_LOW);
    endfunction
   
endclass




