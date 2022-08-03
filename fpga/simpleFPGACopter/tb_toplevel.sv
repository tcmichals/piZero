///////////////////////////////////////////////////////////////////////////////
// Description:       Simple test bench for SPI Master and Slave modules
///////////////////////////////////////////////////////////////////////////////

module tb_toplevel ();
  
  parameter SPI_MODE = 1; // CPOL = 0, CPHA = 1
  parameter SPI_CLK_DELAY = 20;  // 2.5 MHz
  parameter MAIN_CLK_DELAY = 2;  // 25 MHz

  logic w_CPOL; // clock polarity
  logic w_CPHA; // clock phase

  assign w_CPOL = (SPI_MODE == 2) | (SPI_MODE == 3);
  assign w_CPHA = (SPI_MODE == 1) | (SPI_MODE == 3);

  logic r_Rst_L     = 1'b0;

  logic [0:255][7:0] dataPayload; 
  logic [7:0] dataLength;
  
  // CPOL=0, clock idles 0.  CPOL=1, clock idles 1
//  logic r_SPI_Clk   = w_CPOL ? 1'b1 : 1'b0;
  logic w_SPI_Clk;
  logic r_SPI_En    = 1'b0;
  logic r_Clk       = 1'b0;
  logic w_SPI_CS_n;
  logic w_SPI_MOSI;
  logic w_SPI_MISO;

  // Master Specific
  logic [7:0] r_Master_TX_Byte = 0;
  logic r_Master_TX_DV = 1'b0;
  logic r_Master_CS_n = 1'b1;
  logic w_Master_TX_Ready;
  logic r_Master_RX_DV;
  logic [7:0] r_Master_RX_Byte;

  // Slave Specific
  logic       w_Slave_RX_DV, r_Slave_TX_DV;
  logic [7:0] w_Slave_RX_Byte, r_Slave_TX_Byte;

  // Clock Generators:
  always #(MAIN_CLK_DELAY) r_Clk = ~r_Clk;


toplevel top( .i_clk(r_Clk),
     .i_reset(r_Rst_L),
    .o_led_0(),
    .o_led_1(),
    .o_led_2(),
    .o_led_green(),
    .o_led_blue(),
    .o_led_red(),
    .i_spi_clk(w_SPI_Clk),
    .o_spi_miso(w_SPI_MISO),
    .i_spi_mosi(w_SPI_MOSI),
    .i_spi_cs(r_Master_CS_n));

  // Instantiate Master to drive Slave
  SPI_Master 
  #(.SPI_MODE(SPI_MODE),
    .CLKS_PER_HALF_BIT(2)) SPI_Master_UUT
  (
   // Control/Data Signals,
   .i_Rst_L(r_Rst_L),     // FPGA Reset
   .i_Clk(r_Clk),         // FPGA Clock
   
   // TX (MOSI) Signals
   .i_TX_Byte(r_Master_TX_Byte),     // Byte to transmit on MOSI
   .i_TX_DV(r_Master_TX_DV),         // Data Valid Pulse with i_TX_Byte
   .o_TX_Ready(w_Master_TX_Ready),   // Transmit Ready for Byte
   
   // RX (MISO) Signals
   .o_RX_DV(r_Master_RX_DV),       // Data Valid pulse (1 clock cycle)
   .o_RX_Byte(r_Master_RX_Byte),   // Byte received on MISO

   // SPI Interface
   .o_SPI_Clk(w_SPI_Clk),
   .i_SPI_MISO(w_SPI_MISO),
   .o_SPI_MOSI(w_SPI_MOSI)
   );


  // Sends a single byte from master to slave.  Will drive CS on its own.
  task SendSingleByte(input [7:0] data);
    @(posedge r_Clk);
    r_Master_TX_Byte <= data;
    r_Master_TX_DV   <= 1'b1;
    r_Master_CS_n    <= 1'b0;
    @(posedge r_Clk);
    r_Master_TX_DV <= 1'b0;
    @(posedge w_Master_TX_Ready);
    r_Master_CS_n    <= 1'b1;    
  endtask // SendSingleByte


  // Sends a multi-byte transfer from master to slave.  Drives CS on its own.  
  task SendMultiByte(input [0:255][7:0] data, input [7:0] length);
    integer ii;

    @(posedge r_Clk);
    r_Master_CS_n    <= 1'b0;

    for (ii=0; ii<length; ii++)
    begin
      @(posedge r_Clk);
      r_Master_TX_Byte <= data[ii];
      r_Master_TX_DV   <= 1'b1;
      @(posedge r_Clk);
      r_Master_TX_DV <= 1'b0;
      @(posedge w_Master_TX_Ready);
    end
    r_Master_CS_n <= 1'b1;
  endtask // SendMultiByte

    
  initial
    begin
          $dumpfile("SPI_Slave_TB.vcd");
	$dumpvars(0,SPI_Slave_TB);
      repeat(10) @(posedge r_Clk);
      r_Rst_L  = 1'b0;
      repeat(10) @(posedge r_Clk);
      r_Rst_L          = 1'b1;
      r_Slave_TX_Byte <= 8'h5A;
      r_Slave_TX_DV   <= 1'b1;
      repeat(10) @(posedge r_Clk);
      r_Slave_TX_DV   <= 1'b0;
      SendSingleByte(8'hC1);
      repeat(100) @(posedge r_Clk);
      dataPayload[0]  = 8'h00;
      dataPayload[1]  = 8'h01;
      dataPayload[2]  = 8'h80;
      dataPayload[3]  = 8'hFF;
      dataPayload[4]  = 8'h55;
      dataPayload[5]  = 8'hAA;
      dataLength      = 6;
      SendMultiByte(dataPayload, dataLength);
      repeat(100) @(posedge r_Clk);
      $finish();      
    end // initial begin

endmodule // SPI_Slave


