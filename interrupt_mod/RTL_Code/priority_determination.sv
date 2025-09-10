module priority_determination(
  // Control input
  input  logic clk,
  input  logic [2:0] EXR,
  input  logic INTM0,
  input  logic INTM1,
  input  logic NMI_req,
  input  logic rst_n,
  input  logic I_bit,  
  // Group input 14:12	
  input  logic [2:0]  IPRA_14_12, IPRB_14_12, IPRC_14_12, IPRD_14_12, IPRE_14_12, IPRF_14_12,
  input  logic [2:0]  IPRG_14_12, IPRH_14_12, IPRI_14_12, IPRJ_14_12, IPRK_14_12, IPRL_14_12,
  input  logic [2:0]  IPRM_14_12, IPRN_14_12,
  // Group input 10:8
  input  logic [2:0]  IPRA_10_8 , IPRB_10_8 , IPRC_10_8 , IPRD_10_8 , IPRE_10_8 , IPRF_10_8 ,
  input  logic [2:0]  IPRG_10_8 , IPRH_10_8 , IPRI_10_8 , IPRJ_10_8 , IPRK_10_8 , IPRL_10_8 ,
  input  logic [2:0]  IPRM_10_8 , IPRN_10_8 ,
  // Group input 6:4
  input  logic [2:0]  IPRA_6_4  , IPRB_6_4  , IPRC_6_4  , IPRD_6_4  , IPRE_6_4  , IPRF_6_4  ,
  input  logic [2:0]  IPRG_6_4  , IPRH_6_4  , IPRI_6_4  , IPRJ_6_4  , IPRK_6_4  , IPRL_6_4  ,
  input  logic [2:0]  IPRM_6_4  , IPRN_6_4  , 
  // Group input 2:0
  input  logic [2:0]  IPRA_2_0  , IPRB_2_0  , IPRC_2_0  , IPRD_2_0  , IPRE_2_0  , IPRF_2_0  ,
  input  logic [2:0]  IPRG_2_0  , IPRH_2_0  , IPRI_2_0  , IPRJ_2_0  , IPRK_2_0  , IPRL_2_0  ,
  input  logic [2:0]  IPRM_2_0  , IPRN_2_0  ,
  // Internal request
  input  logic        SWDTEND   , WOVI      , CMI       , IIC2_2    , IIC2_3    , 
  input  logic [1:0]  AD_0      , IIC2_0    , IIC2_1    , 
  input  logic [2:0]  SSU       ,  
  input  logic [3:0]  TPU_1     , TPU_2     , TPU_4     , TPU_5     , TMR_0     , TMR_1     ,
  input  logic [3:0]  DMAC      , EXDMAC    , SCI_0     , SCI_1     , SCI_2     , SCI_3     ,
  input  logic [3:0]  AD_1      , TPU_7     , TPU_8     , TPU_10    , TPU_11    , 
  input  logic [4:0]  TPU_6     , TPU_9     , 
  input  logic [7:0]  TPU_0     , TPU_3     , SCI_4     ,
  // External request
  input  logic [0:15] IRQ_req   ,
  // Reserved	  
  input  logic [21:0] reserved              ,
  // Output
  output interrupt_request_signal,
  output [7:0] vector_number
);
    logic [2:0] max_priority;	   

    logic IPRA_14_12_EN, IPRB_14_12_EN, IPRC_14_12_EN, IPRD_14_12_EN, IPRE_14_12_EN, IPRF_14_12_EN, IPRG_14_12_EN; 
    logic IPRH_14_12_EN, IPRI_14_12_EN, IPRJ_14_12_EN, IPRK_14_12_EN, IPRL_14_12_EN, IPRM_14_12_EN, IPRN_14_12_EN;

    logic IPRA_10_8_EN , IPRB_10_8_EN , IPRC_10_8_EN , IPRD_10_8_EN , IPRE_10_8_EN , IPRF_10_8_EN , IPRG_10_8_EN ; 
    logic IPRH_10_8_EN , IPRI_10_8_EN , IPRJ_10_8_EN , IPRK_10_8_EN , IPRL_10_8_EN , IPRM_10_8_EN , IPRN_10_8_EN ; 
    
    logic IPRA_6_4_EN  , IPRB_6_4_EN  , IPRC_6_4_EN  , IPRD_6_4_EN  , IPRE_6_4_EN  , IPRF_6_4_EN  , IPRG_6_4_EN  ; 
    logic IPRH_6_4_EN  , IPRI_6_4_EN  , IPRJ_6_4_EN  , IPRK_6_4_EN  , IPRL_6_4_EN  , IPRM_6_4_EN  , IPRN_6_4_EN  ; 
    
    logic IPRA_2_0_EN  , IPRB_2_0_EN  , IPRC_2_0_EN  , IPRD_2_0_EN  , IPRE_2_0_EN  , IPRF_2_0_EN  , IPRG_2_0_EN  ; 
    logic IPRH_2_0_EN  , IPRI_2_0_EN  , IPRJ_2_0_EN  , IPRK_2_0_EN  , IPRL_2_0_EN  , IPRM_2_0_EN  , IPRN_2_0_EN  ;
    logic [239:0] interrupt_activated;
    logic [153:0] IPR_EN;
    logic [239:0] priority_selected;
    logic [0:239] interrupt_accepted;

    logic [7:0] sel_enc; 
    logic [7:0] out_mux_256;
    
    logic [7:0]  out_mux_M0;
    assign interrupt_activated = {IRQ_req, SWDTEND, WOVI , reserved[21], CMI  , reserved[20:19], AD_0  , TPU_0          ,
	   			  TPU_1  , TPU_2  , TPU_3, TPU_4       , TPU_5, TMR_0          , TMR_1 , DMAC           , 
				  EXDMAC , SCI_0  , SCI_1, SCI_2       , SCI_3, SCI_4          , AD_1  , IIC2_0         ,
				  IIC2_1 , TPU_6  , TPU_7, TPU_8       , TPU_9, TPU_10         , TPU_11, reserved[18:12],
			          IIC2_2 , IIC2_3 , reserved[11:0]};
    assign  IPR_EN = {IPRA_14_12_EN, IPRA_10_8_EN, IPRA_6_4_EN, IPRA_2_0_EN,
                      IPRB_14_12_EN, IPRB_10_8_EN, IPRB_6_4_EN, IPRB_2_0_EN,
                      IPRC_14_12_EN, IPRC_10_8_EN, IPRC_6_4_EN, IPRC_2_0_EN,
                      IPRD_14_12_EN, IPRD_10_8_EN, IPRD_6_4_EN, IPRD_2_0_EN,
                      IPRE_14_12_EN, IPRE_10_8_EN, IPRE_6_4_EN, IPRE_2_0_EN,
                      IPRF_14_12_EN, IPRF_10_8_EN, IPRF_6_4_EN, IPRF_2_0_EN,
                      IPRG_14_12_EN, IPRG_10_8_EN, IPRG_6_4_EN, IPRG_2_0_EN,
                      IPRH_14_12_EN, IPRH_10_8_EN, IPRH_6_4_EN, IPRH_2_0_EN,
                      IPRI_14_12_EN, IPRI_10_8_EN, IPRI_6_4_EN, IPRI_2_0_EN,
                      IPRJ_14_12_EN, IPRJ_10_8_EN, IPRJ_6_4_EN, IPRJ_2_0_EN,
                      IPRK_14_12_EN, IPRK_10_8_EN, IPRK_6_4_EN, IPRK_2_0_EN,
                      IPRL_14_12_EN, IPRL_10_8_EN, IPRL_6_4_EN, IPRL_2_0_EN,
                      IPRM_14_12_EN, IPRM_10_8_EN, IPRM_6_4_EN, IPRM_2_0_EN,
                      IPRN_14_12_EN, IPRN_10_8_EN, IPRN_6_4_EN, IPRN_2_0_EN
                     };



    max_priority_block max_priority_block_1 (
        // Group 14:12
        .IPRA_14_12(IPRA_14_12)  , .IPRB_14_12(IPRB_14_12)  , .IPRC_14_12(IPRC_14_12)  , .IPRD_14_12(IPRD_14_12)  ,
        .IPRE_14_12(IPRE_14_12)  , .IPRF_14_12(IPRF_14_12)  , .IPRG_14_12(IPRG_14_12)  , .IPRH_14_12(IPRH_14_12)  , 
        .IPRI_14_12(IPRI_14_12)  , .IPRJ_14_12(IPRJ_14_12)  , .IPRK_14_12(IPRK_14_12)  , .IPRL_14_12(IPRL_14_12)  ,
        .IPRM_14_12(IPRM_14_12)  , .IPRN_14_12(IPRN_14_12)  ,
        // Group 10:8   
        .IPRA_10_8 (IPRA_10_8 )  , .IPRB_10_8 (IPRB_10_8 )  , .IPRC_10_8 (IPRC_10_8 )  , .IPRD_10_8 (IPRD_10_8 )  , 
        .IPRE_10_8 (IPRE_10_8 )  , .IPRF_10_8 (IPRF_10_8 )  , .IPRG_10_8 (IPRG_10_8 )  , .IPRH_10_8 (IPRH_10_8 )  , 
        .IPRI_10_8 (IPRI_10_8 )  , .IPRJ_10_8 (IPRJ_10_8 )  , .IPRK_10_8 (IPRK_10_8 )  , .IPRL_10_8 (IPRL_10_8 )  ,
        .IPRM_10_8 (IPRM_10_8 )  , .IPRN_10_8 (IPRN_10_8 )  ,   
        // Group 6:4   
        .IPRA_6_4  (IPRA_6_4  )  , .IPRB_6_4  (IPRB_6_4  )  , .IPRC_6_4  (IPRC_6_4  )  , .IPRD_6_4  (IPRD_6_4  )  , 
        .IPRE_6_4  (IPRE_6_4  )  , .IPRF_6_4  (IPRF_6_4  )  , .IPRG_6_4  (IPRG_6_4  )  , .IPRH_6_4  (IPRH_6_4  )  , 
        .IPRI_6_4  (IPRI_6_4  )  , .IPRJ_6_4  (IPRJ_6_4  )  , .IPRK_6_4  (IPRK_6_4  )  , .IPRL_6_4  (IPRL_6_4  )  ,
        .IPRM_6_4  (IPRM_6_4  )  , .IPRN_6_4  (IPRN_6_4  )  , 
        // Group 2:0   
        .IPRA_2_0  (IPRA_2_0  )  , .IPRB_2_0  (IPRB_2_0  )  , .IPRC_2_0  (IPRC_2_0  )  , .IPRD_2_0  (IPRD_2_0  )  , 
        .IPRE_2_0  (IPRE_2_0  )  , .IPRF_2_0  (IPRF_2_0  )  , .IPRG_2_0  (IPRG_2_0  )  , .IPRH_2_0  (IPRH_2_0  )  , 
        .IPRI_2_0  (IPRI_2_0  )  , .IPRJ_2_0  (IPRJ_2_0  )  , .IPRK_2_0  (IPRK_2_0  )  , .IPRL_2_0  (IPRL_2_0  )  ,
        .IPRM_2_0  (IPRM_2_0  )  , .IPRN_2_0  (IPRN_2_0  )  ,
        //Internal request
        .SWDTEND (SWDTEND ) , .WOVI  (WOVI  ) , .CMI   (CMI   )  , .IIC2_2(IIC2_2)  , .IIC2_3(IIC2_3)  , 
        .AD_0    (AD_0    ) , .IIC2_0(IIC2_0) , .IIC2_1(IIC2_1)  , 
        .SSU     (SSU     ) ,
        .TPU_1   (TPU_1   ) , .TPU_2 (TPU_2 ) , .TPU_4 (TPU_4 )  , .TPU_5 (TPU_5 )  , .TMR_0 (TMR_0 )  , .TMR_1(TMR_1)   ,
        .DMAC    (DMAC    ) , .EXDMAC(EXDMAC) , .SCI_0 (SCI_0 )  , .SCI_1 (SCI_1 )  , .SCI_2 (SCI_2 )  , .SCI_3(SCI_3)   ,
        .AD_1    (AD_1    ) , .TPU_7 (TPU_7 ) , .TPU_8 (TPU_8 )  , .TPU_10(TPU_10)  , .TPU_11(TPU_11)  , 
        .TPU_6   (TPU_6   ) , .TPU_9 (TPU_9 ) ,
        .TPU_0   (TPU_0   ) , .TPU_3 (TPU_3 ) , .SCI_4 (SCI_4 )  ,
        //External request
        .IRQ_req (IRQ_req )    ,
        //Reserved	   
        .reserved(reserved)             ,
        // Output
        .max_priority(max_priority)
    );

    max_comparator_block max_comparator_block_1 (
        // Group 14:12
        .IPRA_14_12(IPRA_14_12)  , .IPRB_14_12(IPRB_14_12)  , .IPRC_14_12(IPRC_14_12)  , .IPRD_14_12(IPRD_14_12)  ,
        .IPRE_14_12(IPRE_14_12)  , .IPRF_14_12(IPRF_14_12)  , .IPRG_14_12(IPRG_14_12)  , .IPRH_14_12(IPRH_14_12)  , 
        .IPRI_14_12(IPRI_14_12)  , .IPRJ_14_12(IPRJ_14_12)  , .IPRK_14_12(IPRK_14_12)  , .IPRL_14_12(IPRL_14_12)  ,
        .IPRM_14_12(IPRM_14_12)  , .IPRN_14_12(IPRN_14_12)  ,
        // Group 10:8   
        .IPRA_10_8 (IPRA_10_8 )  , .IPRB_10_8 (IPRB_10_8 )  , .IPRC_10_8 (IPRC_10_8 )  , .IPRD_10_8 (IPRD_10_8 )  , 
        .IPRE_10_8 (IPRE_10_8 )  , .IPRF_10_8 (IPRF_10_8 )  , .IPRG_10_8 (IPRG_10_8 )  , .IPRH_10_8 (IPRH_10_8 )  , 
        .IPRI_10_8 (IPRI_10_8 )  , .IPRJ_10_8 (IPRJ_10_8 )  , .IPRK_10_8 (IPRK_10_8 )  , .IPRL_10_8 (IPRL_10_8 )  ,
        .IPRM_10_8 (IPRM_10_8 )  , .IPRN_10_8 (IPRN_10_8 )  ,   
        // Group 6:4   
        .IPRA_6_4  (IPRA_6_4  )  , .IPRB_6_4  (IPRB_6_4  )  , .IPRC_6_4  (IPRC_6_4  )  , .IPRD_6_4  (IPRD_6_4  )  , 
        .IPRE_6_4  (IPRE_6_4  )  , .IPRF_6_4  (IPRF_6_4  )  , .IPRG_6_4  (IPRG_6_4  )  , .IPRH_6_4  (IPRH_6_4  )  , 
        .IPRI_6_4  (IPRI_6_4  )  , .IPRJ_6_4  (IPRJ_6_4  )  , .IPRK_6_4  (IPRK_6_4  )  , .IPRL_6_4  (IPRL_6_4  )  ,
        .IPRM_6_4  (IPRM_6_4  )  , .IPRN_6_4  (IPRN_6_4  )  , 
        // Group 2:0   
        .IPRA_2_0  (IPRA_2_0  )  , .IPRB_2_0  (IPRB_2_0  )  , .IPRC_2_0  (IPRC_2_0  )  , .IPRD_2_0  (IPRD_2_0  )  , 
        .IPRE_2_0  (IPRE_2_0  )  , .IPRF_2_0  (IPRF_2_0  )  , .IPRG_2_0  (IPRG_2_0  )  , .IPRH_2_0  (IPRH_2_0  )  , 
        .IPRI_2_0  (IPRI_2_0  )  , .IPRJ_2_0  (IPRJ_2_0  )  , .IPRK_2_0  (IPRK_2_0  )  , .IPRL_2_0  (IPRL_2_0  )  ,
        .IPRM_2_0  (IPRM_2_0  )  , .IPRN_2_0  (IPRN_2_0  )  ,
	.max_priority(max_priority),
        //Output
        .IPRA_14_12_EN(IPRA_14_12_EN), .IPRB_14_12_EN(IPRB_14_12_EN), .IPRC_14_12_EN(IPRC_14_12_EN), 
	.IPRD_14_12_EN(IPRD_14_12_EN), .IPRE_14_12_EN(IPRE_14_12_EN), .IPRF_14_12_EN(IPRF_14_12_EN),
        .IPRG_14_12_EN(IPRG_14_12_EN), .IPRH_14_12_EN(IPRH_14_12_EN), .IPRI_14_12_EN(IPRI_14_12_EN), 
	.IPRJ_14_12_EN(IPRJ_14_12_EN), .IPRK_14_12_EN(IPRK_14_12_EN), .IPRL_14_12_EN(IPRL_14_12_EN),
        .IPRM_14_12_EN(IPRM_14_12_EN), .IPRN_14_12_EN(IPRN_14_12_EN),

        .IPRA_10_8_EN (IPRA_10_8_EN ), .IPRB_10_8_EN (IPRB_10_8_EN ), .IPRC_10_8_EN (IPRC_10_8_EN ), 
	.IPRD_10_8_EN (IPRD_10_8_EN ), .IPRE_10_8_EN (IPRE_10_8_EN ), .IPRF_10_8_EN (IPRF_10_8_EN ),
        .IPRG_10_8_EN (IPRG_10_8_EN ), .IPRH_10_8_EN (IPRH_10_8_EN ), .IPRI_10_8_EN (IPRI_10_8_EN ), 
	.IPRJ_10_8_EN (IPRJ_10_8_EN ), .IPRK_10_8_EN (IPRK_10_8_EN ), .IPRL_10_8_EN (IPRL_10_8_EN ),
        .IPRM_10_8_EN (IPRM_10_8_EN ), .IPRN_10_8_EN (IPRN_10_8_EN ),
        
	.IPRA_6_4_EN  (IPRA_6_4_EN  ), .IPRB_6_4_EN  (IPRB_6_4_EN  ), .IPRC_6_4_EN  (IPRC_6_4_EN  ), 
	.IPRD_6_4_EN  (IPRD_6_4_EN  ), .IPRE_6_4_EN  (IPRE_6_4_EN  ), .IPRF_6_4_EN  (IPRF_6_4_EN  ),
        .IPRG_6_4_EN  (IPRG_6_4_EN  ), .IPRH_6_4_EN  (IPRH_6_4_EN  ), .IPRI_6_4_EN  (IPRI_6_4_EN  ), 
	.IPRJ_6_4_EN  (IPRJ_6_4_EN  ), .IPRK_6_4_EN  (IPRK_6_4_EN  ), .IPRL_6_4_EN  (IPRL_6_4_EN  ),
        .IPRM_6_4_EN  (IPRM_6_4_EN  ), .IPRN_6_4_EN  (IPRN_6_4_EN  ),
        
	.IPRA_2_0_EN  (IPRA_2_0_EN  ), .IPRB_2_0_EN  (IPRB_2_0_EN  ), .IPRC_2_0_EN  (IPRC_2_0_EN  ), 
	.IPRD_2_0_EN  (IPRD_2_0_EN  ), .IPRE_2_0_EN  (IPRE_2_0_EN  ), .IPRF_2_0_EN  (IPRF_2_0_EN  ),
        .IPRG_2_0_EN  (IPRG_2_0_EN  ), .IPRH_2_0_EN  (IPRH_2_0_EN  ), .IPRI_2_0_EN  (IPRI_2_0_EN  ), 
	.IPRJ_2_0_EN  (IPRJ_2_0_EN  ), .IPRK_2_0_EN  (IPRK_2_0_EN  ), .IPRL_2_0_EN  (IPRL_2_0_EN  ),
        .IPRM_2_0_EN  (IPRM_2_0_EN  ), .IPRN_2_0_EN  (IPRN_2_0_EN  )                                                                 
    );


    select_mode #(
        .LINE_WIDTH_FULL(240),
	.LINE_WIDTH_154 (154)
    ) select_mode_1 (
        .interrupt_activated(interrupt_activated),
	.INTM1(INTM1),
	.I_bit(I_bit),
	.IPR_EN(IPR_EN),
        .priority_selected(priority_selected)
    );

    priority_default_block priority_default_block_1 (
        .priority_selected (priority_selected ),
        .interrupt_accepted(interrupt_accepted)	
    );

    interrupt_request_output interrupt_request_output_1 (
        .clk(clk                                   ),
        .EXR(EXR                                   ),
        .max_priority(max_priority                 ),
	.interrupt_accepted(interrupt_accepted     ),
	.NMI_req(NMI_req                           ),
	.INTM0(INTM0                               ),
	.INTM1(INTM1                               ),
	.rst_n(rst_n                               ),
	.interrupt_request(interrupt_request_signal)	
    );
    
    encoder_256_8 encoder_256_8_1 (
	.interrupt_accepted(interrupt_accepted),
	.sel_enc           (sel_enc           )	
    );

    mux_256_1 mux_256_1_1 (
        .sel_enc(sel_enc),
	.out(out_mux_256)	
    );
    assign out_mux_M0    = INTM0   ? 8'h0 : out_mux_256;
    assign vector_number = NMI_req ? 8'h7 : out_mux_M0 ;
endmodule : priority_determination

