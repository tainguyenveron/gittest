`uvm_analysis_imp_decl(_W)
`uvm_analysis_imp_decl(_R)

class apb_scoreboard extends uvm_scoreboard;
  	`uvm_component_utils(apb_scoreboard)

  	// Analysis implementation ports for write/read channels
  	uvm_analysis_imp_W #(apb_base_item, apb_scoreboard) PW;
  	uvm_analysis_imp_R #(apb_base_item, apb_scoreboard) PR;

  	// Queues for transactions coming from write/read monitors
  	apb_base_item read_q[$], write_q[$], item_w, item_r;

  	// Virtual interface to access DUT clock
  	virtual apb_if vif;

  	// Pass/Fail counters for comparison results
  	int compare_pass = 0, compare_fail = 0;

  	function new(string name = "apb_scoreboard", uvm_component parent = null);
    	super.new(name, parent);
  	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		PW = new("PW", this);
		PR = new("PR", this);
	endfunction

  //--- WRITE PORT ---
  // Called by the write monitor; pushes valid items into write_q.
  // If RESET or PSLVERR is received, clear/skip queue instead.
  	virtual function void write_W(apb_base_item item);
  	
	endfunction

  //--- READ PORT ---
  // Called by the read monitor; pushes valid items into read_q.
  // If RESET or PSLVERR is received, clear/skip queue instead.
  	virtual function void write_R(apb_base_item item);
  
  	endfunction
endclass


