module enable_write #(
    parameter ADDR_WIDTH = 32    
)(
    input  logic         wren,
    input  logic [31:0] addr,
    output logic [19:0] addr_dec
);
    localparam ADDR_BASE = 32'h0009_0000;
    localparam BASE      = {19'b0, 1'b1};
    logic [19:0] addr_temp;
    always_comb begin : address_decoder
	addr_temp = 20'b0;
        case(addr)
            ADDR_BASE + 8'h00: addr_temp = BASE;    
            ADDR_BASE + 8'h04: addr_temp = BASE << 1;   
            ADDR_BASE + 8'h08: addr_temp = BASE << 2;   
            ADDR_BASE + 8'h0C: addr_temp = BASE << 3;     
            ADDR_BASE + 8'h10: addr_temp = BASE << 4;     
            ADDR_BASE + 8'h14: addr_temp = BASE << 5;    
            ADDR_BASE + 8'h18: addr_temp = BASE << 6;    
            ADDR_BASE + 8'h1C: addr_temp = BASE << 7;    
            ADDR_BASE + 8'h20: addr_temp = BASE << 8;    
            ADDR_BASE + 8'h24: addr_temp = BASE << 9;     
            ADDR_BASE + 8'h28: addr_temp = BASE << 10;    
            ADDR_BASE + 8'h2C: addr_temp = BASE << 11;    
            ADDR_BASE + 8'h30: addr_temp = BASE << 12;    
            ADDR_BASE + 8'h34: addr_temp = BASE << 13;    
            ADDR_BASE + 8'h38: addr_temp = BASE << 14;    
            ADDR_BASE + 8'h3C: addr_temp = BASE << 15;    
            ADDR_BASE + 8'h40: addr_temp = BASE << 16;    
            ADDR_BASE + 8'h44: addr_temp = BASE << 17;    
            ADDR_BASE + 8'h48: addr_temp = BASE << 18;    
            ADDR_BASE + 8'h4C: addr_temp = BASE << 19;
            default: addr_temp = 20'b0;
        endcase
    end
    assign addr_dec = addr_temp & {20{wren}}; 
endmodule : enable_write
