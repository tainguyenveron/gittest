module low_level_detector(
	input  logic clk,
	input  logic rst_n,
	input  logic in_low_level,
	output logic low_level_signal
);

logic out_low_level_reg;

always_ff @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		out_low_level_reg <= 1'b0;
	end
	else begin
		out_low_level_reg <= in_low_level;
	end
end

assign low_level_signal = ~in_low_level & ~out_low_level_reg;

endmodule
