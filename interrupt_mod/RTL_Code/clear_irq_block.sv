module clear_irq_block 
 (
  input  logic       datain                      ,
  input  logic       wren_ISR                    , 
  input  logic       interrupt_exception_handling,  
  input  logic [1:0] ISCR_dataout                ,   
  input  logic       IRQn                         ,
  input  logic       Disel			 ,
  input  logic       DTC_activate                ,
  output logic       IRQn_clr
 );
 
  logic temp_and_1;
  logic temp_and_2;
  logic temp_and_3;
  logic temp_and_4;
  logic temp_or_1;
  logic temp_or_2;

  assign temp_and_1    = !datain & wren_ISR;
  assign temp_and_2    = interrupt_exception_handling & ~|ISCR_dataout & !IRQn; 
  assign temp_and_3    = interrupt_exception_handling &  |ISCR_dataout &  IRQn; 
  assign temp_and_4    = Disel  &  DTC_activate;
  assign temp_or_1     = temp_and_1 | temp_and_2;
  assign temp_or_2     = temp_and_3 | temp_and_4;
  assign IRQn_clr      = temp_or_1 | temp_or_2;

endmodule : clear_irq_block


