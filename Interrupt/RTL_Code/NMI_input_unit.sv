module NMI_input_unit (
    input  logic rst_n                ,
    input  logic clk                  ,
    input  logic NMI                  ,
    input  logic NMIEG                ,

    output logic NMI_req

  );

  logic temp_posedge         ;
  logic temp_negedge         ;

  negedge_detector neg_block (
    .rst_n         (rst_n        ),
    .clk           (clk          ), 
    .in_neg_sig    (NMI          ),
    .negedge_signal(temp_negedge )
  );

  posedge_detector pos_block (
    .rst_n         (rst_n        ),
    .clk           (clk          ), 
    .in_pos_sig    (NMI          ),
    .posedge_signal(temp_posedge )
  );
 
  assign NMI_req = NMIEG ? temp_negedge : temp_posedge;

endmodule: NMI_input_unit
