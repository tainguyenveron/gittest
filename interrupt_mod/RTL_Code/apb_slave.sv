module apb_slave #(
  parameter ADDR_WIDTH   = 32,
  parameter DATA_WIDTH   = 32,
  parameter STRB_WIDTH   = DATA_WIDTH / 8,
  parameter PARITY_WIDTH =  4,
  parameter UPPER_DEPTH  = 16,
  parameter LOWER_DEPTH  =  0,
  parameter WAIT_CYCLE   =  2  
)(
  // Input declaration
  input  logic                    PCLK       ,    // APB clock signal
  input  logic                    PRESETn    ,    // Active-low reset signal
  input  logic                    PSEL       ,    // Slave select signal
  input  logic                    PENABLE    ,    // Enable signal for APB transaction (n cycle)
  input  logic                    PWRITE     ,    // Write enable signal (1: Write, 0: Read)
  input  logic [ADDR_WIDTH-1:0]   PADDR      ,    // Address sent to slave
  input  logic [DATA_WIDTH-1:0]   PWDATA     ,    // Data sent to slave for write
  input  logic [STRB_WIDTH-1:0]   PSTRB      ,    // Write strobe bit from master for PWDATA
  input  logic                    PSTRBCHK   ,    // Parity bit from master for PSTRB
  input  logic [PARITY_WIDTH-1:0] PADDRCHK   ,    // Parity bit from master for PADDR
  input  logic [PARITY_WIDTH-1:0] PWDATACHK  ,    // Parity bit from master for PWDATA
   
  // Output declaration
  output logic                    PREADY     ,    // Slave ready signal
  output logic                    PSLVERR    ,    // Slave error signal
  output logic [DATA_WIDTH-1:0]   PRDATA     ,    // Read data from slave
  output logic [PARITY_WIDTH-1:0] PRDATACHK  ,     // Parity bit from slave for PRDATA

  // Signal to IP 
  output logic [ADDR_WIDTH-1:0]   PADDR_ip   ,
  output logic                    PCLK_ip    ,
  output logic                    PRESETn_ip ,
  output logic [DATA_WIDTH-1:0]   PWDATA_ip  ,
  output logic                    write_en_ip,
  input  logic [DATA_WIDTH-1:0]   PRDATA_ip  
);

genvar i;

//Parity internal logics for parity check from master to slave
logic [PARITY_WIDTH-1:0]  paddr_parity_reg      ;
logic [PARITY_WIDTH-1:0]  paddr_parity_internal ;
logic [PARITY_WIDTH-1:0]  PADDRCHK_mas          ;
logic                     parity_check_en       ;
logic [PARITY_WIDTH-1:0]  PWDATACHK_mas         ;
logic [PARITY_WIDTH-1:0]  pwdata_parity_reg     ;
logic [PARITY_WIDTH-1:0]  pwdata_parity_internal;
logic                     pstrb_parity_reg      ;
logic                     pstrb_parity_internal ;
logic [PARITY_WIDTH-1:0]  PARITYCHK             ;
logic [STRB_WIDTH-1:0]    pstrb_byte_mask       ;
logic [DATA_WIDTH-1:0]    pwdata_done           ;
logic                     access                ;
logic [WAIT_CYCLE-1:0]    wait_counter          ;
logic [DATA_WIDTH-1:0]    prdata_reg            ;
logic [DATA_WIDTH-1:0]    prdata_hold           ;
logic                     align_check           ;
logic                     ram_en                ;
logic                     addr_error            ;
logic                     pslverr_logic         ;
logic                     pslverr_hold          ;
logic                     pre_ready             ;
logic [PARITY_WIDTH-1:0]  prdata_parity_reg     ;    
//============================================================
//              INTERNAL SIGNAL ASSIGNMENTS                 
//============================================================
assign parity_check_en = PSEL & PWRITE;
assign pstrb_byte_mask = PSTRB & {4{PWRITE}};
assign access          = PSEL & PENABLE;
assign PARITYCHK       = paddr_parity_internal|pwdata_parity_internal;
assign align_check     = ~(PADDR[0]|PADDR[1]);
assign paritychk_bit   = |PARITYCHK;
assign ram_en          = PWRITE & access & !addr_error & align_check;
assign prdata_hold     = align_check&&!addr_error? prdata_reg : '0;
assign addr_error      = (PADDR[ADDR_WIDTH-3:0] < LOWER_DEPTH)|(PADDR[ADDR_WIDTH-3:0] > UPPER_DEPTH);
assign pslverr_logic   = addr_error           |
                         paritychk_bit        |
                         pstrb_parity_internal|
                         !align_check;
//Interconnect to IP
assign PADDR_ip    = PADDR;
assign PCLK_ip     = PCLK ;
assign PRESETn_ip  = PRESETn;
assign PWDATA_ip   = pwdata_done;
assign write_en_ip = ram_en;
assign prdata_reg  = PRDATA_ip;
//============================================================
//              MASTER TO SLAVE ARITY CHECK                 
//============================================================
//ADDR parity check from mas
parity_check_ODD #(
    .DATA_WIDTH  (ADDR_WIDTH),
    .PARITY_WIDTH(PARITY_WIDTH)
) parity_addr_src_check (
    .i_clk(PCLK),
    .i_rst_n(PRESETn),
    .i_en(PSEL),
    .i_data(PADDR),
    .o_data(paddr_parity_reg)
);

always_ff @(posedge PCLK or negedge PRESETn) begin
  if(!PRESETn)
    PADDRCHK_mas <= '0;
  else if(PSEL)
    PADDRCHK_mas <= PADDRCHK;
end

assign paddr_parity_internal = paddr_parity_reg ^ PADDRCHK_mas;
//PWDATA parity check from mas
parity_check_ODD #(
    .DATA_WIDTH  (DATA_WIDTH),
    .PARITY_WIDTH(PARITY_WIDTH)
) parity_pwdata_src_check (
    .i_clk(PCLK),
    .i_rst_n(PRESETn),
    .i_en(parity_check_en),
    .i_data(PWDATA),
    .o_data(pwdata_parity_reg)
);

always_ff @(posedge PCLK or negedge PRESETn) begin
  if(!PRESETn)
    PWDATACHK_mas <= '0;
  else if(parity_check_en)
    PWDATACHK_mas <= PWDATACHK;
  else;
end

assign pwdata_parity_internal = (pwdata_parity_reg ^ PWDATACHK_mas)&
                                {PARITY_WIDTH{parity_check_en}};
//PSTRB parity check from mas
parity_check_ODD #(
    .DATA_WIDTH  (STRB_WIDTH),
    .PARITY_WIDTH('1)
) parity_pstrb_src_check (
    .i_clk(PCLK),
    .i_rst_n(PRESETn),
    .i_en(parity_check_en),
    .i_data(PSTRB),
    .o_data(pstrb_parity_reg)
);

assign pstrb_parity_internal = (pstrb_parity_reg ^ PSTRBCHK)&(parity_check_en);
//============================================================
//       APB SLAVE COMBINATIONAL AND SEQUENTIAL LOGICS       
//============================================================
generate 
for(i = 0; i < STRB_WIDTH; i = i + 1) begin: gen_masking_block
 assign pwdata_done[i*8 +: 8] =  pstrb_byte_mask[i]? PWDATA[i*8 +: 8]:
                                                  prdata_reg[i*8 +: 8];
end
endgenerate

generate
if(WAIT_CYCLE>1) begin: wait_state_larger_than_1
  always_ff @(posedge PCLK or negedge PRESETn) begin
    if (!PRESETn) begin
      wait_counter <= '0;
    end else begin
        wait_counter <= {wait_counter[WAIT_CYCLE-2:0]&{(WAIT_CYCLE-1){PENABLE}}, access};
		  end
  end
  assign pre_ready    = wait_counter[WAIT_CYCLE - 2]&access;
  assign PREADY       = wait_counter[WAIT_CYCLE - 1];
end 
else if(WAIT_CYCLE==1) begin: wait_statPRDATA_ipe_equal_1
  always_ff @(posedge PCLK or negedge PRESETn) begin
    if (!PRESETn) begin
      wait_counter <= '0;
    end else begin
      if (!PENABLE) begin
        wait_counter <= '0;
      end else begin
        wait_counter <= access;
		  end
    end
  end
  assign pre_ready    = access;
  assign PREADY       = wait_counter;
 end
else begin
  assign PREADY    = access;
  assign pre_ready = PSEL;
  end
endgenerate

//apb_slave_ram #(
//  .ADDR_WIDTH(ADDR_WIDTH),
//  .DATA_WIDTH(DATA_WIDTH),
//  .DEPTH     (DEPTH     )
//) ram_inst (
//  .PCLK   (PCLK       ),
//  .ram_en (ram_en     ),
//  .PRESETn(PRESETn    ),
//  .PADDR  (PADDR      ),
//  .PWDATA (pwdata_done),
//  .PRDATA (prdata_reg )
//);

always_ff @(posedge PCLK or negedge PRESETn) begin
  if(!PRESETn)
    PRDATA <= '0;
  else if(!PWRITE&pre_ready)
    PRDATA <= prdata_hold;
end

generate
if(WAIT_CYCLE>0) begin
always_ff @(posedge PCLK or negedge PRESETn) begin
  if(!PRESETn)
    pslverr_hold <= '0;
  else 
    pslverr_hold <= pslverr_logic;
 end
assign PSLVERR = PREADY & pslverr_hold;
end
else assign  PSLVERR = PREADY & pslverr_logic;
endgenerate

//============================================================
//              SLAVE TO MASTER PARITY CHECK                 
//============================================================
//PRDATA parity check from slv
parity_check_ODD #(
    .DATA_WIDTH  (DATA_WIDTH),
    .PARITY_WIDTH(PARITY_WIDTH)
) parity_prdata_slv_check (
    .i_clk(PCLK),
    .i_rst_n(PRESETn),
    .i_en(!PWRITE),
    .i_data(prdata_reg),
    .o_data(prdata_parity_reg)
);
assign PRDATACHK = prdata_parity_reg&{DATA_WIDTH{PREADY}}&{DATA_WIDTH{access}};

endmodule: apb_slave
