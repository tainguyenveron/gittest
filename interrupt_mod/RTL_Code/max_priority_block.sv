module max_priority_block(
  // Input declare
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
  input  logic        SWDTEND   , WOVI      , CMI       , IIC2_2    , IIC2_3    , 
  input  logic [1:0]  AD_0      , IIC2_0    , IIC2_1    , 
  input  logic [2:0]  SSU       ,  
  input  logic [3:0]  TPU_1     , TPU_2     , TPU_4     , TPU_5     , TMR_0     , TMR_1     ,
  input  logic [3:0]  DMAC      , EXDMAC    , SCI_0     , SCI_1     , SCI_2     , SCI_3     ,
  input  logic [3:0]  AD_1      , TPU_7     , TPU_8     , TPU_10    , TPU_11    , 
  input  logic [4:0]  TPU_6     , TPU_9     , 
  input  logic [7:0]  TPU_0     , TPU_3     , SCI_4     ,
  input  logic [0:15] IRQ_req      ,
  input  logic [21:0] reserved              ,
  // Output Declaration
  output logic [2:0] max_priority
);
  
  logic [2:0] IRQ_0_selected , 
              IRQ_1_selected , 
              IRQ_2_selected , 
              IRQ_3_selected , 
              IRQ_4_selected , 
              IRQ_5_selected , 
              IRQ_6_selected , 
              IRQ_7_selected , 
              IRQ_8_selected , 
              IRQ_9_selected , 
              IRQ_10_selected, 
              IRQ_11_selected, 
              IRQ_12_selected, 
              IRQ_13_selected, 
              IRQ_14_selected, 
              IRQ_15_selected;

  logic [2:0] SWDTEND_selected    , WOVI_selected       , reserved_0_selected ,
              CMI_selected        , reserved_1_selected , AD_0_selected       ,
              TPU_0_selected      , TPU_1_selected      , TPU_2_selected      ,
              TPU_3_selected      , TPU_4_selected      , TPU_5_selected      ,
              TMR_0_selected      , TMR_1_selected      , DMAC_selected       , 
	      EXDMAC_0_selected   , EXDMAC_1_selected   , EXDMAC_2_selected   , 
	      EXDMAC_3_selected   , SCI_0_selected      , SCI_1_selected      , 
	      SCI_2_selected      , SCI_3_selected      , SCI_40_selected     , 
	      SCI_41_selected     , AD_1_selected       , IIC2_01_selected    , 
	      TPU_6_selected      , TPU_7_selected      , TPU_8_selected      , 
	      TPU_9_selected      , TPU_10_selected     , TPU_11_selected     , 
	      reserved_20_selected, reserved_21_selected, IIC2_23_selected    , 
	      SSU_selected        , reserved_30_selected, reserved_31_selected, 
	      reserved_32_selected; 

  logic [2:0] max_A1, max_A2;
  logic [2:0] max_B1, max_B2;
  logic [2:0] max_C1, max_C2;
  logic [2:0] max_D1, max_D2;
  logic [2:0] max_E1, max_E2;
  logic [2:0] max_F1, max_F2;
  logic [2:0] max_G1, max_G2;
  logic [2:0] max_H1, max_H2;
  logic [2:0] max_I1, max_I2;
  logic [2:0] max_J1, max_J2;
  logic [2:0] max_K1, max_K2;
  logic [2:0] max_L1, max_L2;
  logic [2:0] max_M1, max_M2;
  logic [2:0] max_N1, max_N2;
  
  
  logic [2:0] max_IPRA;
  logic [2:0] max_IPRB;
  logic [2:0] max_IPRC;
  logic [2:0] max_IPRD;
  logic [2:0] max_IPRE;
  logic [2:0] max_IPRF;
  logic [2:0] max_IPRG;
  logic [2:0] max_IPRH;
  logic [2:0] max_IPRI;
  logic [2:0] max_IPRJ;
  logic [2:0] max_IPRK;
  logic [2:0] max_IPRL;
  logic [2:0] max_IPRM;
  logic [2:0] max_IPRN;

  logic [2:0] max_AB;
  logic [2:0] max_CD;
  logic [2:0] max_EF;
  logic [2:0] max_GH;
  logic [2:0] max_IJ;
  logic [2:0] max_KL;
  logic [2:0] max_MN;

  logic [2:0] max_ABCD;
  logic [2:0] max_EFGH;
  logic [2:0] max_IJKL;

  logic [2:0] max_ABCDEFGH;
  logic [2:0] max_IJKL_MN ;
  //=================== Group IPRA ================== 
  assign IRQ_0_selected       = IRQ_req[0]           ? IPRA_14_12 : 3'b0;
  assign IRQ_1_selected       = IRQ_req[1]           ? IPRA_10_8  : 3'b0;
  assign IRQ_2_selected       = IRQ_req[2]           ? IPRA_6_4   : 3'b0;
  assign IRQ_3_selected       = IRQ_req[3]           ? IPRA_2_0   : 3'b0;
 
  //=================== Group IPRB ================== 
  assign IRQ_4_selected       = IRQ_req[4]           ? IPRB_14_12 : 3'b0;
  assign IRQ_5_selected       = IRQ_req[5]           ? IPRB_10_8  : 3'b0;
  assign IRQ_6_selected       = IRQ_req[6]           ? IPRB_6_4   : 3'b0;
  assign IRQ_7_selected       = IRQ_req[7]           ? IPRB_2_0   : 3'b0;

  //=================== Group IPRC ================== 
  assign IRQ_8_selected       = IRQ_req[8]           ? IPRC_14_12 : 3'b0;
  assign IRQ_9_selected       = IRQ_req[9]           ? IPRC_10_8  : 3'b0;
  assign IRQ_10_selected      = IRQ_req[10]          ? IPRC_6_4   : 3'b0;
  assign IRQ_11_selected      = IRQ_req[11]          ? IPRC_2_0   : 3'b0;
  
  //=================== Group IPRD ================== 
  assign IRQ_12_selected      = IRQ_req[12]          ? IPRD_14_12 : 3'b0;
  assign IRQ_13_selected      = IRQ_req[13]          ? IPRD_10_8  : 3'b0;
  assign IRQ_14_selected      = IRQ_req[14]          ? IPRD_6_4   : 3'b0;
  assign IRQ_15_selected      = IRQ_req[15]          ? IPRD_2_0   : 3'b0;
  
  //=================== Group IPRE ================== 
  assign SWDTEND_selected     = SWDTEND              ? IPRE_14_12 : 3'b0; 
  assign WOVI_selected        = WOVI                 ? IPRE_10_8  : 3'b0; 
  assign reserved_0_selected  = reserved[21]         ? IPRE_6_4   : 3'b0;
  assign CMI_selected         = CMI                  ? IPRE_2_0   : 3'b0; 
  
  //=================== Group IPRF ================== 
  assign reserved_1_selected  = |reserved[20:19]     ? IPRF_14_12 : 3'b0; 
  assign AD_0_selected        = |AD_0                ? IPRF_10_8  : 3'b0;
  assign TPU_0_selected       = |TPU_0               ? IPRF_6_4   : 3'b0; 
  assign TPU_1_selected       = |TPU_1               ? IPRF_2_0   : 3'b0; 
  
  //=================== Group IPRG ================== 
  assign TPU_2_selected       = |TPU_2               ? IPRG_14_12 : 3'b0;
  assign TPU_3_selected       = |TPU_3               ? IPRG_10_8  : 3'b0; 
  assign TPU_4_selected       = |TPU_4               ? IPRG_6_4   : 3'b0; 
  assign TPU_5_selected       = |TPU_5               ? IPRG_2_0   : 3'b0;
  
  //=================== Group IPRH ================== 
  assign TMR_0_selected       = |TMR_0               ? IPRH_14_12 : 3'b0; 
  assign TMR_1_selected       = |TMR_1               ? IPRH_10_8  : 3'b0;
  assign DMAC_selected        = |DMAC                ? IPRH_6_4   : 3'b0; 
  assign EXDMAC_3_selected    = EXDMAC[3]            ? IPRH_2_0   : 3'b0;
  
  //=================== Group IPRI ================== 
  assign EXDMAC_2_selected    = EXDMAC[2]            ? IPRI_14_12 : 3'b0; 
  assign EXDMAC_1_selected    = EXDMAC[1]            ? IPRI_10_8  : 3'b0; 
  assign EXDMAC_0_selected    = EXDMAC[0]            ? IPRI_6_4   : 3'b0;
  assign SCI_0_selected       = |SCI_0               ? IPRI_2_0   : 3'b0; 
  
  //=================== Group IPRJ ================== 
  assign SCI_1_selected       = |SCI_1               ? IPRJ_14_12 : 3'b0; 
  assign SCI_2_selected       = |SCI_2               ? IPRJ_10_8  : 3'b0;
  assign SCI_3_selected       = |SCI_3               ? IPRJ_6_4   : 3'b0; 
  assign SCI_41_selected      = |SCI_4[7:4]          ? IPRJ_2_0   : 3'b0; 
  
  //=================== Group IPRK ================== 
  assign SCI_40_selected      = |SCI_4[3:0]          ? IPRK_14_12 : 3'b0;
  assign AD_1_selected        = |AD_1                ? IPRK_10_8  : 3'b0; 
  assign IIC2_01_selected     = |{IIC2_0, IIC2_1}    ? IPRK_6_4   : 3'b0; 
  assign TPU_6_selected       = |TPU_6               ? IPRK_2_0   : 3'b0;
  
  //=================== Group IPRL ================== 
  assign TPU_7_selected       = |TPU_7               ? IPRL_14_12 : 3'b0; 
  assign TPU_8_selected       = |TPU_8               ? IPRL_10_8  : 3'b0; 
  assign TPU_9_selected       = |TPU_9               ? IPRL_6_4   : 3'b0;
  assign TPU_10_selected      = |TPU_10              ? IPRL_2_0   : 3'b0; 
  
  //=================== Group IPRM ================== 
  assign TPU_11_selected      = |TPU_11              ? IPRM_14_12 : 3'b0; 
  assign reserved_21_selected = |reserved[18:15]     ? IPRM_10_8  : 3'b0;
  assign reserved_20_selected = |reserved[14:12]     ? IPRM_6_4   : 3'b0; 
  assign IIC2_23_selected     = |{IIC2_2, IIC2_3}    ? IPRM_2_0   : 3'b0; 
  
  //=================== Group IPRN ================== 
  assign SSU_selected         = |SSU                 ? IPRN_14_12 : 3'b0;
  assign reserved_32_selected = |reserved[11:8]      ? IPRN_10_8  : 3'b0; 
  assign reserved_31_selected = |reserved[7:4]       ? IPRN_6_4   : 3'b0; 
  assign reserved_30_selected = |reserved[3:0]       ? IPRN_2_0   : 3'b0;

  // Stage 1 : 28 comp to find max of two in IPR
  comparator_greater maxA1 (
    .a        (IRQ_0_selected      ),
    .b        (IRQ_1_selected      ),
    .gt_value (max_A1              )

  );
  comparator_greater maxA2 (
    .a        (IRQ_2_selected      ),
    .b        (IRQ_3_selected      ),
    .gt_value (max_A2              )

  );
  comparator_greater maxB1 (
    .a        (IRQ_4_selected      ),
    .b        (IRQ_5_selected      ),
    .gt_value (max_B1              )

  );
  comparator_greater maxB2 (
    .a        (IRQ_6_selected      ),
    .b        (IRQ_7_selected      ),
    .gt_value (max_B2              ) 

  ); 
  comparator_greater maxC1 (
    .a        (IRQ_8_selected      ),
    .b        (IRQ_9_selected      ),
    .gt_value (max_C1              )

  );
  comparator_greater maxC2 (
    .a        (IRQ_10_selected     ),
    .b        (IRQ_11_selected     ),
    .gt_value (max_C2              )
  ); 

  comparator_greater maxD1 (
    .a        (IRQ_12_selected     ),
    .b        (IRQ_13_selected     ),
    .gt_value (max_D1              )
  );
  comparator_greater maxD2 (
    .a        (IRQ_14_selected     ),
    .b        (IRQ_15_selected     ),
    .gt_value (max_D2              )
  ); 
  comparator_greater maxE1 (
    .a        (SWDTEND_selected    ),
    .b        (WOVI_selected       ),
    .gt_value (max_E1              )
  );
  comparator_greater maxE2 (
    .a        (reserved_0_selected ),
    .b        (CMI_selected        ),
    .gt_value (max_E2              )
  ); 
  comparator_greater maxF1 (
    .a        (reserved_1_selected ),
    .b        (AD_0_selected       ),
    .gt_value (max_F1              )
  );
  comparator_greater maxF2 (
    .a        (TPU_0_selected      ),
    .b        (TPU_1_selected      ),
    .gt_value (max_F2              )
  ); 
  comparator_greater maxG1 (
    .a        (TPU_2_selected      ),
    .b        (TPU_3_selected      ),
    .gt_value (max_G1              ) 
  );
  comparator_greater maxG2 (
    .a        (TPU_4_selected      ),
    .b        (TPU_5_selected      ),
    .gt_value (max_G2              )
  ); 
  comparator_greater maxH1 (
    .a        (TMR_0_selected      ),
    .b        (TMR_1_selected      ),
    .gt_value (max_H1              )
  );
  comparator_greater maxH2 (
    .a        (DMAC_selected       ),
    .b        (EXDMAC_3_selected   ),
    .gt_value (max_H2              )
  ); 
  comparator_greater maxI1 (
    .a        (EXDMAC_2_selected   ),
    .b        (EXDMAC_1_selected   ),
    .gt_value (max_I1              )
  );
  comparator_greater maxI2 (
    .a        (EXDMAC_0_selected   ),
    .b        (SCI_0_selected      ),
    .gt_value (max_I2              )    
  );
  comparator_greater maxJ1 (
    .a        (SCI_1_selected      ),
    .b        (SCI_2_selected      ),
    .gt_value (max_J1              )
  );
  comparator_greater maxJ2 (
    .a        (SCI_3_selected      ),
    .b        (SCI_41_selected     ),
    .gt_value (max_J2              )
  ); 
  comparator_greater maxK1 (
    .a        (SCI_40_selected     ),
    .b        (AD_1_selected       ),
    .gt_value (max_K1              )
  );
  comparator_greater maxK2 (
    .a        (IIC2_01_selected    ),
    .b        (TPU_6_selected      ),
    .gt_value (max_K2              )
  ); 
  comparator_greater maxL1 (
    .a        (TPU_7_selected      ),
    .b        (TPU_8_selected      ),
    .gt_value (max_L1              )
  );
  comparator_greater maxL2 (
    .a        (TPU_9_selected      ),
    .b        (TPU_10_selected     ),
    .gt_value (max_L2              )
  ); 
  comparator_greater maxM1 (
    .a        (TPU_11_selected     ),
    .b        (reserved_21_selected),
    .gt_value (max_M1              )
  );
  comparator_greater maxM2 (
    .a        (reserved_20_selected),
    .b        (IIC2_23_selected    ),
    .gt_value (max_M2    )
  );
  comparator_greater maxN1 (
    .a        (SSU_selected        ),
    .b        (reserved_32_selected),
    .gt_value (max_N1              )
  );
  comparator_greater maxN2 (
    .a        (reserved_31_selected),
    .b        (reserved_30_selected),
    .gt_value (max_N2              )
  );

  //Stage 2: 14 comp to find max of each IPR
  comparator_greater maxA (
    .a        (max_A1  ),
    .b        (max_A2  ),
    .gt_value (max_IPRA)

  );

  comparator_greater maxB (
    .a        (max_B1  ),
    .b        (max_B2  ),
    .gt_value (max_IPRB)

  );
  comparator_greater maxC (
    .a        (max_C1  ),
    .b        (max_C2  ),
    .gt_value (max_IPRC)

  ); 
  comparator_greater maxD (
    .a        (max_D1  ),
    .b        (max_D2  ),
    .gt_value (max_IPRD)

  ); 
  comparator_greater maxE (
    .a        (max_E1  ),
    .b        (max_E2  ),
    .gt_value (max_IPRE)

  ); 
  comparator_greater maxF (
    .a        (max_F1  ),
    .b        (max_F2  ),
    .gt_value (max_IPRF)

  ); 
  comparator_greater maxG (
    .a        (max_G1  ),
    .b        (max_G2  ),
    .gt_value (max_IPRG)

  ); 
  comparator_greater maxH (
    .a        (max_H1  ),
    .b        (max_H2  ),
    .gt_value (max_IPRH)

  ); 
  comparator_greater maxI (
    .a        (max_I1  ),
    .b        (max_I2  ),
    .gt_value (max_IPRI)

  ); 
  comparator_greater maxJ (
    .a        (max_J1  ),
    .b        (max_J2  ),
    .gt_value (max_IPRJ)

  ); 
  comparator_greater maxK (
    .a        (max_K1  ),
    .b        (max_K2  ),
    .gt_value (max_IPRK)

  ); 
  comparator_greater maxL (
    .a        (max_L1  ),
    .b        (max_L2  ),
    .gt_value (max_IPRL)

  );
  comparator_greater maxM (
    .a        (max_M1  ),
    .b        (max_M2  ),
    .gt_value (max_IPRM)

  ); 
  comparator_greater maxN (
    .a        (max_N1  ),
    .b        (max_N2  ),
    .gt_value (max_IPRN)

  );

  //Stage 3: find max of IPR pair A or B, C or D
   comparator_greater maxAB (
    .a        (max_IPRA),
    .b        (max_IPRB),
    .gt_value (max_AB  )

  ); 
   comparator_greater maxCD (
    .a        (max_IPRC),
    .b        (max_IPRD),
    .gt_value (max_CD  )

  );   
  comparator_greater maxEF (
    .a        (max_IPRE),
    .b        (max_IPRF),
    .gt_value (max_EF  )

  );  
  comparator_greater maxGH (
    .a        (max_IPRG),
    .b        (max_IPRH),
    .gt_value (max_GH  )

  );   
  comparator_greater maxIJ (
    .a        (max_IPRI),
    .b        (max_IPRJ),
    .gt_value (max_IJ  )

  );   
  comparator_greater maxKL (
    .a        (max_IPRK),
    .b        (max_IPRL),
    .gt_value (max_KL  )

  );   
  comparator_greater maxMN (
    .a        (max_IPRM),
    .b        (max_IPRN),
    .gt_value (max_MN  )

  ); 

  //Stage 4: find max of ABCD EFGH IJKL
  
  comparator_greater maxABCD (
    .a        (max_AB   ),
    .b        (max_CD   ),
    .gt_value (max_ABCD )

  );  
  comparator_greater maxEFGH (
    .a        (max_EF   ),
    .b        (max_GH   ),
    .gt_value (max_EFGH )

  );  
  comparator_greater maxIJKL (
    .a        (max_IJ   ),
    .b        (max_KL   ),
    .gt_value (max_IJKL )

  ); 
 

  //Stage 5: ABCDEFGH , IJKL/MN
  comparator_greater maxABCDEFGH (
    .a        (max_ABCD     ),
    .b        (max_EFGH     ),
    .gt_value (max_ABCDEFGH )

  ); 

  comparator_greater maxIJKL_MN (
    .a        (max_IJKL     ),
    .b        (max_MN       ),
    .gt_value (max_IJKL_MN  )

  ); 

  //Stage 6: final max
  comparator_greater max_final (
    .a        (max_ABCDEFGH ),
    .b        (max_IJKL_MN  ),
    .gt_value (max_priority )

  ); 

endmodule : max_priority_block
 
module comparator_greater #(
  parameter DATA_WIDTH = 3           // Width of input data
)(
  input  logic [DATA_WIDTH-1:0] a  ,  // First input
  input  logic [DATA_WIDTH-1:0] b  ,  // Second input
  output logic [DATA_WIDTH-1:0] gt_value   // Output: maximum value
);

  assign gt_value = a > b ? a : b;
  // sel = a > b;
  // case(sel)
  //  1: gt_value = a;
  //  0: gt_value = b;
  //  default: gt_value = 0;

endmodule : comparator_greater
