
module toplevelbus 
(
    input wire        i_clk,
    input wire        i_reset,

    input wire [7:0]  i_axis_tdata,
    input wire        i_axis_tkeep,
    input wire        i_axis_tvalid,
    output wire        i_axis_tready,
    input wire        i_axis_tlast,
    input wire        i_axis_tuser,

    output wire [7:0]  o_axis_tdata,
    output wire        o_axis_tkeep,
    output wire        o_axis_tvalid,
    input wire        o_axis_tready,
    output wire        o_axis_tlast,
    output wire        o_axis_tuser,

    output wire       o_led_0,
    output wire       o_led_1,
    output wire       o_led_2,
    output wire       o_led_green,
    output wire       o_led_blue,
    output wire        o_led_red );

wire [31:0] m_wb_adr_o;   // ADR_O() address
wire [31:0]  m_wb_dat_i;   // DAT_I() data in
wire [31:0] m_wb_dat_o;   // DAT_O() data out
wire        m_wb_we_o;    // WE_O write enable output
wire [3:0]  m_wb_sel_o;   // SEL_O() select output
wire        m_wb_stb_o;   // STB_O strobe output
wire        m_wb_ack_i;   // ACK_I acknowledge input
wire        m_wb_err_i;   // ERR_I error input
wire        m_wb_cyc_o;   // CYC_O cycle output
wire o_busy;


axis_wb_master #( .IMPLICIT_FRAMING(1) ) wb_master (   .clk(i_clk),
                            .rst(i_reset),

                            .input_axis_tdata(i_axis_tdata),
                            .input_axis_tkeep(i_axis_tkeep),
                            .input_axis_tvalid(i_axis_tvalid),
                            .input_axis_tready(i_axis_tready),
                            .input_axis_tlast(),
                            .input_axis_tuser(i_axis_tuser),

                            .output_axis_tdata(o_axis_tdata),
                            .output_axis_tkeep(o_axis_tkeep),
                            .output_axis_tvalid(o_axis_tvalid),
                            .output_axis_tready(o_axis_tready),
                            .output_axis_tlast(o_axis_tlast),
                            .output_axis_tuser(o_axis_tuser),

                            .wb_adr_o(m_wb_adr_o),
                            .wb_dat_i(m_wb_dat_i),
                            .wb_dat_o(m_wb_dat_o),
                            .wb_we_o(m_wb_we_o), 
                            .wb_sel_o(m_wb_sel_o),
                            .wb_stb_o(m_wb_stb_o),
                            .wb_ack_i(m_wb_ack_i),
                            .wb_err_i(m_wb_err_i),
                            .wb_cyc_o(m_wb_cyc_o),

                          .busy(o_busy));

    

wire [31:0] pwm_wb_adr_o;   // ADR_O() address
wire [31:0]  pwm_wb_dat_i;   // DAT_I() data in
wire [31:0] pwm_wb_dat_o;   // DAT_O() data out
wire        pwm_wb_we_o;    // WE_O write enable output
wire [3:0]  pwm_wb_sel_o;   // SEL_O() select output
wire        pwm_wb_stb_o;   // STB_O strobe output
wire        pwm_wb_ack_i;   // ACK_I acknowledge input
wire        pwm_wb_err_i;   // ERR_I error input
wire        pwm_wb_cyc_o;   // CYC_O cycle output


wire [31:0] oneshot_wb_adr_o;   // ADR_O() address
wire [31:0] oneshot_wb_dat_i;   // DAT_I() data in
wire [31:0] oneshot_wb_dat_o;   // DAT_O() data out
wire        oneshot_wb_we_o;    // WE_O write enable output
wire [3:0]  oneshot_wb_sel_o;   // SEL_O() select output
wire        oneshot_wb_stb_o;   // STB_O strobe output
wire        oneshot_wb_ack_i;   // ACK_I acknowledge input
wire        oneshot_wb_err_i;   // ERR_I error input
wire        oneshot_wb_cyc_o;   // CYC_O cycle output


wire [31:0] led_wb_adr_o;   // ADR_O() address
wire [31:0] led_wb_dat_i;   // DAT_I() data in
wire [31:0] led_wb_dat_o;   // DAT_O() data out
wire        led_wb_we_o;    // WE_O write enable output
wire [3:0]  led_wb_sel_o;   // SEL_O() select output
wire        led_wb_stb_o;   // STB_O strobe output
wire        led_wb_ack_i;   // ACK_I acknowledge input
wire        led_wb_err_i;   // ERR_I error input
wire        led_wb_cyc_o;   // CYC_O cycle output

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
  .wbs0_adr_o(pwm_wb_adr_o),
  .wbs0_dat_i(pwm_wb_dat_o),
  .wbs0_dat_o(pwm_wb_dat_i),
  .wbs0_we_o(pwm_wb_we_o),
  .wbs0_sel_o(pwm_wb_sel_o),
  .wbs0_stb_o(pwm_wb_stb_o),
  .wbs0_ack_i(pwm_wb_ack_i),
  .wbs0_err_i(pwm_wb_err_i),
  .wbs0_rty_i(),
  .wbs0_cyc_o(pwm_wb_cyc_o),
  .wbs0_addr(32'hF),    
  .wbs0_addr_msk(32'hFF0),
.wbs1_adr_o(led_wb_adr_o),
.wbs1_dat_i(led_wb_dat_o),
.wbs1_dat_o(led_wb_dat_i),
.wbs1_we_o(led_wb_we_o), 
.wbs1_sel_o(led_wb_sel_o),
.wbs1_stb_o(led_wb_stb_o),
.wbs1_ack_i(led_wb_ack_i),
.wbs1_err_i(led_wb_err_i),
.wbs1_rty_i(),
.wbs1_cyc_o(led_wb_cyc_o),
.wbs1_addr(32'h10),   
.wbs1_addr_msk(32'hFFE));

led_wb  led(    .clk(i_clk),
  .rst(i_reset),
 .wb_adr_i(led_wb_adr_o), 
 .wb_dat_i(led_wb_dat_i), 
 .wb_dat_o(led_wb_dat_o), 
 .wb_we_i(led_wb_we_o),  
 .wb_sel_i(led_wb_sel_o), 
 .wb_stb_i(led_wb_stb_o), 
 .wb_ack_o(led_wb_ack_i), 
 .wb_err_o(led_wb_err_i), 
 .wb_rty_o(), 
 .wb_cyc_i(led_wb_cyc_o),
  .o_led_0(o_led_0),
  .o_led_1(o_led_1),
  .o_led_2(o_led_2),
  .o_led_green(o_green_0),
  .o_led_blue(o_blue_0),
  .o_led_red(o_red_0)    );

pwmdecoder_wb pwm(
    .i_clk(i_clk),
  .i_rst(i_reset),
 .wb_adr_i(pwm_wb_adr_o), 
 .wb_dat_i(pwm_wb_dat_i), 
 .wb_dat_o(pwm_wb_dat_o), 
 .wb_we_i(pwm_wb_we_o),  
 .wb_sel_i(pwm_wb_sel_o), 
 .wb_stb_i(pwm_wb_stb_o), 
 .wb_ack_o(pwm_wb_ack_i), 
 .wb_err_o(pwm_wb_err_i), 
 .wb_rty_o(), 
 .wb_cyc_i(pwm_wb_cyc_o));


endmodule