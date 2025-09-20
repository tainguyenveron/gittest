module interrupt_request_output(
    // Input declaration
    input logic         clk                  ,
    input logic [2:0]   EXR                  ,
    input logic [2:0]   max_priority         ,
    input logic [0:239] interrupt_accepted   ,
    input logic         NMI_req              ,
    input logic         INTM0                ,
    input logic         INTM1                ,
    input logic         rst_n                ,
    // Output declaration
    output logic         interrupt_request
);
    // Interim logics
    logic res_comp;
    logic res_mux;
    logic res_dff;
    logic res_and;
    logic combined_request;

    assign res_comp = EXR < max_priority;
    assign res_mux  = INTM1 ? res_comp : 1'b1;
    assign combined_request = |interrupt_accepted;

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
	    res_dff <= 1'b0;
	end else if (res_mux) begin
	    res_dff <= combined_request;
        end else begin
	    res_dff <= res_dff;
        end
    end

    assign res_and = res_dff & ~INTM0;
    assign interrupt_request = res_and | NMI_req;

endmodule : interrupt_request_output

