`default_nettype none
`timescale 1 ns / 1 ns

module pwmdecoder_wb #
    (
    parameter clockFreq = 100_000_000,
    parameter DATA_WIDTH = 32,                    // width of data bus in bits (8, 16, 32, or 64)
    parameter ADDR_WIDTH = 32,                    // width of address bus in bits
    parameter SELECT_WIDTH = (DATA_WIDTH/8)       // width of word select bus (1, 2, 4, or 8)
)
(
    input wire i_clk,
    input wire i_rstn,
    /*
     * Wishbone master input
     */
    input  wire [ADDR_WIDTH-1:0]              wb_adr_i,     // ADR_I() address input
    input  wire [DATA_WIDTH-1:0]   wb_dat_i,     // DAT_I() data in
    output wire [DATA_WIDTH-1:0]   wb_dat_o,     // DAT_O() data out
    input  wire                    wb_we_i,      // WE_I write enable input
    input  wire [SELECT_WIDTH-1:0] wb_sel_i,     // SEL_I() select input
    input  wire                    wb_stb_i,     // STB_I strobe input
    output wire                    wb_ack_o,     // ACK_O acknowledge output
    output wire                    wb_err_o,     // ERR_O error output
    output wire                    wb_rty_o,     // RTY_O retry output
    input  wire                    wb_cyc_i,     // CYC_I cycle input

    /* pwm input signals */
    input wire i_pwm_0,
    input wire i_pwm_1,
    input wire i_pwm_2,
    input wire i_pwm_3,
    input wire i_pwm_4,
    input wire i_pwm_5
);

reg [DATA_WIDTH-1:0]   lcl_wb_dat_o;     // DAT_O() data out
reg                    lcl_wb_ack_o;

wire pwm_ready_0;
wire [15:0] pwm_value_0;
wire [15:0] pwm_value_1;
wire [15:0] pwm_value_2;
wire [15:0] pwm_value_3;
wire [15:0] pwm_value_4;
wire [15:0] pwm_value_5;

initial begin
    lcl_wb_dat_o = 0;
    lcl_wb_ack_o = 0;
end

always @(posedge i_clk) begin

    if ( wb_stb_i & wb_cyc_i)
        begin
            casez (wb_adr_i)
            5'h0: begin
                lcl_wb_dat_o <= { 16'h0, pwm_value_0};
            end

            5'h4: begin
                lcl_wb_dat_o <= { 16'h0, pwm_value_1};
            end

            5'h8: begin
                lcl_wb_dat_o <= { 16'h0,  pwm_value_2};
            end

            5'h0C: begin
                lcl_wb_dat_o <= { 16'h0, pwm_value_3};
            end

            5'h10: begin
                lcl_wb_dat_o <= { 16'h0, pwm_value_4};
            end   

            5'h14: begin
                lcl_wb_dat_o <= { 16'h0, pwm_value_5};
            end 

            default:
                lcl_wb_dat_o = 32'hFFFFFFFF;
            endcase
        end
end
   

pwmdecoder #(.clockFreq(clockFreq)) pwmDecoder_0  (.i_clk(i_clk),
                        .i_pwm(i_pwm_0),
                        .i_resetn(i_rstn),
                        .o_pwm_ready(),
                        .o_pwm_value(pwm_value_0));   

pwmdecoder #(.clockFreq(clockFreq)) pwmDecoder_1 (.i_clk(i_clk),
                        .i_pwm(i_pwm_1),
                        .i_resetn(i_rstn),
                        .o_pwm_ready(),
                        .o_pwm_value(pwm_value_1));   

pwmdecoder #(.clockFreq(clockFreq)) pwmDecoder_2 
                        (.i_clk(i_clk),
                        .i_pwm(i_pwm_2),
                        .i_resetn(i_rstn),
                        .o_pwm_ready(),
                        .o_pwm_value(pwm_value_2));   

pwmdecoder #(.clockFreq(clockFreq)) pwmDecoder_3 
                        (.i_clk(i_clk),
                        .i_pwm(i_pwm_3),
                        .i_resetn(i_rstn),
                        .o_pwm_ready(),
                        .o_pwm_value(pwm_value_3));   

pwmdecoder #(.clockFreq(clockFreq)) pwmDecoder_4 
                        (.i_clk(i_clk),
                        .i_pwm(i_pwm_4),
                        .i_resetn(i_rstn),
                        .o_pwm_ready(),
                        .o_pwm_value(pwm_value_4));   

pwmdecoder #(.clockFreq(clockFreq)) pwmDecoder_5
                        (.i_clk(i_clk),
                        .i_pwm(i_pwm_5),
                        .i_resetn(i_rstn),
                        .o_pwm_ready(),
                        .o_pwm_value(pwm_value_5));   

                                                                                                                                                

always @(posedge i_clk) begin
if ( wb_stb_i & wb_cyc_i & ~lcl_wb_ack_o)
    begin
        lcl_wb_ack_o <= 1'b1;
    end
    else begin
        lcl_wb_ack_o <= 1'b0;
    end
end


assign wb_dat_o = lcl_wb_dat_o;
assign wb_ack_o = lcl_wb_ack_o;
assign wb_err_o = 1'b0;
assign wb_rty_o = 1'b0;

endmodule