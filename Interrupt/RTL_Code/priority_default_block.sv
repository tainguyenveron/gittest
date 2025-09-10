module priority_default_block(
	input  logic  [239:0] priority_selected,
	output logic  [0:239] interrupt_accepted
);

  // Bitscan function
  assign interrupt_accepted = priority_selected & ~(priority_selected - 240'd1); 

endmodule

