module twoport_wrapper #
(
    parameter DATA_WIDTH = 32,                    // width of data bus in bits (8, 16, 32, or 64)
    parameter ADDR_WIDTH = 32,                    // width of address bus in bits
    parameter SELECT_WIDTH = (DATA_WIDTH/8)       // width of word select bus (1, 2, 4, or 8)
)
(
    input  wire                    clk,
    input  wire                    rst,

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
     * Wishbone slave 0 output
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
     * Wishbone slave 1 output
     */
    output wire [ADDR_WIDTH-1:0]   counter_adr_o,    // ADR_O() address output
    input  wire [DATA_WIDTH-1:0]   counter_dat_i,    // DAT_I() data in
    output wire [DATA_WIDTH-1:0]   counter_dat_o,    // DAT_O() data out
    output wire                    counter_we_o,     // WE_O write enable output
    output wire [SELECT_WIDTH-1:0] counter_sel_o,    // SEL_O() select output
    output wire                    counter_stb_o,    // STB_O strobe output
    input  wire                    counter_ack_i,    // ACK_I acknowledge input
    input  wire                    counter_err_i,    // ERR_I error input
    input  wire                    counter_rty_i,    // RTY_I retry input
    output wire                    counter_cyc_o    // CYC_O cycle output

);


wishbone_mux mux(
  .clk(i_clk),
  .rst(i_reset),
  .wbm_adr_i(m_wb_adr_o),
  .wbm_dat_i(m_wb_dat_o),
  .wbm_dat_o(m_wb_dat_i),
  .wbm_we_i(m_wb_we_o), 
  .wbm_sel_i(m_wb_sel_o),
  .wbm_stb_i(m_wb_stb_o),
  .wbm_ack_o(m_wb_ack_i),
  .wbm_err_o(m_wb_err_i),
  .wbm_rty_o(),
  .wbm_cyc_i(m_wb_cyc_o),
  .wbs0_adr_o(led_wb_adr_o),
  .wbs0_dat_i(led_wb_dat_o),
  .wbs0_dat_o(led_wb_dat_i),
  .wbs0_we_o(led_wb_we_o),
  .wbs0_sel_o(led_wb_sel_o),
  .wbs0_stb_o(led_wb_stb_o),
  .wbs0_ack_i(led_wb_ack_i),
  .wbs0_err_i(led_wb_err_i),
  .wbs0_rty_i(),
  .wbs0_cyc_o(led_wb_cyc_o),
  .wbs0_addr(32'hF),    
  .wbs0_addr_msk(32'hFF0),
.wbs1_adr_o(counter_wb_adr_o),
.wbs1_dat_i(counter_wb_dat_o),
.wbs1_dat_o(counter_wb_dat_i),
.wbs1_we_o(counter_wb_we_o), 
.wbs1_sel_o(counter_wb_sel_o),
.wbs1_stb_o(counter_wb_stb_o),
.wbs1_ack_i(counter_wb_ack_i),
.wbs1_err_i(counter_wb_err_i),
.wbs1_rty_i(),
.wbs1_cyc_o(counter_wb_cyc_o),
.wbs1_addr(32'h10),   
.wbs1_addr_msk(32'hFFE));

endmodule
