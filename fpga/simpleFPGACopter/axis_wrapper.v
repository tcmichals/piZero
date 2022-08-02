
module axis_wrapper
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

    output wire [31:0] m_wb_adr_o,   // ADR_O() address
    input wire [31:0]  m_wb_dat_i,   // DAT_I() data in
    output wire [31:0] m_wb_dat_o,   // DAT_O() data out
    output wire        m_wb_we_o,    // WE_O write enable output
    output wire [3:0]  m_wb_sel_o,   // SEL_O() select output
    output wire        m_wb_stb_o,   // STB_O strobe output
    input wire        m_wb_ack_i,   // ACK_I acknowledge input
    input wire        m_wb_err_i,   // ERR_I error input
    output wire        m_wb_cyc_o,   // CYC_O cycle output
    output wire        o_busy
);



axis_wb_master #( .IMPLICIT_FRAMING(1) )
                 wb_master (.clk(i_clk),
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
endmodule
