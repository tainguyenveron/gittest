`uvm_analysis_imp_decl(_W)
`uvm_analysis_imp_decl(_R)

class base_scoreboard extends uvm_scoreboard;
`uvm_component_utils(base_scoreboard)
uvm_analysis_imp_W #(base_item, base_scoreboard) PW;
uvm_analysis_imp_R #(base_item, base_scoreboard) PR;
base_item read_q[$], write_q[$],item_w,item_r;

    virtual apb_if vif;

    bit   WPSLVERR, RPSLVERR, WRESET, RRESET;
    int compare_pass =0, compare_fail =0;

    function new(string name = "base_scoreboard", uvm_component parent = null);
		super.new(name,parent);
	endfunction


    virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		PW = new("PW", this);
        PR = new("PR", this);
		if(!uvm_config_db#(virtual apb_if)::get(this,"","vif",vif))
		`uvm_error("base_scoreboard","Unable to access interface!");
    endfunction

    virtual function void write_W(base_item item);
        write_q.push_back(item.clone());
        WPSLVERR = item.PSLVERR;
        if(item.op == RESET)begin 
            WRESET = 1;
        end
        `uvm_info("SCB WRITE PORT","WRITE PKT",UVM_LOW)
        item.print();
    endfunction

    virtual function void write_R(base_item item);
        read_q.push_back(item);
        RPSLVERR = item.PSLVERR;
        if(item.op == RESET)begin
            RRESET = 1;
        end
        `uvm_info("SCB READ PORT","READ PKT",UVM_LOW)
        item.print();
    endfunction

    task run_phase(uvm_phase phase);
  forever begin
        @(posedge vif.pclk) begin 
        //$display("SCB_DEBUG time: %0t", $time);
        if(WRESET ||RRESET || WPSLVERR || RPSLVERR) begin
            if(WPSLVERR) begin
                `uvm_info("SB",$sformatf("We are in RUN PHASE: We got PSLVERR"),UVM_LOW) 
                item_w = write_q.pop_front(); end //when error is present we don't want to comapre read and write data
            if(RPSLVERR) begin
                `uvm_info("SB",$sformatf("We are in RUN PHASE: We got PSLVERR"),UVM_LOW) 
                item_r = read_q.pop_front(); end //when error is present we don't want to comapre read and write data
 
            if(WRESET) begin
                `uvm_info("SB",$sformatf("We are in RUN PHASE: We got RESET"),UVM_LOW) 
                item_w =  write_q.pop_front();
                WRESET = 0; 
                end
            if(RRESET) begin
                `uvm_info("SB",$sformatf("We are in RUN PHASE: We got RESET"),UVM_LOW) 
                item_r =  read_q.pop_front(); 
                RRESET = 0;
                end

        end
        else begin
        if(write_q.size() >0 && read_q.size() >0) begin
            `uvm_info("QUEUE DEBUG",$sformatf("write_q: %d, read_q: %d",write_q.size(),read_q.size()),UVM_LOW) 
            item_w = write_q.pop_front();
            //item_w.print();
            item_r = read_q.pop_front();
            //item_r.print();
            compare();
                end
            end
        end
    end
    endtask
  virtual function void compare();
        if(item_r.PRDATA == item_w.PWDATA) begin
            `uvm_info("compare","MATCHED", UVM_LOW);
            compare_pass++;
        end else begin
            `uvm_info("compare",$sformatf("UNMATCHED, PRDATA: %h but PWDATA: %h",item_r.PRDATA,item_w.PWDATA), UVM_LOW);
            `uvm_error("compare_error_status","error count")
            compare_fail++;
    end
  endfunction: compare 

     //Report Phase 
  	function void report_phase(uvm_phase phase);
   		super.report_phase(phase);
 
      if(compare_fail>0) 
		begin
     			`uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
          `uvm_info(get_type_name(), $sformatf("----       TEST FAIL COUNTS  %0d     ----",compare_fail), UVM_NONE)
     			`uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
    		end
      if(compare_pass>0)
		begin
     			`uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
          `uvm_info(get_type_name(), $sformatf("----       TEST PASS COUNTS  %0d     ----",compare_pass), UVM_NONE)
     			`uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
    		end
  	endfunction : report_phase  
endclass

