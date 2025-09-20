module IRQ_function(
    input  logic clk,
    input  logic rst_n,
    input  logic [1:0] ISCR_dataout,
    input  logic ITSR_dataout,
    input  logic IRQA,
    input  logic IRQB,
    input  logic interrupt_exception_handling,
    input  logic wren_ISR,
    input  logic datain,
    input  logic Disel,
    input  logic DTC_activate,
    output logic mux_out,
    output logic IRQn_clr
);
    logic IRQn;
    logic negedge_signal;
    logic posedge_signal;
    logic low_level_signal;

    assign IRQn = ITSR_dataout ? ~IRQA : ~IRQB;
    
    negedge_detector negedge_detector_1 (
                     .clk(clk),
                     .rst_n(rst_n),
                     .in_neg_sig(IRQn),
        	     .negedge_signal(negedge_signal)		     
            );
            
    posedge_detector posedge_detector_1 (
                     .clk(clk),
                     .rst_n(rst_n),
                     .in_pos_sig(IRQn),
        	     .posedge_signal(posedge_signal)		     
            );
    
    low_level_detector low_level_detector_1 (
                     .clk(clk),
        	     .rst_n(rst_n),
        	     .in_low_level(IRQn),
        	     .low_level_signal(low_level_signal)
            );
    
    always_comb begin
        case(ISCR_dataout)
            2'b00: mux_out = low_level_signal;
    	    2'b01: mux_out = negedge_signal;
    	    2'b10: mux_out = posedge_signal;
    	    2'b11: mux_out = negedge_signal | posedge_signal;
    	    default: mux_out = 1'b0;
        endcase	    
    end
    
    clear_irq_block clear_irq_block_1 (
                     .datain(datain),
        	     .wren_ISR(wren_ISR),
        	     .interrupt_exception_handling(interrupt_exception_handling),
        	     .ISCR_dataout(ISCR_dataout),
                     .IRQn(IRQn),
        	     .Disel(Disel),
        	     .DTC_activate(DTC_activate),
        	     .IRQn_clr(IRQn_clr)
            );
endmodule : IRQ_function
