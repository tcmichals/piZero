module tb_axiswishbone;




reg i_clk = 0;
reg i_reset= 0;


//server, push/transmit
reg [7:0]   s_axis_tdata = 0;
reg         s_axis_tkeep = 0;
reg         s_axis_tvalid = 0;
wire        s_axis_tready;
reg         s_axis_tlast = 0;
reg         s_axis_tuser = 0;

// client, receive
wire [7:0]  c_axis_tdata;
wire        c_axis_tkeep;
wire        c_axis_tvalid;
reg         c_axis_tready  = 1;
wire        c_axis_tlast;
wire        c_axis_tuser;


wire [31:0] wb_adr_o;   // ADR_O() address
wire [31:0]  wb_dat_i;   // DAT_I() data in
wire [31:0] wb_dat_o;   // DAT_O() data out
wire        wb_we_o;    // WE_O write enable output
wire [3:0]  wb_sel_o;   // SEL_O() select output
wire        wb_stb_o;   // STB_O strobe output
wire         wb_ack_i;   // ACK_I acknowledge input
wire        wb_err_i;   // ERR_I error input
wire       m_wb_cyc_o;   // CYC_O cycle output
wire o_busy;

reg [7:0] counter_rx = 0;

  // Clock Generators:
  always  #1 i_clk = ~i_clk;


simplecounter_wb counter(.i_clk(i_clk),
                        .i_rst(i_reset),
                        .wb_adr_i(wb_adr_o),
                        .wb_dat_i(wb_dat_o),
                        .wb_dat_o(wb_dat_i),
                        .wb_we_i(wb_we_o),
                        .wb_sel_i(wb_sel_o),
                        .wb_stb_i(wb_stb_o),
                        .wb_ack_o(wb_ack_i),
                        .wb_err_o(wb_err_i),
                        .wb_rty_o(),
                        .wb_cyc_i(m_wb_cyc_o));


axis_wb_master #( .IMPLICIT_FRAMING(1) ) wb_master (   .clk(i_clk),
                            .rst(i_reset),

                            .input_axis_tdata(s_axis_tdata),
                            .input_axis_tkeep(s_axis_tkeep),
                            .input_axis_tvalid(s_axis_tvalid),
                            .input_axis_tready(s_axis_tready),
                            .input_axis_tlast(s_axis_tlast),
                            .input_axis_tuser(s_axis_tuser),

                            .output_axis_tdata(c_axis_tdata),
                            .output_axis_tkeep(c_axis_tkeep),
                            .output_axis_tvalid(c_axis_tvalid),
                            .output_axis_tready(c_axis_tready),
                            .output_axis_tlast(c_axis_tlast),
                            .output_axis_tuser(c_axis_tuser),

                            .wb_adr_o(wb_adr_o),
                            .wb_dat_i(wb_dat_i),
                            .wb_dat_o(wb_dat_o),
                            .wb_we_o(wb_we_o), 
                            .wb_sel_o(wb_sel_o),
                            .wb_stb_o(wb_stb_o),
                            .wb_ack_i(wb_ack_i),
                            .wb_err_i(wb_err_i),
                            .wb_cyc_o(wb_cyc_o),

                          .busy(o_busy));

task tx_axis( input [7:0] data);
    wait(s_axis_tready);
    @(posedge i_clk);
    s_axis_tdata <= data;
    s_axis_tvalid <= 1'b1;
     @(posedge i_clk);
    s_axis_tvalid <= 1'b0;
endtask



task wishbone();

endtask

always @(posedge i_clk) begin
   if ( c_axis_tvalid) begin
    counter_rx <= counter_rx + 1'b1;
    $display("rx_axis %x counter(%d)", c_axis_tdata, counter_rx);  
   end
 
end


initial begin
    $dumpfile("tb_axiswishbone.vcd");
	$dumpvars(0,tb_axiswishbone);

    #20 i_reset <= 1'b1;
    #20 i_reset <= 1'b0;

    //Read
    #40    tx_axis(8'hA1);  
    //Address 
    #1    tx_axis(8'h11);
    #1  tx_axis(8'h22); 

    #1   tx_axis(8'h33); 
    #1  tx_axis(8'h44); 
    //Length
    #1    tx_axis(8'h00); 
    #1    tx_axis(8'h4); 
    //data
    #1    tx_axis(8'h00); 
    #1    tx_axis(8'h00); 
    #1    tx_axis(8'h00); 
    #1    tx_axis(8'h00); 
    #1    tx_axis(8'h00); 
    #1    tx_axis(8'h00); 

    //Write
    #40    tx_axis(8'hA2);  
    //Address 
    #1    tx_axis(8'h11);
    #1  tx_axis(8'h22); 

    #1   tx_axis(8'h33); 
    #1  tx_axis(8'h44); 
    //Length
    #1    tx_axis(8'h00); 
    #1    tx_axis(8'h4); 
    //data
    #1    tx_axis(8'h55); 
    #1    tx_axis(8'h66); 
    #1    tx_axis(8'h77); 
    #1    tx_axis(8'h88); 
    #1    tx_axis(8'h99); 
    #1    tx_axis(8'h00); 

    #40 $finish;	
  	 $display("Done");
end


endmodule