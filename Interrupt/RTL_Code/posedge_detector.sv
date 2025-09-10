module posedge_detector(
	input  logic clk,
	input  logic rst_n,
	input  logic in_pos_sig,
	output logic posedge_signal
);

logic out_pos_sig_reg1;
logic out_pos_sig_reg2;

always_ff @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		out_pos_sig_reg1 <= 1'b0;
	end
	else begin
		out_pos_sig_reg1 <= in_pos_sig;
	end
end

always_ff @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		out_pos_sig_reg2 <= 1'b0;
	end
	else begin
		out_pos_sig_reg2 <= out_pos_sig_reg1;
	end
end

assign posedge_signal = out_pos_sig_reg1 & ~(out_pos_sig_reg2);

endmodule
