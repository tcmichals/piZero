`timescale 1ns / 1ps

module testbench;

localparam READ = 8'hA1;
reg o_clk = 0;
reg o_reset= 0;

reg [7:0] i_axis_tdata;
reg i_axis_tkeep = 0;
reg i_axis_tvalid = 0;
wire i_axis_tready;
reg i_axis_tlast = 0;
reg i_axis_tuser = 0;


wire [7:0] o_axis_tdata;
wire o_axis_tkeep;
wire o_axis_tvalid;
reg o_axis_tready  =1;
wire o_axis_tlast;
wire o_axis_tuser;

wire [31:0]   wb_adr_o;   // ADR_O() address
reg [31:0]   wb_dat_i = 0;   // DAT_I() data in
wire [31:0]   wb_dat_o;   // DAT_O() data out
wire wb_we_o;    // WE_O write enable output
wire [3:0] wb_sel_o;   // SEL_O() select output
wire wb_stb_o;   // STB_O strobe output
reg wb_ack_i = 0;   // ACK_I acknowledge input
reg wb_err_i = 0;   // ERR_I error input
wire wb_cyc_o;   // CYC_O cycle output

    /*
     * Status
     */
 wire    busy;


axis_wb_master wb_master(o_clk, o_reset, 
			i_axis_tdata, i_axis_tkeep,i_axis_tvalid,i_axis_tready,i_axis_tlast, i_axis_tuser,
			o_axis_tdata,o_axis_tkeep,o_axis_tvalid,o_axis_tready,o_axis_tlast,o_axis_tuser,
			wb_adr_o, wb_dat_i, wb_dat_o, wb_we_o,wb_sel_o,wb_stb_o,wb_ack_i,wb_err_i, wb_cyc_o, busy);
			

  always #1 o_clk = !o_clk;
  
  
  initial begin
      $dumpfile("testbench.vcd");
	$dumpvars(0,testbench);
    $display("wb_master.AXIS_DATA_WORD_SIZE %d wb_master.WB_VALID_ADDR_WIDTH %d wb_master.WB_WORD_WIDTH %d wb_master.WB_WORD_SIZE %d",
    	      wb_master.AXIS_DATA_WORD_SIZE, 
    	      wb_master.WB_VALID_ADDR_WIDTH,
    	      wb_master.WB_WORD_WIDTH,
      	      wb_master.WB_WORD_SIZE);
      	      
    $display("wb_master.WORD_PART_ADDR_WIDTH %d wb_master.ADDR_WIDTH_ADJ %d wb_master.COUNT_WORD_WIDTH %d wb_master.ADDR_WORD_WIDTH %d",
    	      wb_master.WORD_PART_ADDR_WIDTH, 
    	      wb_master.ADDR_WIDTH_ADJ,
    	      wb_master.COUNT_WORD_WIDTH,
      	      wb_master.ADDR_WORD_WIDTH);      	      

     
  	#2 i_axis_tdata = READ;
  	i_axis_tvalid = 1;
  	#2 i_axis_tdata = 1;  //Address
	#2 i_axis_tdata = 2;  //Address
	#2 i_axis_tdata = 3;  //Address
	#2 i_axis_tdata = 4;  //Address
	#2
	if (wb_cyc_o)
		wb_ack_i = 1;
	i_axis_tdata = 0;     //Count	
		
 	#2	if (wb_cyc_o)
		wb_ack_i = 1;
	i_axis_tdata = 1;     //count
		
  	#2 i_axis_tdata = 0; 
	#2 i_axis_tdata = 0; 
	i_axis_tlast = 1;
	if (wb_cyc_o)
		wb_ack_i = 1;
	
	#2 i_axis_tdata = 0; 
	wb_ack_i = 0;
	  	i_axis_tvalid = 0;
	  	i_axis_tlast = 0;
	  	wb_ack_i = 0;
	#2 i_axis_tdata = 0; 
	 $display("Done 0");  	
  	 #2 $finish;	
  	 $display("Done");
  end
  
  
  endmodule
  
  
  			
			
			
			
			
