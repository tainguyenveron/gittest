
typedef enum bit [1:0] {READ = 0, WRITE = 1, RESET = 2} operation_mode;
class base_item extends uvm_sequence_item;
	rand logic PWRITE;
	rand logic [31:0] PWDATA;
	randc logic [4:0] PADDR;
	rand operation_mode op;
// Output 
	logic PREADY;
	logic PSLVERR;
	logic [31:0] PRDATA;

	`uvm_object_utils_begin(base_item)
	`uvm_field_int (PWRITE,UVM_ALL_ON)
	`uvm_field_int (PWDATA,UVM_ALL_ON)
	`uvm_field_int (PADDR,UVM_ALL_ON)
	`uvm_field_int (PREADY,UVM_ALL_ON)
	`uvm_field_int (PSLVERR,UVM_ALL_ON)
	`uvm_field_int (PRDATA,UVM_ALL_ON)
	`uvm_field_enum(operation_mode, op, UVM_DEFAULT)
	`uvm_object_utils_end

constraint addr_c { PADDR <= 31;}

	function new(string name = "base_item");
		super.new(name);
	endfunction

endclass: base_item
