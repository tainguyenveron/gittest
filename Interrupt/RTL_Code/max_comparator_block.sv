module max_comparator_block (

  // Input declaration
  // Group input 14:12
  input  logic [2:0] IPRA_14_12, IPRB_14_12, IPRC_14_12, IPRD_14_12, IPRE_14_12, IPRF_14_12,
  input  logic [2:0] IPRG_14_12, IPRH_14_12, IPRI_14_12, IPRJ_14_12, IPRK_14_12, IPRL_14_12,
  input  logic [2:0] IPRM_14_12, IPRN_14_12,
  // Group input 10:8
  input  logic [2:0] IPRA_10_8 , IPRB_10_8 , IPRC_10_8 , IPRD_10_8 , IPRE_10_8 , IPRF_10_8 ,
  input  logic [2:0] IPRG_10_8 , IPRH_10_8 , IPRI_10_8 , IPRJ_10_8 , IPRK_10_8 , IPRL_10_8 ,
  input  logic [2:0] IPRM_10_8 , IPRN_10_8 ,
  // Group input 6:4
  input  logic [2:0] IPRA_6_4  , IPRB_6_4  , IPRC_6_4  , IPRD_6_4  , IPRE_6_4  , IPRF_6_4  ,
  input  logic [2:0] IPRG_6_4  , IPRH_6_4  , IPRI_6_4  , IPRJ_6_4  , IPRK_6_4  , IPRL_6_4  ,
  input  logic [2:0] IPRM_6_4  , IPRN_6_4  , 
  // Group input 2:0
  input  logic [2:0] IPRA_2_0  , IPRB_2_0  , IPRC_2_0  , IPRD_2_0  , IPRE_2_0  , IPRF_2_0  ,
  input  logic [2:0] IPRG_2_0  , IPRH_2_0  , IPRI_2_0  , IPRJ_2_0  , IPRK_2_0  , IPRL_2_0  ,
  input  logic [2:0] IPRM_2_0  , IPRN_2_0  ,
  input  logic [2:0] max_priority,
  

  //Output enable interrupt
  output  logic       IPRA_14_12_EN, IPRB_14_12_EN, IPRC_14_12_EN, IPRD_14_12_EN, IPRE_14_12_EN, IPRF_14_12_EN,
  output  logic       IPRG_14_12_EN, IPRH_14_12_EN, IPRI_14_12_EN, IPRJ_14_12_EN, IPRK_14_12_EN, IPRL_14_12_EN,
  output  logic       IPRM_14_12_EN, IPRN_14_12_EN,
  // Group output 10:8
  output  logic       IPRA_10_8_EN , IPRB_10_8_EN , IPRC_10_8_EN , IPRD_10_8_EN , IPRE_10_8_EN , IPRF_10_8_EN ,
  output  logic       IPRG_10_8_EN , IPRH_10_8_EN , IPRI_10_8_EN , IPRJ_10_8_EN , IPRK_10_8_EN , IPRL_10_8_EN ,
  output  logic       IPRM_10_8_EN , IPRN_10_8_EN ,
  // Group output 6:4
  output  logic       IPRA_6_4_EN  , IPRB_6_4_EN  , IPRC_6_4_EN  , IPRD_6_4_EN  , IPRE_6_4_EN  , IPRF_6_4_EN  ,
  output  logic       IPRG_6_4_EN  , IPRH_6_4_EN  , IPRI_6_4_EN  , IPRJ_6_4_EN  , IPRK_6_4_EN  , IPRL_6_4_EN  ,
  output  logic       IPRM_6_4_EN  , IPRN_6_4_EN  , 
  // Group output 2:0
  output  logic       IPRA_2_0_EN  , IPRB_2_0_EN  , IPRC_2_0_EN  , IPRD_2_0_EN  , IPRE_2_0_EN  , IPRF_2_0_EN  ,
  output  logic       IPRG_2_0_EN  , IPRH_2_0_EN  , IPRI_2_0_EN  , IPRJ_2_0_EN  , IPRK_2_0_EN  , IPRL_2_0_EN  ,
  output  logic       IPRM_2_0_EN  , IPRN_2_0_EN  

);

  //=================== Group IPRA ================== 
  assign IPRA_14_12_EN = (IPRA_14_12 == max_priority) ? 1'b1 : 1'b0; 
  assign IPRA_10_8_EN  = (IPRA_10_8  == max_priority) ? 1'b1 : 1'b0; 
  assign IPRA_6_4_EN   = (IPRA_6_4   == max_priority) ? 1'b1 : 1'b0; 
  assign IPRA_2_0_EN   = (IPRA_2_0   == max_priority) ? 1'b1 : 1'b0; 
     
  //=================== Group IPRB ================== 
  assign IPRB_14_12_EN = (IPRB_14_12 == max_priority) ? 1'b1 : 1'b0; 
  assign IPRB_10_8_EN  = (IPRB_10_8  == max_priority) ? 1'b1 : 1'b0; 
  assign IPRB_6_4_EN   = (IPRB_6_4   == max_priority) ? 1'b1 : 1'b0; 
  assign IPRB_2_0_EN   = (IPRB_2_0   == max_priority) ? 1'b1 : 1'b0;

  //=================== Group IPRC ================== 
  assign IPRC_14_12_EN = (IPRC_14_12 == max_priority) ? 1'b1 : 1'b0; 
  assign IPRC_10_8_EN  = (IPRC_10_8  == max_priority) ? 1'b1 : 1'b0; 
  assign IPRC_6_4_EN   = (IPRC_6_4   == max_priority) ? 1'b1 : 1'b0; 
  assign IPRC_2_0_EN   = (IPRC_2_0   == max_priority) ? 1'b1 : 1'b0;
  
  //=================== Group IPRD ================== 
  assign IPRD_14_12_EN = (IPRD_14_12 == max_priority) ? 1'b1 : 1'b0; 
  assign IPRD_10_8_EN  = (IPRD_10_8  == max_priority) ? 1'b1 : 1'b0; 
  assign IPRD_6_4_EN   = (IPRD_6_4   == max_priority) ? 1'b1 : 1'b0; 
  assign IPRD_2_0_EN   = (IPRD_2_0   == max_priority) ? 1'b1 : 1'b0;
                                                                  
  //=================== Group IPRE ================== 
  assign IPRE_14_12_EN = (IPRE_14_12 == max_priority) ? 1'b1 : 1'b0; 
  assign IPRE_10_8_EN  = (IPRE_10_8  == max_priority) ? 1'b1 : 1'b0; 
  assign IPRE_6_4_EN   = (IPRE_6_4   == max_priority) ? 1'b1 : 1'b0; 
  assign IPRE_2_0_EN   = (IPRE_2_0   == max_priority) ? 1'b1 : 1'b0;

  //=================== Group IPRF ================== 
  assign IPRF_14_12_EN = (IPRF_14_12 == max_priority) ? 1'b1 : 1'b0; 
  assign IPRF_10_8_EN  = (IPRF_10_8  == max_priority) ? 1'b1 : 1'b0; 
  assign IPRF_6_4_EN   = (IPRF_6_4   == max_priority) ? 1'b1 : 1'b0; 
  assign IPRF_2_0_EN   = (IPRF_2_0   == max_priority) ? 1'b1 : 1'b0; 
     
  //=================== Group IPRG ================== 
  assign IPRG_14_12_EN = (IPRG_14_12 == max_priority) ? 1'b1 : 1'b0; 
  assign IPRG_10_8_EN  = (IPRG_10_8  == max_priority) ? 1'b1 : 1'b0; 
  assign IPRG_6_4_EN   = (IPRG_6_4   == max_priority) ? 1'b1 : 1'b0; 
  assign IPRG_2_0_EN   = (IPRG_2_0   == max_priority) ? 1'b1 : 1'b0;

  //=================== Group IPRH ================== 
  assign IPRH_14_12_EN = (IPRH_14_12 == max_priority) ? 1'b1 : 1'b0; 
  assign IPRH_10_8_EN  = (IPRH_10_8  == max_priority) ? 1'b1 : 1'b0; 
  assign IPRH_6_4_EN   = (IPRH_6_4   == max_priority) ? 1'b1 : 1'b0; 
  assign IPRH_2_0_EN   = (IPRH_2_0   == max_priority) ? 1'b1 : 1'b0;
  
  //=================== Group IPRI ================== 
  assign IPRI_14_12_EN = (IPRI_14_12 == max_priority) ? 1'b1 : 1'b0; 
  assign IPRI_10_8_EN  = (IPRI_10_8  == max_priority) ? 1'b1 : 1'b0; 
  assign IPRI_6_4_EN   = (IPRI_6_4   == max_priority) ? 1'b1 : 1'b0; 
  assign IPRI_2_0_EN   = (IPRI_2_0   == max_priority) ? 1'b1 : 1'b0;
                                                                  
  //=================== Group IPRJ ================== 
  assign IPRJ_14_12_EN = (IPRJ_14_12 == max_priority) ? 1'b1 : 1'b0; 
  assign IPRJ_10_8_EN  = (IPRJ_10_8  == max_priority) ? 1'b1 : 1'b0; 
  assign IPRJ_6_4_EN   = (IPRJ_6_4   == max_priority) ? 1'b1 : 1'b0; 
  assign IPRJ_2_0_EN   = (IPRJ_2_0   == max_priority) ? 1'b1 : 1'b0; 
  
  //=================== Group IPRK ================== 
  assign IPRK_14_12_EN = (IPRK_14_12 == max_priority) ? 1'b1 : 1'b0; 
  assign IPRK_10_8_EN  = (IPRK_10_8  == max_priority) ? 1'b1 : 1'b0; 
  assign IPRK_6_4_EN   = (IPRK_6_4   == max_priority) ? 1'b1 : 1'b0; 
  assign IPRK_2_0_EN   = (IPRK_2_0   == max_priority) ? 1'b1 : 1'b0; 
     
  //=================== Group IPRL ================== 
  assign IPRL_14_12_EN = (IPRL_14_12 == max_priority) ? 1'b1 : 1'b0; 
  assign IPRL_10_8_EN  = (IPRL_10_8  == max_priority) ? 1'b1 : 1'b0; 
  assign IPRL_6_4_EN   = (IPRL_6_4   == max_priority) ? 1'b1 : 1'b0; 
  assign IPRL_2_0_EN   = (IPRL_2_0   == max_priority) ? 1'b1 : 1'b0;

  //=================== Group IPRM ================== 
  assign IPRM_14_12_EN = (IPRM_14_12 == max_priority) ? 1'b1 : 1'b0; 
  assign IPRM_10_8_EN  = (IPRM_10_8  == max_priority) ? 1'b1 : 1'b0; 
  assign IPRM_6_4_EN   = (IPRM_6_4   == max_priority) ? 1'b1 : 1'b0; 
  assign IPRM_2_0_EN   = (IPRM_2_0   == max_priority) ? 1'b1 : 1'b0;
  
  //=================== Group IPRN ================== 
  assign IPRN_14_12_EN = (IPRN_14_12 == max_priority) ? 1'b1 : 1'b0; 
  assign IPRN_10_8_EN  = (IPRN_10_8  == max_priority) ? 1'b1 : 1'b0; 
  assign IPRN_6_4_EN   = (IPRN_6_4   == max_priority) ? 1'b1 : 1'b0; 
  assign IPRN_2_0_EN   = (IPRN_2_0   == max_priority) ? 1'b1 : 1'b0;

endmodule : max_comparator_block
