
module oneshot_wb #
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
    input  wire [ADDR_WIDTH-1:0]   wbm_adr_i,     // ADR_I() address input
    input  wire [DATA_WIDTH-1:0]   wbm_dat_i,     // DAT_I() data in
    output wire [DATA_WIDTH-1:0]   wbm_dat_o,     // DAT_O() data out
    input  wire                    wbm_we_i,      // WE_I write enable input
    input  wire [SELECT_WIDTH-1:0] wbm_sel_i,     // SEL_I() select input
    input  wire                    wbm_stb_i,     // STB_I strobe input
    output wire                    wbm_ack_o,     // ACK_O acknowledge output
    output wire                    wbm_err_o,     // ERR_O error output
    output wire                    wbm_rty_o,     // RTY_O retry output
    input  wire                    wbm_cyc_i     // CYC_I cycle input

);

reg [DATA_WIDTH-1:0]   lcl_wbm_dat_o;     // DAT_O() data out
reg                    lcl_wbm_ack_o;     // ACK_O acknowledge output
reg                    lcl_wbm_err_o;     // ERR_O error output
reg                    lcl_wbm_rty_o;     // RTY_O retry output
reg                    lcl_ack;

reg [31:0]  pwm_0;
reg [31:0]  pwm_1;
reg [31:0]  pwm_2;
reg [31:0]  pwm_3;
reg [31:0]  pwm_4;
reg [31:0]  pwm_5;

initial begin
    lcl_wbm_dat_o = 0;
    lcl_wbm_ack_o = 0;
    lcl_wbm_err_o = 0;
    lcl_wbm_rty_o = 0;
    lcl_ack = 0;

    pwm_0 = 0;
    pwm_1 = 32'h1;
    pwm_2  = 32'h2;
    pwm_3 = 32'h13;
    pwm_4 = 32'h5;
    pwm_5 = 32'h6;
end


    always @(posedge i_clk) begin
        if ( wbm_stb_i & wbm_cyc_i & ~wbm_we_i & ~lcl_ack)
        begin
            lcl_ack <= 1'b1;

            case (wbm_adr_i & 32'h0FF)
            32'h0: begin
                lcl_wbm_dat_o <= pwm_0;
            end

            32'h4: begin
                lcl_wbm_dat_o <= pwm_1;
            end

            32'h8: begin
                lcl_wbm_dat_o <= pwm_2;
            end

            32'h0C: begin
                lcl_wbm_dat_o <= pwm_3;
            end

            32'h10: begin
                lcl_wbm_dat_o <= pwm_4;
            end   

            32'h14: begin
                lcl_wbm_dat_o <= pwm_5;
            end 
            endcase

        end
        else if (lcl_ack) begin
            lcl_ack <= 1'b0;
        end
end    

assign wbm_dat_o = lcl_wbm_dat_o;
assign wbm_ack_o = lcl_ack;
assign wbm_err_o = lcl_wbm_err_o;
assign wbm_rty_o = lcl_wbm_rty_o;

endmodule