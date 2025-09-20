module negedge_detector(
	input  logic clk,
	input  logic rst_n,
	input  logic in_neg_sig,
	output logic negedge_signal
);

logic out_neg_sig_reg1;
logic out_neg_sig_reg2;

always_ff @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		out_neg_sig_reg1 <= 1'b0;
	end
	else begin
		out_neg_sig_reg1 <= in_neg_sig;
	end
end

always_ff @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		out_neg_sig_reg2 <= 1'b0;
	end
	else begin
		out_neg_sig_reg2 <= out_neg_sig_reg1;
	end
end

assign negedge_signal = ~out_neg_sig_reg1 & out_neg_sig_reg2;

endmodule
