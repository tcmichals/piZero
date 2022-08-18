
`timescale 1ns/ 100 ps

module spiwishbone
(

input wire          i_clk,
input wire          i_resetn,  //active low

input wire          i_spi_clk,
output wire         o_spi_miso,
input wire          i_spi_mosi,
input wire          i_spi_cs,

output wire [31:0]  m_wb_adr_o,   // ADR_O() address
input wire [31:0]   m_wb_dat_i,   // DAT_I() data in
output wire [31:0]  m_wb_dat_o,   // DAT_O() data out
output wire         m_wb_we_o,    // WE_O write enable output
output wire [3:0]   m_wb_sel_o,   // SEL_O() select output
output wire         m_wb_stb_o,   // STB_O strobe output
input wire          m_wb_ack_i,   // ACK_I acknowledge input
input wire          m_wb_err_i,   // ERR_I error input
output wire         m_wb_cyc_o,   // CYC_O cycle output
output wire         o_busy
);


wire rx_ready_spi;
wire axis_tready;
wire tx_write_spi;
reg tx_ready;
reg readFifo;
reg spiTxByte;
wire [7:0] fifo_rd_byte;


//client 
wire [7:0]  c_axis_tdata;
wire        c_axis_tvalid;



//server
wire [7:0]  s_axis_tdata;
wire        s_axis_tvalid;
wire        s_axis_tready;


initial begin
    tx_ready = 1'b1;
    readFifo = 1'b0;
    spiTxByte = 1'b0;

end

assign tx_write_spi = (c_axis_tvalid & tx_ready)?1'b1:1'b0;
assign s_axis_tvalid = rx_ready_spi & s_axis_tready;

always @(posedge i_clk or negedge i_resetn) begin
    if (!i_resetn) begin
         tx_ready <= 1'b1;
         readFifo <= 1'b0;
         spiTxByte <= 1'b0;
    end
    else begin
        if ( ~c_axis_tvalid & tx_ready &  ~fifo_empty & ~readFifo & ~spiTxByte) begin
            readFifo <= 1'b1;
        end
        else if (readFifo) begin
                tx_ready <= 1'b0;
                readFifo <= 1'b0;
                spiTxByte <= 1'b1;
        end
        else if (spiTxByte) begin
            spiTxByte <= 1'b0;
        end
        if (~tx_ready & rx_ready_spi) begin
            tx_ready <= 1'b1;
        end
    end  
end


SPI_Slave spi(  .i_Rst_L(i_resetn),
                .i_Clk(i_clk),
                .o_RX_DV(rx_ready_spi),
                .o_RX_Byte(s_axis_tdata),
                .i_TX_DV( spiTxByte),
                .i_TX_Byte(fifo_rd_byte),
                .i_SPI_Clk(i_spi_clk),
                .o_SPI_MISO(o_spi_miso),
                .i_SPI_MOSI(i_spi_mosi),
                .i_SPI_CS_n(i_spi_cs)
 );




FIFO_v  #(.DATA_W(8))
          axis_fifo  ( .data_out(fifo_rd_byte),
                        .data_count(),
                        .empty(fifo_empty),
                        .full(),
                        .almst_empty(),
                        .almst_full(),
                        .err(),
                        .data_in(c_axis_tdata),
                        .wr_en(c_axis_tvalid),
                        .rd_en(readFifo),
                        .n_reset(i_resetn),
                        .clk(i_clk));

            
   
axis_wb_master #( .IMPLICIT_FRAMING(1) )
                 wb_master (.clk(i_clk),
                            .rst(~i_resetn),

                            .input_axis_tdata(s_axis_tdata),
                            .input_axis_tkeep(s_axis_tkeep),
                            .input_axis_tvalid(s_axis_tvalid),
                            .input_axis_tready(s_axis_tready),
                            .input_axis_tlast(),
                            .input_axis_tuser(),

                            .output_axis_tdata(c_axis_tdata),
                            .output_axis_tkeep(),
                            .output_axis_tvalid(c_axis_tvalid),
                            .output_axis_tready(1'b1),
                            .output_axis_tlast(),
                            .output_axis_tuser(),

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