`timescale 1ns/1ps
`include "uvm_macros.svh"
`include "apb_m_pkg.sv"
`include "apb_m_interface.sv"
module testbench;

    import uvm_pkg::*;
    import apb_m_pkg::*;

    logic PCLK				      ;    
    logic         DTC_activate                ;
    logic         Disel                       ;
    logic         interrupt_exception_handling;
  
    // Control bit from PC
    logic         I_bit                       ; 
    logic [2:0]   EXR                         ; 
  
    // Interrupt input signals
    logic         NMI                         ;
    logic [15:0]  IRQn_A                      ;
    logic [15:0]  IRQn_B                      ;
    logic         SWDTEND                     ;
    logic         WOVI                        ;
    logic         CMI                         ;
    logic [1:0]   AD_0                        ;
    logic [7:0]   TPU_0                       ; 
    logic [3:0]   TPU_1                       ;
    logic [3:0]   TPU_2                       ;
    logic [7:0]   TPU_3                       ;
    logic [3:0]   TPU_4                       ;
    logic [3:0]   TPU_5                       ;
    logic [3:0]   TMR_0                       ;
    logic [3:0]   TMR_1                       ;
    logic [3:0]   DMAC                        ;
    logic [3:0]   EXDMAC                      ;
    logic [3:0]   SCI_0                       ;
    logic [3:0]   SCI_1                       ;
    logic [3:0]   SCI_2                       ;
    logic [3:0]   SCI_3                       ;
    logic [7:0]   SCI_4                       ;
    logic [3:0]   AD_1                        ;
    logic [1:0]   IIC2_0                      ;
    logic [1:0]   IIC2_1                      ;
    logic [4:0]   TPU_6                       ;
    logic [3:0]   TPU_7                       ;
    logic [3:0]   TPU_8                       ;
    logic [4:0]   TPU_9                       ;
    logic [3:0]   TPU_10                      ;
    logic [3:0]   TPU_11                      ;
    logic         IIC2_2                      ;
    logic         IIC2_3                      ;
    logic [2:0]   SSU                         ;
    logic [107:0] reserved                    ;
    logic        interrupt_request	      ;
    logic [7:0]  vector_number		      ;    


    initial begin
        $display("Clock generation started at time %0t", $time);
        PCLK = 1'b0;
        // #1;
        $display("Clock initialized to %b at time %0t", PCLK, $time);
        forever begin
            #5;
            PCLK = ~PCLK;
        end
    end

    apb_if #(.ADDR_WIDTH(32), .DATA_WIDTH(32)) apb_if_inst(.PCLK(PCLK));

    // Initialize interface signals
    initial begin
        apb_if_inst.PRESETn = 1'b1; // Start with reset deasserted
        #1; // Small delay to ensure proper initialization
    end

  interrupt_top #(
    .ADDR_WIDTH  (32),
    .DATA_WIDTH  (32),
    .STRB_WIDTH  (4),
    .PARITY_WIDTH(4),
    .UPPER_DEPTH (32'h0009_FFFF),
    .LOWER_DEPTH (32'h0009_0000),
    .WAIT_CYCLE  (0) 
  ) dut (
    .PCLK                      (PCLK), 
    .PRESETn                   (apb_if_inst.PRESETn),
    .PSEL                      (apb_if_inst.PSEL),
    .PENABLE                   (apb_if_inst.PENABLE),
    .PWRITE                    (apb_if_inst.PWRITE),
    .PADDR                     (apb_if_inst.PADDR),
    .PWDATA                    (apb_if_inst.PWDATA),
    .PSTRB                      (apb_if_inst.PSTRB),
    .PSTRBCHK                  (apb_if_inst.PSTRBCHK), 
    .PADDRCHK                  (apb_if_inst.PADDRCHK),
    .PWDATACHK                 (apb_if_inst.PWDATACHK),
    .PREADY                    (apb_if_inst.PREADY),
    .PSLVERR                   (apb_if_inst.PSLVERR),
    .PRDATA                    (apb_if_inst.PRDATA),
    .PRDATACHK                 (apb_if_inst.PRDATACHK),
    .*
 );
    initial begin
        uvm_config_db #(virtual apb_if)::set(null, "uvm_test_top", "vif", apb_if_inst);
        $display("Testbench: Starting UVM test at time %0t", $time);
        run_test();
    end
    
    
    
    // // Simulation timeout
    // initial begin
    //     #5000;
    //     $display("Testbench: Simulation timeout at time %0t", $time);
    //     $finish();
    // end

endmodule
