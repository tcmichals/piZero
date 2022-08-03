module axis_spi
(
    input wire axis_aclk,
    input wire axis_aresetn,

    input wire i_spi_clk,
    output wire o_spi_miso,
    input wire i_spi_mosi,
    input wire i_spi_cs,

    input wire [7:0]  s_axis_tdata,
    input wire        s_axis_tkeep,
    input wire        s_axis_tvalid,
    output wire        s_axis_tready,
    input wire        s_axis_tlast,
    input wire        s_axis_tuser,

    output wire [7:0]  m_axis_tdata,
    output wire        m_axis_tkeep,
    output wire        m_axis_tvalid,
    input wire        m_axis_tready,
    output wire        m_axis_tlast,
    output wire        m_axis_tuser
);

wire rx_ready_spi;




wire axis_tready;

assign m_axis_tlast = 1'b1;;
assign m_axis_tuser = 1'b1;
assign m_axis_tkeep = 1'b1;


assign m_axis_tvalid = rx_byte_spi & m_axis_tready;
assign s_axis_tready = rx_ready_spi & 


            

SPI_Slave spi(  .i_Rst_L(axis_aresetn),
                .i_Clk(axis_aclk),
                .o_RX_DV(rx_ready_spi),
                .o_RX_Byte(m_axis_tdata),
                .i_TX_DV(tx_write_spi),
                .i_TX_Byte(s_axis_tdata),
                .i_SPI_Clk(i_spi_clk),
                .o_SPI_MISO(o_spi_miso),
                .i_SPI_MOSI(i_spi_mosi),
                .i_SPI_CS_n(i_spi_cs)
 );

endmodule