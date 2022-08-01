/*
module toplevel(
    input wire i_clk,
    input wire i_reset,
    output wire o_led_0,
    output wire o_led_1,
    output wire o_led_2,
    output wire o_led_green,
    output wire o_led_blue,
    output wire o_led_red,

    input wire i_spi_clk,
    output wire o_spi_miso,
    input wire i_spi_mosi,
    input wire i_spi_cs
);



wire [7:0]  o_axis_tdata;  // output
wire        o_axis_tvalid;  // output
wire        o_axis_tready; // input


wire tx_fifo_empty;
wire tx_spi_byte_ready;
wire [7:0] tx_spi_byte;
wire i_axis_tready;

assign  tx_spi_byte_ready = ~tx_fifo_empty & spi_rx_ready;
assign o_axis_tready = 1'b1;
 

FIFO spi_tx (.i_Rst_L(i_reset),
            .i_Clk(i_clk),
            .i_Wr_DV(o_axis_tvalid),
            .i_Wr_Data(o_axis_tdata),
            .i_AF_Level(),
            .o_AF_Flag(),
            .o_Full(),
            .i_Rd_En(),
            .o_Rd_DV(tx_spi_byte_ready),
            .o_Rd_Data(tx_spi_byte),
            .i_AE_Level(),
            .o_AE_Flag(),
            .o_Empty(tx_fifo_empty));

SPI_Slave spi(  .i_Rst_L(i_reset),
                .i_Clk(i_clk),
                .o_RX_DV(spi_rx_ready),
                .o_RX_Byte(spi_rx_byte),
                .i_TX_DV(tx_spi_byte_ready),
                .i_TX_Byte(tx_spi_byte),
                .i_SPI_Clk(i_spi_clk),
                .o_SPI_MISO(o_spi_miso),
                .i_SPI_MOSI(i_spi_mosi),
                .i_SPI_CS_n(i_spi_cs)
 );


toplevelbus bus(.i_clk(i_clk), 
                .i_reset(i_reset), 
                .i_axis_tdata(spi_rx_byte),
                .i_axis_tkeep(),
                .i_axis_tvalid(spi_rx_ready),
                .i_axis_tready(i_axis_tready),
                .i_axis_tlast(),
                .i_axis_tuser(),

                .o_axis_tdata(o_axis_tdata),
                .o_axis_tkeep(),
                .o_axis_tvalid(o_axis_tvalid),
                .o_axis_tready(o_axis_tready),
                .o_axis_tlast(),
                .o_axis_tuser(),
				.o_led_0(o_led_0),
                .o_led_1(o_led_1),
                .o_led_2(o_led_2),
                .o_led_green(o_led_green),
                .o_led_blue(o_led_blue),
                .o_led_red(o_led_red));     
*/