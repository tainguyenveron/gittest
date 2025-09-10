module interrupt_top #(	
    parameter ADDR_WIDTH   = 32,
    parameter DATA_WIDTH   = 32,
    parameter STRB_WIDTH   = DATA_WIDTH / 8,
    parameter PARITY_WIDTH = 4,
    parameter UPPER_DEPTH  = 32'h0009_FFFF,
    parameter LOWER_DEPTH  = 32'h0009_0000,
    parameter WAIT_CYCLE   = 2 
)(
  //---------------------------------------------------------//
  //                INPUT DECLARATION FIELD                  //
  //---------------------------------------------------------//
  //APB_slave interface
  //input
  input  logic                    PCLK                    ,    // APB clock signal
  input  logic                    PRESETn                 ,    // Active-low reset signal
  input  logic                    PSEL                    ,    // Slave select signal
  input  logic                    PENABLE                 ,    // Enable signal for APB transaction (n cycle)
  input  logic                    PWRITE                  ,    // Write enable signal (1: Write, 0: Read)
  input  logic [ADDR_WIDTH-1:0]   PADDR                   ,    // Address sent to slave
  input  logic [DATA_WIDTH-1:0]   PWDATA                  ,    // Data sent to slave for write
  input  logic [STRB_WIDTH-1:0]   PSTRB                   ,    // Write strobe bit from master for PWDATA
  input  logic                    PSTRBCHK                ,    // Parity bit from master for PSTRB
  input  logic [PARITY_WIDTH-1:0] PADDRCHK                ,    // Parity bit from master for PADDR
  input  logic [PARITY_WIDTH-1:0] PWDATACHK               ,    // Parity bit from master for PWDATA
   
  //// Output declaration
  output logic                    PREADY                  ,    // Slave ready signal
  output logic                    PSLVERR                 ,    // Slave error signal
  output logic [DATA_WIDTH-1:0]   PRDATA                  ,    // Read data from slave
  output logic [PARITY_WIDTH-1:0] PRDATACHK               ,     // Parity bit from slave for PRDATA

  // Register input signals
  input logic         DTC_activate,
  input logic         Disel,
  input logic         interrupt_exception_handling,

  // Control bit from PC
  input logic         I_bit ,
  input logic [2:0]   EXR   ,

  // Interrupt input signals
  input logic         NMI     ,
  input logic [15:0]  IRQn_A  ,
  input logic [15:0]  IRQn_B  ,
  input logic         SWDTEND ,
  input logic         WOVI    ,
  input logic         CMI     ,
  input logic [1:0]   AD_0    ,
  input logic [7:0]   TPU_0   , 
  input logic [3:0]   TPU_1   ,
  input logic [3:0]   TPU_2   ,
  input logic [7:0]   TPU_3   ,
  input logic [3:0]   TPU_4   ,
  input logic [3:0]   TPU_5   ,
  input logic [3:0]   TMR_0   ,
  input logic [3:0]   TMR_1   ,
  input logic [3:0]   DMAC    ,
  input logic [3:0]   EXDMAC  ,
  input logic [3:0]   SCI_0   ,
  input logic [3:0]   SCI_1   ,
  input logic [3:0]   SCI_2   ,
  input logic [3:0]   SCI_3   ,
  input logic [7:0]   SCI_4   ,
  input logic [3:0]   AD_1    ,
  input logic [1:0]   IIC2_0  ,
  input logic [1:0]   IIC2_1  ,
  input logic [4:0]   TPU_6   ,
  input logic [3:0]   TPU_7   ,
  input logic [3:0]   TPU_8   ,
  input logic [4:0]   TPU_9   ,
  input logic [3:0]   TPU_10  ,
  input logic [3:0]   TPU_11  ,
  input logic         IIC2_2  ,
  input logic         IIC2_3  ,
  input logic [2:0]   SSU     ,
  input logic [107:0] reserved,

  //---------------------------------------------------------//
  //               OUTPUTT DECLARATION FIELD                 //
  //---------------------------------------------------------//
  // Interrupt request to CPU
  output logic        interrupt_request,
  output logic [7:0]  vector_number    

  // Data from reg to bus  
);
    logic clk;
    logic rst_n;
    logic [31:0] datain;
    logic [31:0] data_out;
    logic [31:0] addr;
    logic [19:0] addr_dec;
    //Register INTCR
    logic [31:0] INTCR_dataout;

    //Register ISCRH
    logic [31:0] ISCRH_dataout;
    
    //Register ISCRL
    logic [31:0] ISCRL_dataout;
    
    //Register IER
    logic [31:0] IER_dataout;
    
    //Register IPRA-N
    logic [31:0] IPRA_dataout;
    logic [31:0] IPRB_dataout;
    logic [31:0] IPRC_dataout;
    logic [31:0] IPRD_dataout;
    logic [31:0] IPRE_dataout;
    logic [31:0] IPRF_dataout;
    logic [31:0] IPRG_dataout;
    logic [31:0] IPRH_dataout;
    logic [31:0] IPRI_dataout;
    logic [31:0] IPRJ_dataout;
    logic [31:0] IPRK_dataout;
    logic [31:0] IPRL_dataout;
    logic [31:0] IPRM_dataout;
    logic [31:0] IPRN_dataout;
    //Register ITSR
    logic [31:0] ITSR_dataout;

    //Register ISR
    logic [31:0] ISR_dataout;

    //NMI input unit
    logic	 NMI_req;

    //IRQ request
    logic [0:15] IRQ_req;


    enable_write enable_write_1 (
        .wren    (wren    ),
	.addr    (addr    ),
        .addr_dec(addr_dec)
    );

    interrupt_registers interrupt_reg (
        .clk(clk),
        .rst_n(rst_n),
        .addr_dec(addr_dec),
        .PWDATA(datain),
        .INTCR_dataout(INTCR_dataout), 
        .ISCRH_dataout(ISCRH_dataout),
        .ISCRL_dataout(ISCRL_dataout),
        .IER_dataout  (IER_dataout  ),
        .IPRA_dataout (IPRA_dataout ),
        .IPRB_dataout (IPRB_dataout ),
        .IPRC_dataout (IPRC_dataout ),
        .IPRD_dataout (IPRD_dataout ),
        .IPRE_dataout (IPRE_dataout ),
        .IPRF_dataout (IPRF_dataout ),
        .IPRG_dataout (IPRG_dataout ),
        .IPRH_dataout (IPRH_dataout ),
        .IPRI_dataout (IPRI_dataout ),
        .IPRJ_dataout (IPRJ_dataout ),
        .IPRK_dataout (IPRK_dataout ),
        .IPRL_dataout (IPRL_dataout ),
        .IPRM_dataout (IPRM_dataout ),
        .IPRN_dataout (IPRN_dataout ),
        .ITSR_dataout (ITSR_dataout ) 
	    );

    out_reg out_reg_1 (
	.PADDR(PADDR),
	.wren(wren),
        .INTCR_dataout(INTCR_dataout), 
        .ISCRH_dataout(ISCRH_dataout),
        .ISCRL_dataout(ISCRL_dataout),
        .IER_dataout  (IER_dataout  ),
        .ISR_dataout  (ISR_dataout  ),
	.IPRA_dataout (IPRA_dataout ),
        .IPRB_dataout (IPRB_dataout ),
        .IPRC_dataout (IPRC_dataout ),
        .IPRD_dataout (IPRD_dataout ),
        .IPRE_dataout (IPRE_dataout ),
        .IPRF_dataout (IPRF_dataout ),
        .IPRG_dataout (IPRG_dataout ),
        .IPRH_dataout (IPRH_dataout ),
        .IPRI_dataout (IPRI_dataout ),
        .IPRJ_dataout (IPRJ_dataout ),
        .IPRK_dataout (IPRK_dataout ),
        .IPRL_dataout (IPRL_dataout ),
        .IPRM_dataout (IPRM_dataout ),
        .IPRN_dataout (IPRN_dataout ),
        .ITSR_dataout (ITSR_dataout ),
        .data_out     (data_out     )	
	    );
    apb_slave #(
	.ADDR_WIDTH  (ADDR_WIDTH  ), 
        .DATA_WIDTH  (DATA_WIDTH  ), 
        .STRB_WIDTH  (STRB_WIDTH  ), 
        .PARITY_WIDTH(PARITY_WIDTH), 
        .UPPER_DEPTH (UPPER_DEPTH ), 
        .LOWER_DEPTH (LOWER_DEPTH ), 
        .WAIT_CYCLE  (WAIT_CYCLE  ) 
    ) apb_interface (
	.PCLK     (PCLK     ),   
        .PRESETn  (PRESETn  ),
        .PSEL     (PSEL     ),
        .PENABLE  (PENABLE  ),
        .PWRITE   (PWRITE   ),
        .PADDR    (PADDR    ),
        .PWDATA   (PWDATA   ),
        .PSTRB    (PSTRB    ),
        .PSTRBCHK (PSTRBCHK ),
        .PADDRCHK (PADDRCHK ),
        .PWDATACHK(PWDATACHK),
        .PREADY   (PREADY   ),
        .PSLVERR  (PSLVERR  ),
        .PRDATA   (PRDATA   ),
        .PRDATACHK(PRDATACHK),
        .PADDR_ip   (addr),
        .PCLK_ip    (clk),
        .PRESETn_ip (rst_n),
        .PWDATA_ip  (datain),
        .write_en_ip(wren),
        .PRDATA_ip  (data_out)             
    );

    IRQn_input_unit IRQn_unit (
        .clk                         (clk                                       ),
	.rst_n                       (rst_n                                     ),
	.IER_dataout                 (IER_dataout[15:0]                         ),
	.ISCR_dataout                ({ISCRH_dataout[15:0], ISCRL_dataout[15:0]}),
        .IRQA                        (IRQn_A                                    ),
	.IRQB                        (IRQn_B                                    ),
	.ITSR_dataout                (ITSR_dataout[15:0]                        ),
	.Disel                       (Disel                                     ),
	.DTC_activate                (DTC_activate                              ),
	.datain                      (datain[15:0]                              ),
	.wren_ISR                    (addr_dec[4]                               ),
	.interrupt_exception_handling(interrupt_exception_handling              ),
	.ISR_data                    (ISR_dataout                               ),
	.IRQ_req                     (IRQ_req                                   )
    );
    
    NMI_input_unit NMI_input_unit_1 (
        .clk    (clk             ),
	.rst_n  (rst_n           ),
	.NMI    (NMI             ),
	.NMIEG  (INTCR_dataout[3]),
	.NMI_req(NMI_req         )
    );
   
    priority_determination priority_determination_1 (
        .clk       (clk                ),
	.rst_n     (rst_n              ),
	.EXR       (EXR                ),
	.INTM0     (INTCR_dataout[4]   ),
	.INTM1     (INTCR_dataout[5]   ),
	.NMI_req   (NMI_req            ),
	.I_bit     (I_bit              ),
        .IPRA_14_12(IPRA_dataout[14:12]), 
	.IPRB_14_12(IPRB_dataout[14:12]), 
	.IPRC_14_12(IPRC_dataout[14:12]), 
	.IPRD_14_12(IPRD_dataout[14:12]), 
	.IPRE_14_12(IPRE_dataout[14:12]), 
	.IPRF_14_12(IPRF_dataout[14:12]),
        .IPRG_14_12(IPRG_dataout[14:12]), 
	.IPRH_14_12(IPRH_dataout[14:12]), 
	.IPRI_14_12(IPRI_dataout[14:12]), 
	.IPRJ_14_12(IPRJ_dataout[14:12]), 
	.IPRK_14_12(IPRK_dataout[14:12]), 
	.IPRL_14_12(IPRL_dataout[14:12]),
        .IPRM_14_12(IPRM_dataout[14:12]), 
	.IPRN_14_12(IPRN_dataout[14:12]),
        .IPRA_10_8 (IPRA_dataout[10:8] ), 
	.IPRB_10_8 (IPRB_dataout[10:8] ), 
	.IPRC_10_8 (IPRC_dataout[10:8] ), 
	.IPRD_10_8 (IPRD_dataout[10:8] ), 
	.IPRE_10_8 (IPRE_dataout[10:8] ), 
	.IPRF_10_8 (IPRF_dataout[10:8] ),
        .IPRG_10_8 (IPRG_dataout[10:8] ), 
	.IPRH_10_8 (IPRH_dataout[10:8] ), 
	.IPRI_10_8 (IPRI_dataout[10:8] ), 
	.IPRJ_10_8 (IPRJ_dataout[10:8] ), 
	.IPRK_10_8 (IPRK_dataout[10:8] ), 
	.IPRL_10_8 (IPRL_dataout[10:8] ),
        .IPRM_10_8 (IPRM_dataout[10:8] ), 
	.IPRN_10_8 (IPRN_dataout[10:8] ),
        .IPRA_6_4  (IPRA_dataout[6:4]  ), 
	.IPRB_6_4  (IPRB_dataout[6:4]  ), 
	.IPRC_6_4  (IPRC_dataout[6:4]  ), 
	.IPRD_6_4  (IPRD_dataout[6:4]  ), 
	.IPRE_6_4  (IPRE_dataout[6:4]  ), 
	.IPRF_6_4  (IPRF_dataout[6:4]  ),
        .IPRG_6_4  (IPRG_dataout[6:4]  ), 
	.IPRH_6_4  (IPRH_dataout[6:4]  ), 
	.IPRI_6_4  (IPRI_dataout[6:4]  ), 
	.IPRJ_6_4  (IPRJ_dataout[6:4]  ), 
	.IPRK_6_4  (IPRK_dataout[6:4]  ), 
	.IPRL_6_4  (IPRL_dataout[6:4]  ),
        .IPRM_6_4  (IPRM_dataout[6:4]  ), 
	.IPRN_6_4  (IPRN_dataout[6:4]  ), 
        .IPRA_2_0  (IPRA_dataout[2:0]  ), 
	.IPRB_2_0  (IPRB_dataout[2:0]  ), 
	.IPRC_2_0  (IPRC_dataout[2:0]  ), 
	.IPRD_2_0  (IPRD_dataout[2:0]  ), 
	.IPRE_2_0  (IPRE_dataout[2:0]  ), 
	.IPRF_2_0  (IPRF_dataout[2:0]  ),
        .IPRG_2_0  (IPRG_dataout[2:0]  ), 
	.IPRH_2_0  (IPRH_dataout[2:0]  ), 
	.IPRI_2_0  (IPRI_dataout[2:0]  ), 
	.IPRJ_2_0  (IPRJ_dataout[2:0]  ), 
	.IPRK_2_0  (IPRK_dataout[2:0]  ), 
	.IPRL_2_0  (IPRL_dataout[2:0]  ),
        .IPRM_2_0  (IPRM_dataout[2:0]  ), 
	.IPRN_2_0  (IPRN_dataout[2:0]  ),
        .SWDTEND   (SWDTEND            ),      
        .WOVI      (WOVI               ),
        .CMI       (CMI                ),
        .AD_0      (AD_0               ),
        .TPU_0     (TPU_0              ),
        .TPU_1     (TPU_1              ),
        .TPU_2     (TPU_2              ),
        .TPU_3     (TPU_3              ),
        .TPU_4     (TPU_4              ),
        .TPU_5     (TPU_5              ),
        .TMR_0     (TMR_0              ),
        .TMR_1     (TMR_1              ),
        .DMAC      (DMAC               ),
        .EXDMAC    (EXDMAC             ),
        .SCI_0     (SCI_0              ),
        .SCI_1     (SCI_1              ),
        .SCI_2     (SCI_2              ),
        .SCI_3     (SCI_3              ),
        .SCI_4     (SCI_4              ),
        .AD_1      (AD_1               ),
        .IIC2_0    (IIC2_0             ),
        .IIC2_1    (IIC2_1             ),
        .TPU_6     (TPU_6              ),
        .TPU_7     (TPU_7              ),
        .TPU_8     (TPU_8              ),
        .TPU_9     (TPU_9              ),
        .TPU_10    (TPU_10             ),
        .TPU_11    (TPU_11             ),
        .IIC2_2    (IIC2_2             ),
        .IIC2_3    (IIC2_3             ),
        .SSU       (SSU                ),
	.IRQ_req   (IRQ_req[0:15]      ),
	.reserved  (reserved[21:0]     ),
	.interrupt_request_signal(interrupt_request),
	.vector_number           (vector_number    )
    );


endmodule: interrupt_top

