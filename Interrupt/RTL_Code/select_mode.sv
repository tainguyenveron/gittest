
//WE DONT HAVE IPR for reserved from 170 to 255 (84 reserved)(only 154 left)
module select_mode 
#(parameter LINE_WIDTH_FULL = 5,
  parameter LINE_WIDTH_154  = 2)
(
    input  logic  [LINE_WIDTH_FULL-1:0] interrupt_activated, //from IRQ0 to reserved 255
    input  logic                        INTM1,
    input  logic                        I_bit,
    input  logic  [LINE_WIDTH_154-1:0]  IPR_EN,           //from IRQ0 to SSXTI
    output logic  [LINE_WIDTH_FULL-1:0] priority_selected
);
    logic temp_I;
    logic [LINE_WIDTH_FULL-1 :0] temp_0;
    logic [LINE_WIDTH_154-1 :0]  temp_2;
    logic [LINE_WIDTH_154-1 :0]  temp_154_mux;
    
    assign temp_I = ~I_bit;
    genvar i, j, k;

    // Mode 0 AND gate: 240 request AND bit I
    generate
        for(i = 0; i < LINE_WIDTH_FULL; i = i + 1) begin
          assign temp_0[i] = interrupt_activated[i] & temp_I;
        end
    endgenerate

    // Mode 2 AND gate: 154 request AND IPR_EN
    generate
        for(j = 0; j < LINE_WIDTH_154  ; j = j + 1) begin
          assign  temp_2[LINE_WIDTH_154-1-j] =  interrupt_activated[LINE_WIDTH_FULL-1-j] & IPR_EN[LINE_WIDTH_154-1-j];
        end
    endgenerate

    // MUX to select from 2 modes
   generate
    for(k = 0; k < LINE_WIDTH_154; k = k + 1) begin
        assign temp_154_mux[LINE_WIDTH_154-1-k] =
            (INTM1) ? temp_2[LINE_WIDTH_154-1-k] : temp_0[LINE_WIDTH_FULL-1-k];
    end
   endgenerate

   assign priority_selected = {temp_154_mux,temp_0[LINE_WIDTH_FULL-LINE_WIDTH_154-1:0]};

endmodule

