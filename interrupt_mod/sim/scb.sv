class apb_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(apb_scoreboard)

    uvm_analysis_imp #(apb_transaction, apb_scoreboard) analysis_port;
    apb_transaction read_q[$], write_q[$];
    int write_count, read_count = 0;

    // Map địa chỉ hợp lệ
    logic [31:0] default_map [bit[31:0]];

    // Define địa chỉ hợp lệ
    localparam bit [31:0] BASE_ADDR = 32'h0009_0000;
    localparam bit [31:0] END_ADDR  = 32'h0009_004C;

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

    // Write từ monitor vào scoreboard
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
                default_map[tr.PADDR] = tr.PWDATA;
            end
            else begin
                `uvm_warning(get_type_name(),
                    $sformatf("Out-of-range WRITE addr=0x%h (ignored)", tr.PADDR));
            end

        end
        else begin
            // Read transaction
            read_count++;
            `uvm_info(get_type_name(),
                $sformatf("READ: addr=0x%h, data=0x%h, read_count=%0d",
                          tr.PADDR, tr.PRDATA, read_count),
                UVM_MEDIUM);

            if (tr.PADDR inside {[BASE_ADDR:END_ADDR]}) begin
                if (default_map.exists(tr.PADDR)) begin
                    if (default_map[tr.PADDR] !== tr.PRDATA) begin
                        `uvm_error(get_type_name(),
                            $sformatf("Mismatch: addr=0x%h expected=0x%h got=0x%h",
                                      tr.PADDR, default_map[tr.PADDR], tr.PRDATA));
                    end
                end
                else begin
                    // Nếu chưa từng ghi thì gán bằng PRDATA (giá trị mặc định từ DUT)
                    default_map[tr.PADDR] = tr.PRDATA;
                end
            end
            else begin
                `uvm_warning(get_type_name(),
                    $sformatf("Out-of-range READ addr=0x%h (ignored)", tr.PADDR));
            end
        end

        // Check PSLVERR
        if (tr.PSLVERR) begin
            `uvm_error(get_type_name(),
                $sformatf("PSLVERR ERROR addr=0x%h", tr.PADDR));
        end
    endfunction

    task run_phase(uvm_phase phase);
        // có thể thêm logic nếu cần
    endtask

    // Report function
    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info(get_type_name(), "=== SCOREBOARD SUMMARY ===", UVM_LOW);
        `uvm_info(get_type_name(),
                  $sformatf("Total Writes: %0d", write_count), UVM_LOW);
        `uvm_info(get_type_name(),
                  $sformatf("Total Reads : %0d", read_count), UVM_LOW);
    endfunction

endclass

