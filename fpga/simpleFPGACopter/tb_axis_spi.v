///////////////////////////////////////////////////////////////////////////////
// Description:       Simple test bench for SPI Master and Slave modules
///////////////////////////////////////////////////////////////////////////////

module tb_axis_spi();
  
parameter SPI_CLK_DELAY = 20;  // 2.5 MHz

parameter MAIN_CLK_DELAY = 2;  // 25 MHz

reg reset = 1'b1;
reg clk = 1'b1;
reg spi_clk = 1'b1;
reg spi_ss = 1'b1;
reg spi_mosi = 1'b0;
wire spi_miso;

wire [7:0]s_axis_tdata;
wire s_axis_tkeep;
wire  s_axis_tvalid;
reg  s_axis_tready = 1'b1;
wire s_axis_tlast;
wire  s_axis_tuser;

reg [7:0] m_axis_tdata = 8'h0;
reg  m_axis_tkeep= 1'b0;
reg  m_axis_tvalid= 1'b0;;
wire m_axis_tready;
reg  m_axis_tlastp= 1'b0;;
reg  m_axis_tuserp= 1'b0;;


  // Clock Generators:
  always #(MAIN_CLK_DELAY) clk = ~clk;
  // Clock Generators:
  always #(SPI_CLK_DELAY) spi_clk = ~spi_clk;

  axis_spi spi(
            .axis_aclk(clk),
    .axis_aresetn(reset),

    .i_spi_clk(spi_clk),
    .o_spi_miso(spi_miso),
    .i_spi_mosi(spi_mosi),
    .i_spi_cs(spi_ss),

    .s_axis_tdata(m_axis_tdata),
    .s_axis_tkeep(m_axis_tkeep),
    .s_axis_tvalid(m_axis_tvalid),
    .s_axis_tready(m_axis_tready),
    .s_axis_tlast(m_axis_tlast),
    .s_axis_tuser(m_axis_tuser),

    .m_axis_tdata(s_axis_tdata),
    .m_axis_tkeep(s_axis_tkeep),
    .m_axis_tvalid(s_axis_tvalid),
    .m_axis_tready(s_axis_tready),
    .m_axis_tlast(s_axis_tlast),
    .m_axis_tuser(s_axis_tuser)
  );


task send_spi( input [7:0] data);
   reg spi_out_bit;
   reg [2:0]r_TX_Bit_Count;  // Send MSb first
   r_TX_Bit_Count <= 3'b111; 
      $display("send spi 0x%H", data);

    @(negedge spi_clk) begin
      spi_mosi = data[r_TX_Bit_Count];
      spi_ss <= 1'b0;
      $display("%dth bit %B", r_TX_Bit_Count, data[r_TX_Bit_Count]);
    end
      r_TX_Bit_Count <= r_TX_Bit_Count - 1;

    @(negedge spi_clk) begin
      spi_mosi = data[r_TX_Bit_Count];
      $display("%dth bit %B", r_TX_Bit_Count, data[r_TX_Bit_Count]);
    end
      r_TX_Bit_Count <= r_TX_Bit_Count - 1;

    @(negedge spi_clk) begin
      spi_mosi = data[r_TX_Bit_Count];
      $display("%dth bit %B", r_TX_Bit_Count, data[r_TX_Bit_Count]);
    end
      r_TX_Bit_Count <= r_TX_Bit_Count - 1;

    @(negedge spi_clk) begin
        spi_mosi = data[r_TX_Bit_Count];
    end
      r_TX_Bit_Count <= r_TX_Bit_Count - 1;        

    @(negedge spi_clk) begin
        spi_mosi = data[r_TX_Bit_Count];
    end
      r_TX_Bit_Count <= r_TX_Bit_Count - 1;        

    @(negedge spi_clk) begin
        spi_mosi <= data[r_TX_Bit_Count];
    end
      r_TX_Bit_Count <= r_TX_Bit_Count - 1;        

    @(negedge spi_clk) begin
        spi_mosi = data[r_TX_Bit_Count];
    end
      r_TX_Bit_Count <= r_TX_Bit_Count - 1;

     @(negedge spi_clk) begin
        spi_mosi = data[r_TX_Bit_Count];
    end
      r_TX_Bit_Count <= r_TX_Bit_Count - 1;

     @(negedge spi_clk);
        spi_ss <= 1'b1;
        spi_mosi <= 1'b0;
endtask

task tx_axis( input [7:0] data);
    wait(m_axis_tready);
    @(posedge clk);
    m_axis_tdata <= data;
    m_axis_tvalid <= 1'b1;
     @(posedge clk);
    m_axis_tvalid <= 1'b0;

endtask




  initial begin
    $dumpfile("tb_axis_spi.vcd");
	  $dumpvars(0,tb_axis_spi);
    #2 reset <= 1'b0;
    #10 reset <= 1'b1;

    #40 tx_axis(8'h33);
    #40 send_spi(8'hA5);
    #40 tx_axis(8'h44);
    #40 send_spi(8'hAA);
    #40 $finish;	
  	 $display("Done");
    end


endmodule // SPI_Slave



