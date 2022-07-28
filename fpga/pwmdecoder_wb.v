
module pwmdecoder_wb #
(
    parameter DATA_WIDTH = 32,                    // width of data bus in bits (8, 16, 32, or 64)
    parameter ADDR_WIDTH = 32,                    // width of address bus in bits
    parameter SELECT_WIDTH = (DATA_WIDTH/8)       // width of word select bus (1, 2, 4, or 8)
)
(
    input wire i_clk,
    input wire i_rst,
    /*
     * Wishbone master input
     */
    input  wire [5:0]              wb_adr_i,     // ADR_I() address input
    input  wire [DATA_WIDTH-1:0]   wb_dat_i,     // DAT_I() data in
    output wire [DATA_WIDTH-1:0]   wb_dat_o,     // DAT_O() data out
    input  wire                    wb_we_i,      // WE_I write enable input
    input  wire [SELECT_WIDTH-1:0] wb_sel_i,     // SEL_I() select input
    input  wire                    wb_stb_i,     // STB_I strobe input
    output wire                    wb_ack_o,     // ACK_O acknowledge output
    output wire                    wb_err_o,     // ERR_O error output
    output wire                    wb_rty_o,     // RTY_O retry output
    input  wire                    wb_cyc_i     // CYC_I cycle input

);

reg [DATA_WIDTH-1:0]   lcl_wb_dat_o;     // DAT_O() data out
reg                    lcl_wb_ack_o, lcl_ack;     // ACK_O acknowledge output
reg                    lcl_wb_err_o;     // ERR_O error output
reg                    lcl_wb_rty_o;     // RTY_O retry output


reg [31:0]  pwm_0;
reg [31:0]  pwm_1;
reg [31:0]  pwm_2;
reg [31:0]  pwm_3;
reg [31:0]  pwm_4;
reg [31:0]  pwm_5;


initial begin
    lcl_wb_dat_o = 0;
    lcl_wb_ack_o = 0;
    lcl_wb_err_o = 0;
    lcl_wb_rty_o = 0;
    lcl_ack = 0;

    pwm_0 = 32'h11220044;
    pwm_1 = 32'h11221144;
    pwm_2  = 32'h2;
    pwm_3 = 32'h13;
    pwm_4 = 32'h5;
    pwm_5 = 32'h6;
end

always @* begin
        
         lcl_wb_ack_o <= wb_stb_i;  
         if ( wb_stb_i & wb_cyc_i)
        begin
            casez (wb_adr_i)
            5'h0: begin
                lcl_wb_dat_o = pwm_0;
            end

            5'h4: begin
                lcl_wb_dat_o = pwm_1;
            end

            5'h8: begin
                lcl_wb_dat_o = pwm_2;
            end

            5'h0C: begin
                lcl_wb_dat_o = pwm_3;
            end

            5'h10: begin
                lcl_wb_dat_o = pwm_4;
            end   

            5'h14: begin
                lcl_wb_dat_o = pwm_5;
            end 

            default:
                lcl_wb_dat_o = 32'hFFFFFFFF;
            endcase

        end


end
/*
    always @(posedge i_clk)
	    lcl_ack <= wb_stb_i;        

    always @(posedge i_clk)
	    lcl_wb_ack_o <= lcl_ack;        

    always @(posedge i_clk) begin
        if ( wb_stb_i & wb_cyc_i)
        begin
            casez (wb_adr_i)
            5'h0: begin
                lcl_wb_dat_o <= pwm_0;
            end

            5'h4: begin
                lcl_wb_dat_o <= pwm_1;
            end

            5'h8: begin
                lcl_wb_dat_o <= pwm_2;
            end

            5'h0C: begin
                lcl_wb_dat_o <= pwm_3;
            end

            5'h10: begin
                lcl_wb_dat_o <= pwm_4;
            end   

            5'h14: begin
                lcl_wb_dat_o <= pwm_5;
            end 
            endcase

        end
    end
*/

assign wb_dat_o = lcl_wb_dat_o;
assign wb_ack_o = lcl_wb_ack_o;
assign wb_err_o = lcl_wb_err_o;
assign wb_rty_o = lcl_wb_rty_o;

endmodule