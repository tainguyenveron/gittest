typedef enum bit [1:0] {READ = 0, WRITE = 1, RESET = 2} operation_mode;
class apb_base_item extends uvm_sequence_item;
	rand logic PWRITE;
	rand logic [31:0] PWDATA;
	rand logic [31:0] PADDR;
	logic	PREADY;
	logic PSLVERR;
	logic [31:0] PRDATA;
	rand operation_mode op;

	`uvm_object_utils_begin(apb_base_item)
	`uvm_field_int (PWRITE,UVM_ALL_ON)
	`uvm_field_int (PWDATA,UVM_ALL_ON)
	`uvm_field_int (PADDR,UVM_ALL_ON)
	`uvm_field_int (PREADY,UVM_ALL_ON)
	`uvm_field_int (PSLVERR,UVM_ALL_ON)
	`uvm_field_int (PRDATA,UVM_ALL_ON)
	`uvm_field_enum(operation_mode, op, UVM_DEFAULT)
	`uvm_object_utils_end

	function new(string name = "apb_base_item");
		super.new(name);
	endfunction

endclass
