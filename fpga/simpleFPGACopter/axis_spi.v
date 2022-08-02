module axis_spi
(
    input wire i_clk,
    input wire i_reset,

    input wire i_spi_clk,
    output wire o_spi_miso,
    input wire i_spi_mosi,
    input wire i_spi_cs,

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
    output wire        o_axis_tuser
);


assign o_axis_tkeep = 1'b1;
assign o_axis_tuser = 1'b1;

wire rt_fifo_empty;
wire rx_spi_byte_ready;
wire [7:0] rx_spi_byte;

wire i_axis_tready;

assign  rx_spi_byte_ready = ~rt_fifo_empty & o_axis_tready;
assign o_axis_tlast = rt_fifo_empty;
assign o_axis_tvalid = rx_spi_byte_ready;

FIFO spi_rx (.i_Rst_L(i_reset),
            .i_Clk(i_clk),
            .i_Wr_DV(spi_rx_ready),
            .i_Wr_Data(spi_rx_byte),
            .i_AF_Level(),
            .o_AF_Flag(),
            .o_Full(),
            .i_Rd_En(),
            .o_Rd_DV(rx_spi_byte_ready),
            .o_Rd_Data(o_axis_tdata),
            .i_AE_Level(),
            .o_AE_Flag(),
            .o_Empty(rx_fifo_empty));

wire tx_fifo_full;
wire tx_fifo_empty;
assign i_axis_tready = ~tx_fifo_full;
assign spi_tx_out = ~tx_fifo_empty;
wire [0:7] spi_tx_byte;


FIFO spi_tx (.i_Rst_L(i_reset),
            .i_Clk(i_clk),
            .i_Wr_DV(i_axis_tvalid),
            .i_Wr_Data(i_axis_tdata),
            .i_AF_Level(),
            .o_AF_Flag(),
            .o_Full(tx_fifo_full),
            .i_Rd_En(),
            .o_Rd_DV(spi_tx_out),
            .o_Rd_Data(spi_tx_byte),
            .i_AE_Level(),
            .o_AE_Flag(),
            .o_Empty(tx_fifo_empty));



SPI_Slave spi(  .i_Rst_L(i_reset),
                .i_Clk(i_clk),
                .o_RX_DV(spi_rx_ready),
                .o_RX_Byte(spi_rx_byte),
                .i_TX_DV(spi_tx_out),
                .i_TX_Byte(spi_tx_byte),
                .i_SPI_Clk(i_spi_clk),
                .o_SPI_MISO(o_spi_miso),
                .i_SPI_MOSI(i_spi_mosi),
                .i_SPI_CS_n(i_spi_cs)
 );

endmodule
