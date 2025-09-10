module parity_check_ODD #(
    parameter DATA_WIDTH   = 32,
    parameter PARITY_WIDTH =  4 
)(
    //Input declaration
    input  logic                    i_clk,
    input  logic                    i_rst_n,
    input  logic                    i_en,
    input  logic [DATA_WIDTH-1:0]   i_data,
    //Output declaration
    output logic [PARITY_WIDTH-1:0] o_data
);

localparam parity_internal_width = DATA_WIDTH/PARITY_WIDTH;
logic [PARITY_WIDTH-1:0] parity_check;
genvar i;

generate
  for (i = 0; i < PARITY_WIDTH; i = i+1) begin: parity_gen
    assign parity_check[i] = ~(^i_data[i*parity_internal_width +: parity_internal_width]);
  end
endgenerate

always_ff @(posedge i_clk or negedge i_rst_n) 
begin
    if(!i_rst_n) 
    begin
       o_data <= '0;
    end
    else if(i_en)
    begin
       o_data <= parity_check;
    end
    else;
end

endmodule: parity_check_ODD
