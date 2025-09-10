module IRQn_input_unit(
  // Global signals
  input  logic clk                   ,
  input  logic rst_n                 ,
  input  logic [15:0] IER_dataout           ,
  input  logic [31:0] ISCR_dataout,
  input  logic [15:0] IRQA,
  input  logic [15:0] IRQB,
  input  logic [15:0] ITSR_dataout,
  input  logic Disel,
  input  logic DTC_activate,
  input  logic [15:0] datain,
  input  logic wren_ISR,
  input  logic interrupt_exception_handling,
 
  output logic [0:31] ISR_data,
  output logic [0:15] IRQ_req
);
    logic        IRQn_clr[0:15];
    logic	 mux_out [0:15];
    logic [0:31] ISR_datain;
    logic [0:31] ISR_clear;
    logic [0:15] mux_bus;
    logic        mux_sel [0:15];
    logic [0:31] IRQ_temp;
    logic [0:31] IRQ_data;
    assign ISR_datain[16:31] = 16'b0;
    assign ISR_clear[16:31]  = 16'b0;
    assign IRQ_data[16:31]   = 16'b0;
    
    genvar i;
    generate
        for(i = 0; i < 16; i++) begin : gen_IRQ_function
	    IRQ_function IRQ_function_1 (
		    .clk(clk),
		    .rst_n(rst_n),
		    .ISCR_dataout({ISCR_dataout[2*i+1], ISCR_dataout[2*i]}),
		    .ITSR_dataout(ITSR_dataout[i]),
		    .IRQA(IRQA[i]),
		    .IRQB(IRQB[i]),
		    .interrupt_exception_handling(interrup_exception_handling),
		    .wren_ISR(wren_ISR),
		    .datain(datain[i]),
		    .Disel(Disel),
		    .DTC_activate(DTC_activate),
		    .mux_out(mux_out[i]),
		    .IRQn_clr(IRQn_clr[i])
		    );
	end
    endgenerate

    generate
        for(i = 0; i < 16; i++) begin 
	    assign mux_bus[i]   = mux_out[i];
            assign ISR_clear[i] = IRQn_clr[i];
	end
    endgenerate

    assign ISR_datain[0:15] = mux_bus | IRQ_req[0:15];
    assign IRQ_data[0:15] = ISR_datain & ~ISR_clear;
    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
           IRQ_temp <= 32'b0;
        end else begin 
           IRQ_temp <= IRQ_data;
	end
    end
    assign IRQ_req  = IRQ_temp[0:15] & IER_dataout;
    assign ISR_data = IRQ_temp;
endmodule : IRQn_input_unit
