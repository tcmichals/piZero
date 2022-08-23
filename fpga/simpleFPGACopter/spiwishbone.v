
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
output wire         o_busy,

output wire [7:0] axis_byte,
output wire axis_tvalid,
output wire spi_rd,
output wire [7:0] spi_byte_rx,
output wire spi_td,
output wire [7:0] spi_byte_tx,
output wire [3:0] spi_counter
);


wire rx_ready_spi;
wire axis_tready;


reg readFifo;
reg readyToReadFifo;
wire [7:0] fifo_rd_byte;
reg [3:0] spi_counter_reg;

//client 
wire [7:0]  c_axis_tdata;
wire        c_axis_tvalid;
wire c_axis_tready;
//server
wire [7:0]  s_axis_tdata;
wire        s_axis_tvalid;
wire        s_axis_tready;

initial begin
    readFifo = 1'b0;
    spi_counter_reg = 4'h0; 
    readyToReadFifo = 1'b0;
end

assign s_axis_tvalid = rx_ready_spi & s_axis_tready;

always @(posedge i_clk or negedge i_resetn) begin
    if (!i_resetn) begin
         readFifo <= 1'b0;
         readyToReadFifo <= 1'b0;
    end
    else begin
        if (rx_ready_spi & ~i_spi_cs) begin
            spi_counter_reg <= spi_counter_reg +1'b1;
        end
        if (i_spi_cs) begin
            spi_counter_reg <= 4'h0;
        end

        if ( ~readyToReadFifo  & rx_ready_spi )
            readyToReadFifo <= 1'b1;

        if (~fifo_empty & ~readFifo & readyToReadFifo) begin
            readFifo <= 1'b1;
            readyToReadFifo <= 1'b0;
        end
        else if (readFifo ) begin
                readFifo <= 1'b0;
        end

    end  
end

spi_slave spi(  .clk(i_clk),
                .rst(~i_resetn),
                .ss(i_spi_cs),
                .mosi(i_spi_mosi),
                .miso(o_spi_miso),
                .sck(i_spi_clk),
                .done(rx_ready_spi),
                .din(fifo_rd_byte),
                .dout(s_axis_tdata));

FIFO_v  #(.DATA_W(8))
          axis_fifo  ( .data_out(fifo_rd_byte),
                        .data_count(),
                        .empty(fifo_empty),
                        .full(c_axis_tready),
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
                            .output_axis_tready(~c_axis_tready),
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


assign axis_byte = s_axis_tdata;
assign axis_tvalid = s_axis_tvalid;
assign state = wb_master.state_reg;
assign spi_rd = rx_ready_spi;
assign spi_byte_rx = s_axis_tdata;
assign spi_td = readFifo;
assign spi_byte_tx = fifo_rd_byte;
assign spi_counter = spi_counter_reg;
endmodule