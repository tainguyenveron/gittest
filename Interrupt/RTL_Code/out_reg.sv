module out_reg 
#(parameter ADDR_WIDTH = 32,
  parameter DATA_WIDTH = 32
)

(
  //Input logic
  input  logic [ADDR_WIDTH-1:0]  PADDR, 
  input   logic                  wren,

  input  logic [DATA_WIDTH-1:0] INTCR_dataout,
  input  logic [DATA_WIDTH-1:0] ISCRH_dataout,
  input  logic [DATA_WIDTH-1:0] ISCRL_dataout,
  input  logic [DATA_WIDTH-1:0] IER_dataout,
  input  logic [DATA_WIDTH-1:0] ISR_dataout,
  input  logic [DATA_WIDTH-1:0] ITSR_dataout,

  input  logic [DATA_WIDTH-1:0] IPRA_dataout,
  input  logic [DATA_WIDTH-1:0] IPRB_dataout,
  input  logic [DATA_WIDTH-1:0] IPRC_dataout,
  input  logic [DATA_WIDTH-1:0] IPRD_dataout,
  input  logic [DATA_WIDTH-1:0] IPRE_dataout,
  input  logic [DATA_WIDTH-1:0] IPRF_dataout,
  input  logic [DATA_WIDTH-1:0] IPRG_dataout,
  input  logic [DATA_WIDTH-1:0] IPRH_dataout,
  input  logic [DATA_WIDTH-1:0] IPRI_dataout,
  input  logic [DATA_WIDTH-1:0] IPRJ_dataout,
  input  logic [DATA_WIDTH-1:0] IPRK_dataout,
  input  logic [DATA_WIDTH-1:0] IPRL_dataout,
  input  logic [DATA_WIDTH-1:0] IPRM_dataout,
  input  logic [DATA_WIDTH-1:0] IPRN_dataout,
  

  //Output logic
  output logic [DATA_WIDTH-1:0] data_out
  

);
  
    localparam ADDR_BASE = 32'h0009_0000;
  //Internal logic
  logic [DATA_WIDTH-1:0] data_out_temp;
  
  //Encode the address
  always_comb begin 
    case (PADDR)
      ADDR_BASE + 8'h00: data_out_temp = INTCR_dataout;
      ADDR_BASE + 8'h04: data_out_temp = ISCRH_dataout;
      ADDR_BASE + 8'h08: data_out_temp = ISCRL_dataout;
      ADDR_BASE + 8'h0C: data_out_temp = IER_dataout;
      ADDR_BASE + 8'h10: data_out_temp = ISR_dataout;
      ADDR_BASE + 8'h14: data_out_temp = ITSR_dataout;
      ADDR_BASE + 8'h18: data_out_temp = IPRA_dataout;
      ADDR_BASE + 8'h1C: data_out_temp = IPRB_dataout;
      ADDR_BASE + 8'h20: data_out_temp = IPRC_dataout;
      ADDR_BASE + 8'h24: data_out_temp = IPRD_dataout;
      ADDR_BASE + 8'h28: data_out_temp = IPRE_dataout;
      ADDR_BASE + 8'h2C: data_out_temp = IPRF_dataout;
      ADDR_BASE + 8'h30: data_out_temp = IPRG_dataout;
      ADDR_BASE + 8'h34: data_out_temp = IPRH_dataout;
      ADDR_BASE + 8'h38: data_out_temp = IPRI_dataout;
      ADDR_BASE + 8'h3C: data_out_temp = IPRJ_dataout;
      ADDR_BASE + 8'h40: data_out_temp = IPRK_dataout;
      ADDR_BASE + 8'h44: data_out_temp = IPRL_dataout;
      ADDR_BASE + 8'h48: data_out_temp = IPRM_dataout;
      ADDR_BASE + 8'h4C: data_out_temp = IPRN_dataout;
      default:       data_out_temp = 'b0; // or some safe default
    endcase
  end


  always_comb begin
    case (wren)
      1'b0: data_out = data_out_temp;
      1'b1: data_out = '0;
      default : data_out = '0;
    endcase
  end

endmodule


