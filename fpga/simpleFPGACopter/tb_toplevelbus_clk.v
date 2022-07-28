`timescale 1ns / 1ps

module tb_toplevel;

    wire READ_REQ = 8'hA1;                      // read requst type
    wire WRITE_REQ = 8'hA2;                     // write requst type
    wire READ_RESP = 8'hA3;                     // read response type
    wire WRITE_RESP = 8'hA4;   

reg i_clk = 0;
reg i_reset= 0;

reg [7:0] i_axis_tdata = 0;
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

localparam [2:0]
    STATE_IDLE = 3'd0,
    STATE_HEADER = 3'd1,
    STATE_READ = 3'd2,
    STATE_WRITE = 3'd3;





toplevelbus bus(.i_clk(i_clk), 
                .i_reset(i_reset), 
                .i_axis_tdata(i_axis_tdata),
                .i_axis_tkeep(i_axis_tkeep),
                .i_axis_tvalid(i_axis_tvalid),
                .i_axis_tready(i_axis_tready),
                .i_axis_tlast(i_axis_tlast),
                .i_axis_tuser(i_axis_tuser),

                .o_axis_tdata(o_axis_tdata),
                .o_axis_tkeep(o_axis_tkeep),
                .o_axis_tvalid(o_axis_tvalid),
                .o_axis_tready(o_axis_tready),
                .o_axis_tlast(o_axis_tlast),
                .o_axis_tuser(o_axis_tuser));                



  always #1 i_clk = !i_clk;
  
  
  initial begin
    $dumpfile("tb_toplevel.vcd");
	$dumpvars(0,tb_toplevel);
    
	    $display("wb_master.AXIS_DATA_WORD_SIZE %d wb_master.WB_VALID_ADDR_WIDTH %d wb_master.WB_WORD_WIDTH %d wb_master.WB_WORD_SIZE %d",
    	      bus.wb_master.AXIS_DATA_WORD_SIZE, 
    	      bus.wb_master.WB_VALID_ADDR_WIDTH,
    	      bus.wb_master.WB_WORD_WIDTH,
      	      bus.wb_master.WB_WORD_SIZE);
      	      
    $display("wb_master.WORD_PART_ADDR_WIDTH %d wb_master.ADDR_WIDTH_ADJ %d wb_master.COUNT_WORD_WIDTH %d wb_master.ADDR_WORD_WIDTH %d",
    	      bus.wb_master.WORD_PART_ADDR_WIDTH, 
    	      bus.wb_master.ADDR_WIDTH_ADJ,
    	      bus.wb_master.COUNT_WORD_WIDTH,
      	      bus.wb_master.ADDR_WORD_WIDTH);      

  	#2 if ( i_axis_tready) begin
		
		i_axis_tdata = 8'hA1;;
		$display("ADFSDAFSAF %x", i_axis_tdata);
	end
  	#2 begin 
		i_axis_tvalid = 1;
	end
  	#2 i_axis_tdata = 0;  //Address
	#2 i_axis_tdata = 0;  //Address
	#2 i_axis_tdata = 0;  //Address
	#2 i_axis_tdata = 0;  //Address

	#2	i_axis_tdata = 0;     //Count	
	#2	i_axis_tdata = 4;     //count

	#12 begin 
			i_axis_tdata = 8'h11;  // Va 1
		end
	#2 i_axis_tdata = 8'h22;  // val 2
	#2 i_axis_tdata = 8'h33; // val 3
	#2 i_axis_tdata = 8'h44; // val 4

	
	#2 i_axis_tdata = 0; 
	#2 i_axis_tdata = 0; 

	#2 i_axis_tdata = 0; 
		i_axis_tlast = 1;

	#2 i_axis_tdata = 0; 		
	i_axis_tlast = 0;
	i_axis_tvalid =0;

	#2 i_axis_tdata = 0; 		
	i_axis_tlast = 0;


	#2 begin 
		i_axis_tdata = 8'hA2;
		i_axis_tvalid =1;
	end

  	#2 i_axis_tdata = 0;  //Address
	#2 i_axis_tdata = 0;  //Address
	#2 i_axis_tdata = 0;  //Address
	#2 i_axis_tdata = 32'h10;  //Address

	#2	i_axis_tdata = 4;     //Count	
	#2	i_axis_tdata = 0;     //count

	#2 i_axis_tdata = 8'h11;  // Va 1
	#2 i_axis_tdata =  8'h22;  // val 2
	#2 i_axis_tdata = 8'h33; // val 3
	#2 i_axis_tdata = 8'h55; // val 4

		i_axis_tlast = 1;

	#2 i_axis_tdata = 0; 		
	i_axis_tlast = 0;
	i_axis_tvalid =0;


	 #10 $display("Done 0");  	
  	 #2 $finish;	
  	 $display("Done");
  end
  
  
  endmodule
  
  
  			
			
			
			
			
