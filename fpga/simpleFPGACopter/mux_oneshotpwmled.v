
module mux_oneshotpwmled #
(
    parameter DATA_WIDTH = 32,                    // width of data bus in bits (8, 16, 32, or 64)
    parameter ADDR_WIDTH = 32,                    // width of address bus in bits
    parameter SELECT_WIDTH = (DATA_WIDTH/8)       // width of word select bus (1, 2, 4, or 8)
)
(
    input  wire                    clk,
    input  wire                    rstn,

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
    input  wire                    wbm_cyc_i,     // CYC_I cycle input


    /*
     * Wishbone LED controller output
     */
    output wire [ADDR_WIDTH-1:0]   led_adr_o,    // ADR_O() address output
    input  wire [DATA_WIDTH-1:0]   led_dat_i,    // DAT_I() data in
    output wire [DATA_WIDTH-1:0]   led_dat_o,    // DAT_O() data out
    output wire                    led_we_o,     // WE_O write enable output
    output wire [SELECT_WIDTH-1:0] led_sel_o,    // SEL_O() select output
    output wire                    led_stb_o,    // STB_O strobe output
    input  wire                    led_ack_i,    // ACK_I acknowledge input
    input  wire                    led_err_i,    // ERR_I error input
    input  wire                    led_rty_i,    // RTY_I retry input
    output wire                    led_cyc_o,    // CYC_O cycle output


    /*
     * Wishbone PWM Decoder 1 output
     */
    output wire [ADDR_WIDTH-1:0]   pwmdecoder_adr_o,    // ADR_O() address output
    input  wire [DATA_WIDTH-1:0]   pwmdecoder_dat_i,    // DAT_I() data in
    output wire [DATA_WIDTH-1:0]   pwmdecoder_dat_o,    // DAT_O() data out
    output wire                    pwmdecoder_we_o,     // WE_O write enable output
    output wire [SELECT_WIDTH-1:0] pwmdecoder_sel_o,    // SEL_O() select output
    output wire                    pwmdecoder_stb_o,    // STB_O strobe output
    input  wire                    pwmdecoder_ack_i,    // ACK_I acknowledge input
    input  wire                    pwmdecoder_err_i,    // ERR_I error input
    input  wire                    pwmdecoder_rty_i,    // RTY_I retry input
    output wire                    pwmdecoder_cyc_o,    // CYC_O cycle output

    /*
     * Wishbone OneShot 1 output
     */
    output wire [ADDR_WIDTH-1:0]   oneshot_adr_o,    // ADR_O() address output
    input  wire [DATA_WIDTH-1:0]   oneshot_dat_i,    // DAT_I() data in
    output wire [DATA_WIDTH-1:0]   oneshot_dat_o,    // DAT_O() data out
    output wire                    oneshot_we_o,     // WE_O write enable output
    output wire [SELECT_WIDTH-1:0] oneshot_sel_o,    // SEL_O() select output
    output wire                    oneshot_stb_o,    // STB_O strobe output
    input  wire                    oneshot_ack_i,    // ACK_I acknowledge input
    input  wire                    oneshot_err_i,    // ERR_I error input
    input  wire                    oneshot_rty_i,    // RTY_I retry input
    output wire                    oneshot_cyc_o  
);

threeport_mux mux( .clk(clk),
            .rst(rstn),
            .wbm_adr_i(wbm_adr_i),
            .wbm_dat_i(wbm_dat_i),
            .wbm_dat_o(wbm_dat_o),
            .wbm_we_i(wbm_we_i),
            .wbm_sel_i(wbm_sel_i),
            .wbm_stb_i(wbm_stb_i),
            .wbm_ack_o(wbm_ack_o),
            .wbm_err_o(wbm_err_o),
            .wbm_rty_o(wbm_rty_o),
            .wbm_cyc_i(wbm_cyc_i),
            //LED controller
            .wbs0_adr_o(led_adr_o),
            .wbs0_dat_i(led_dat_i),
            .wbs0_dat_o(led_dat_o),
            .wbs0_we_o(led_we_o),
            .wbs0_sel_o(led_sel_o),
            .wbs0_stb_o(led_stb_o),
            .wbs0_ack_i(led_ack_i),
            .wbs0_err_i(led_err_i),
            .wbs0_rty_i(led_rty_i),
            .wbs0_cyc_o(led_cyc_o),
            .wbs0_addr(32'h0000_00FF),
            .wbs0_addr_msk(32'hFFFF_FF00),

            //PWM controller
            .wbs1_adr_o(pwmdecoder_adr_o),
            .wbs1_dat_i(pwmdecoder_dat_i),
            .wbs1_dat_o(pwmdecoder_dat_o),
            .wbs1_we_o(pwmdecoder_we_o),
            .wbs1_sel_o(pwmdecoder_sel_o),
            .wbs1_stb_o(pwmdecoder_stb_o),
            .wbs1_ack_i(pwmdecoder_ack_i),
            .wbs1_err_i(pwmdecoder_err_i),
            .wbs1_rty_i(pwmdecoder_rty_i),
            .wbs1_cyc_o(pwmdecoder_cyc_o),
            .wbs1_addr(32'h0000_01FF),
            .wbs1_addr_msk(32'hFFFF_FE00),

            //OneShot controller
            .wbs2_adr_o(oneshot_adr_o),
            .wbs2_dat_i(oneshot_dat_i),
            .wbs2_dat_o(oneshot_dat_o),
            .wbs2_we_o(oneshot_we_o),
            .wbs2_sel_o(oneshot_sel_o),
            .wbs2_stb_o(oneshot_stb_o),
            .wbs2_ack_i(oneshot_ack_i),
            .wbs2_err_i(oneshot_err_i),
            .wbs2_rty_i(oneshot_rty_i),
            .wbs2_cyc_o(oneshot_cyc_o),
            .wbs2_addr(32'h0000_03FF),
        .wbs2_addr_msk(32'hFFFF_FC00));


endmodule



