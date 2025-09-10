class apb_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(apb_scoreboard)

    uvm_analysis_imp #(apb_transaction, apb_scoreboard) analysis_port;
    apb_transaction read_q[$], write_q[$];
    int write_count, read_count = 0;
    int valid_write, valid_read = 0;
    logic [31:0] mask = 0;
    logic [31:0] default_map [bit[31:0]];

    // Define valid addr
    localparam bit [31:0] BASE_ADDR = 32'h0009_0000;
    localparam bit [31:0] END_ADDR  = 32'h0009_FFFF;

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

    // Write method
    function void write(apb_transaction tr);
        if (!tr.PRESETn) begin
            `uvm_info(get_type_name(), "RESET DETECTED", UVM_LOW)
        end
        else if (tr.PWRITE) begin
            // Write transaction
            write_count++;
            `uvm_info(get_type_name(),
                $sformatf("WRITE: addr=0x%h, data=0x%h, strb=0x%h, write_count=%0d",
                          tr.PADDR, tr.PWDATA, tr.PSTRB, write_count),
                UVM_MEDIUM);

            if (tr.PADDR inside {[BASE_ADDR:END_ADDR]}) begin
		case(tr.PADDR)
			32'h0009_0000: mask = tr.PWDATA & 32'h0000_0038;
			32'h0009_0004: mask = tr.PWDATA & 32'h0000_FFFF;
			32'h0009_0008: mask = tr.PWDATA & 32'h0000_FFFF;
			32'h0009_000C: mask = tr.PWDATA & 32'h0000_FFFF;
			32'h0009_0010: mask = tr.PWDATA & 32'h0000_FFFF;
			32'h0009_0014: mask = tr.PWDATA & 32'h0000_FFFF;
		default: mask = tr.PWDATA & 32'h0000_7777;
		endcase
                default_map[tr.PADDR] = mask;
            end
            else begin
                `uvm_error(get_type_name(),
                    $sformatf("Invalid range WRITE addr=0x%h (ignored)", tr.PADDR));
            end

        end
        else begin
            // Read transaction
            read_count++;
            `uvm_info(get_type_name(),
                $sformatf("READ: addr=0x%h, data=0x%h, read_count=%0d",
                          tr.PADDR, tr.PRDATA, read_count),
                UVM_MEDIUM);
	
	        // Check PSLVERR
        	if (tr.PSLVERR) begin
            	`uvm_error(get_type_name(),$sformatf("PSLVERR ERROR addr=0x%h", tr.PADDR));
        	end
		else 
		valid_read++;
		////////////////

            if (tr.PADDR inside {[BASE_ADDR:END_ADDR]} && (tr.PADDR % 4) == 0) begin
                if (default_map.exists(tr.PADDR)) begin
                    if (default_map[tr.PADDR] !== tr.PRDATA) begin
                        `uvm_error(get_type_name(),
                            $sformatf("Mismatch: addr=0x%h expected=0x%h got=0x%h",
                                      tr.PADDR, default_map[tr.PADDR], tr.PRDATA));
                    end
                end
                else begin
                    //Store default value if data hasnt write before
                    default_map[tr.PADDR] = tr.PRDATA;
                end
            end
            else begin
                `uvm_error(get_type_name(),
                    $sformatf("Invalid range READ addr=0x%h (ignored)", tr.PADDR));
            end
        end
    endfunction

    task run_phase(uvm_phase phase);
	bit [31:0] addr;	
	wait(valid_read == 20) begin
		for(addr = 32'h0009_0000; addr <= 32'h0009_004C; addr += 4)begin
			`uvm_info("SCB READ",$sformatf("Addr:0x%h Data:%h",addr,default_map[addr]),UVM_LOW)
		end
	end
    endtask

    // Report function
    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info(get_type_name(), "=== SCOREBOARD SUMMARY ===", UVM_LOW);
        `uvm_info(get_type_name(),$sformatf("Total Writes: %0d", write_count), UVM_LOW);
        `uvm_info(get_type_name(),$sformatf("Total Reads : %0d", read_count), UVM_LOW);
        `uvm_info(get_type_name(),$sformatf("Total valid read : %0d", valid_read), UVM_LOW);
    endfunction

endclass
