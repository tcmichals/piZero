`timescale 1ns/ 100 ps

module tb_spiwishbone();

reg reset = 1'b1;

reg clk = 1'b1;
reg spi_clk = 1'b1;
reg spi_ss = 1'b1;
reg spi_mosi = 1'b0;
wire spi_miso;

wire [31:0] wb_adr_o;   // ADR_O() address
wire [31:0]  wb_dat_i;   // DAT_I() data in
reg [31:0] wb_dat_o = 32'hFFEEDDCC;   // DAT_O() data out
wire        wb_we_o;    // WE_O write enable output
wire [3:0]  wb_sel_o;   // SEL_O() select output
wire        wb_stb_o;   // STB_O strobe output
reg         wb_ack_i = 1'b0;   // ACK_I acknowledge input
reg        wb_err_i = 1'b0;   // ERR_I error input
reg       m_wb_cyc_o = 1'b0;   // CYC_O cycle output
wire o_busy;



// Clock Generators:
always  #1 clk = ~clk;
always  #10 spi_clk = ~spi_clk;


spiwishbone wishbone(
        .i_clk(clk),
        .i_resetn(reset),
        .i_spi_clk(spi_clk),
        .o_spi_miso(spi_miso),
        .i_spi_mosi(spi_mosi),
        .i_spi_cs(spi_ss),
        .m_wb_adr_o(wb_adr_o),
        .m_wb_dat_i(wb_dat_o),
        .m_wb_dat_o(wb_dat_i),
        .m_wb_we_o(wb_we_o),
        .m_wb_sel_o(wb_sel_o),
        .m_wb_stb_o(wb_stb_o),
        .m_wb_ack_i(wb_ack_i),
        .m_wb_err_i(wb_err_i),
        .m_wb_cyc_o(m_wb_cyc_o),
        .o_busy(o_busy)
);


reg spi_bits = 8'h0;
reg [7:0] spi_miso_byte = 0;

always @(posedge spi_clk) begin

   if ( !spi_ss  && spi_bits < 7) begin
    spi_bits <= spi_bits + 1'b1;
    spi_miso_byte[spi_bits] <= spi_miso;  
   end

   if (spi_bits == 7) begin
        spi_bits <= 8'h0;
        $display("Rx byte %x", spi_miso_byte);
   end
 
end

always @(posedge clk) begin

  if (wb_stb_o & ~wb_ack_i) begin
    if (wb_we_o)
      wb_dat_o <= wb_dat_i;
    wb_ack_i <= 1'b1;
  end

  if (wb_ack_i)
    wb_ack_i <= 1'b0;

end

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


initial begin
    $dumpfile("tb_spiwishbone.vcd");
	$dumpvars(0,tb_spiwishbone);

    $display("sending");
    #20 reset <= 1'b0;
    #20 reset <= 1'b1;

    //Read
    #40    send_spi(8'hA1);  
    //Address 
    #1    send_spi(8'h11);
    #1  send_spi(8'h22); 

    #1   send_spi(8'h33); 
    #1  send_spi(8'h44); 
    //Length
    #1    send_spi(8'h00); 
    #1    send_spi(8'h4); 
    //data
    #1    send_spi(8'h00); 
    #1    send_spi(8'h00); 
    #1    send_spi(8'h00); 
    #1    send_spi(8'h00); 
    #1    send_spi(8'h00); 
    #1    send_spi(8'h00); 

    //Write
    #40    send_spi(8'hA2);  
    //Address 
    #1    send_spi(8'h11);
    #1  send_spi(8'h22); 

    #1   send_spi(8'h33); 
    #1  send_spi(8'h44); 
    //Length
    #1    send_spi(8'h00); 
    #1    send_spi(8'h4); 
    //data
    #1    send_spi(8'h55); 
    #1    send_spi(8'h66); 
    #1    send_spi(8'h77); 
    #1    send_spi(8'h88); 
    #1    send_spi(8'h00); 


        //Read
    #40    send_spi(8'hA1);  
    //Address 
    #1    send_spi(8'h55);
    #1  send_spi(8'h66); 

    #1   send_spi(8'h77); 
    #1  send_spi(8'h88); 
    //Length
    #1    send_spi(8'h00); 
    #1    send_spi(8'h4); 
    //data
    #1    send_spi(8'h00); 
    #1    send_spi(8'h00); 
    #1    send_spi(8'h00); 
    #1    send_spi(8'h00); 
    #1    send_spi(8'h00); 
    #1    send_spi(8'h00); 


        //Read
    #40    send_spi(8'hA1);  
    //Address 
    #1    send_spi(8'h11);
    #1  send_spi(8'h99); 

    #1   send_spi(8'hAA); 
    #1  send_spi(8'hBB); 
    //Length
    #1    send_spi(8'h00); 
    #1    send_spi(8'h4); 
    //data
    #1    send_spi(8'h00); 
    #1    send_spi(8'h00); 
    #1    send_spi(8'h00); 
    #1    send_spi(8'h00); 
    #1    send_spi(8'h00); 
    #1    send_spi(8'h00); 


        //Write
    #40    send_spi(8'hA2);  
    //Address 
    #1    send_spi(8'h11);
    #1  send_spi(8'h22); 

    #1   send_spi(8'h33); 
    #1  send_spi(8'h44); 
    //Length
    #1    send_spi(8'h00); 
    #1    send_spi(8'h4); 
    //data
    #1    send_spi(8'h11); 
    #1    send_spi(8'h22); 
    #1    send_spi(8'h33); 
    #1    send_spi(8'h44); 
    #1    send_spi(8'h00); 

    #40 $finish;	
  	 $display("Done");
end


endmodule

