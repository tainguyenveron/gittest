module interrupt_registers (
    input  logic clk,
    input  logic rst_n,
    input  logic [19:0] addr_dec,
    input  logic [31:0] PWDATA,
    output logic [31:0] INTCR_dataout, 
    output logic [31:0] ISCRH_dataout,
    output logic [31:0] ISCRL_dataout,
    output logic [31:0] IER_dataout,
    output logic [31:0] IPRA_dataout,
    output logic [31:0] IPRB_dataout,
    output logic [31:0] IPRC_dataout,
    output logic [31:0] IPRD_dataout,
    output logic [31:0] IPRE_dataout,
    output logic [31:0] IPRF_dataout,
    output logic [31:0] IPRG_dataout,
    output logic [31:0] IPRH_dataout,
    output logic [31:0] IPRI_dataout,
    output logic [31:0] IPRJ_dataout,
    output logic [31:0] IPRK_dataout,
    output logic [31:0] IPRL_dataout,
    output logic [31:0] IPRM_dataout,
    output logic [31:0] IPRN_dataout,
    output logic [31:0] ITSR_dataout
);
    logic [31:0] INTCR_data;  
    logic [31:0] ISCRH_data;
    logic [31:0] ISCRL_data;
    logic [31:0] IER_data  ;
    logic [31:0] IPR_data  ;
    logic [31:0] ITSR_data ;

    assign INTCR_data = {26'b0, PWDATA[5:3], 3'b0};
    assign ISCRH_data = {16'b0, PWDATA[15:0]};
    assign ISCRL_data = {16'b0, PWDATA[15:0]};
    assign IER_data   = {16'b0, PWDATA[15:0]};
    assign IPR_data   = {17'b0, PWDATA[14:12], 1'b0, PWDATA[10:8], 1'b0, PWDATA[6:4], 1'b0, PWDATA[2:0]};
    assign ITSR_data  = {16'b0, PWDATA[15:0]};   
    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
	    INTCR_dataout <= 32'b0;
	end else if(addr_dec[0]) begin
	    INTCR_dataout <= INTCR_data; 
	end else begin
	    INTCR_dataout <= INTCR_dataout;
	end
    end
    
    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
	    ISCRH_dataout <= 32'b0;
	end else if(addr_dec[1]) begin
	    ISCRH_dataout <= ISCRH_data; 
	end else begin
	    ISCRH_dataout <= ISCRH_dataout;
	end
    end


    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
	    ISCRL_dataout <= 32'b0;
	end else if(addr_dec[2]) begin
	    ISCRL_dataout <= ISCRL_data;
	end else begin
	    ISCRL_dataout <= ISCRL_dataout;
	end
    end   
    
    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
	    IER_dataout <= 32'b0;
	end else if(addr_dec[3]) begin
	    IER_dataout <= IER_data;
	end else begin
	    IER_dataout <= IER_dataout;
	end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
	    ITSR_dataout <= 32'b0;
	end else if(addr_dec[5]) begin
	    ITSR_dataout <= ITSR_data;
	end else begin
	    ITSR_dataout <= ITSR_dataout;
	end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
	    IPRA_dataout <= 32'b0;
	end else if(addr_dec[6]) begin
	    IPRA_dataout <= IPR_data;
	end else begin
	    IPRA_dataout <= IPRA_dataout;
	end
    end


    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
	    IPRB_dataout <= 32'b0;
	end else if(addr_dec[7]) begin
	    IPRB_dataout <= IPR_data;
	end else begin
	    IPRB_dataout <= IPRB_dataout;
	end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
	    IPRC_dataout <= 32'b0;
	end else if(addr_dec[8]) begin
	    IPRC_dataout <= IPR_data;
	end else begin
	    IPRC_dataout <= IPRC_dataout;
	end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
	    IPRD_dataout <= 32'b0;
	end else if(addr_dec[9]) begin
	    IPRD_dataout <= IPR_data;
	end else begin
	    IPRD_dataout <= IPRD_dataout;
	end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
	    IPRE_dataout <= 32'b0;
	end else if(addr_dec[10]) begin
	    IPRE_dataout <= IPR_data;
	end else begin
	    IPRE_dataout <= IPRE_dataout;
	end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
	    IPRF_dataout <= 32'b0;
	end else if(addr_dec[11]) begin
	    IPRF_dataout <= IPR_data;
	end else begin
	    IPRF_dataout <= IPRF_dataout;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
	    IPRG_dataout <= 32'b0;
	end else if(addr_dec[12]) begin
	    IPRG_dataout <= IPR_data;
	end else begin
	    IPRG_dataout <= IPRG_dataout;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
	    IPRH_dataout <= 32'b0;
	end else if(addr_dec[13]) begin
	    IPRH_dataout <= IPR_data;
	end else begin
	    IPRH_dataout <= IPRH_dataout;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
	    IPRI_dataout <= 32'b0;
	end else if(addr_dec[14]) begin
	    IPRI_dataout <= IPR_data;
	end else begin
	    IPRI_dataout <= IPRI_dataout;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
	    IPRJ_dataout <= 32'b0;
	end else if(addr_dec[15]) begin
	    IPRJ_dataout <= IPR_data;
	end else begin
	    IPRJ_dataout <= IPRJ_dataout;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
	    IPRK_dataout <= 32'b0;
	end else if(addr_dec[16]) begin
	    IPRK_dataout <= IPR_data;
	end else begin
	    IPRK_dataout <= IPRK_dataout;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
	    IPRL_dataout <= 32'b0;
	end else if(addr_dec[17]) begin
	    IPRL_dataout <= IPR_data;
	end else begin
	    IPRL_dataout <= IPRL_dataout;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
	    IPRM_dataout <= 32'b0;
	end else if(addr_dec[18]) begin
	    IPRM_dataout <= IPR_data;
	end else begin
	    IPRM_dataout <= IPRM_dataout;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
	    IPRN_dataout <= 32'b0;
	end else if(addr_dec[19]) begin
	    IPRN_dataout <= IPR_data;
	end else begin
	    IPRN_dataout <= IPRN_dataout;
	end
    end
endmodule
