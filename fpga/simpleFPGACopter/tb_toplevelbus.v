`timescale 1ns / 1ps

module tb_toplevelbus;

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

localparam [4:0]
    STATE_IDLE = 5'd0,
    STATE_HEADER_ADDR_1 = 5'd1,
	STATE_HEADER_ADDR_2 = 5'd2,
	STATE_HEADER_ADDR_3 = 5'd3,
	STATE_HEADER_ADDR_4 = 5'd4,
	STATE_HEADER_LEN_1 = 5'd5,
	STATE_HEADER_LEN_2 = 5'd6,
	STATE_HEADER_RD_1 = 5'd7,
	STATE_HEADER_RD_2 = 5'd8,
	STATE_HEADER_RD_3 = 5'd9,
	STATE_HEADER_RD_4 = 5'd10,
	STATE_HEADER_WR_1 = 5'd11,  
	STATE_HEADER_WR_2 = 5'd12,
	STATE_HEADER_WR_3 = 5'd13,
	STATE_HEADER_WR_4 = 5'd14,
	STATE_HEADER_WR_5 = 5'd15,
	STATE_HEADER_WR_6 = 5'd16,
	STATE_HEADER_WR_7 = 5'd17,
	STATE_HEADER_WR_8 = 5'd18,

    STATE_READ = 5'd2,
    STATE_WRITE = 5'd3;


reg [4:0] state_reg = STATE_IDLE, state_next;


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
                .o_axis_tuser(o_axis_tuser),
				.o_led_0(),
            	.o_led_1(),
           		.o_led_2(),
          		.o_led_green(),
         		.o_led_blue(),
    			.o_led_red());                



  always #1 i_clk = !i_clk;
  
  
  initial begin
    $dumpfile("tb_toplevelbus.vcd");
	$dumpvars(0,tb_toplevelbus);
    
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

	#5000 $finish;
  end
  
  always @(posedge i_clk) begin
	case(state_reg)
		STATE_IDLE: begin
			if (i_axis_tready) begin
				i_axis_tvalid <= 1;
				i_axis_tdata <= 8'hA1; 
				state_reg <= STATE_HEADER_ADDR_1;
			end
		end
	 	STATE_HEADER_ADDR_1, 
		STATE_HEADER_ADDR_2,
		STATE_HEADER_ADDR_3,
		STATE_HEADER_ADDR_4:
			if (i_axis_tready) begin
				i_axis_tvalid <= 1;
				i_axis_tdata <= 8'h00;
				state_reg <= state_reg +1'b1; 
			end

		STATE_HEADER_LEN_1:
			if (i_axis_tready) begin
				i_axis_tvalid <= 1;
				i_axis_tdata <= 8'h0;
				state_reg <= state_reg +1'b1; 
			end


		STATE_HEADER_LEN_2:
			if (i_axis_tready) begin
				i_axis_tvalid <= 1;
				i_axis_tdata <= 8'h4;
				state_reg <= state_reg +1'b1; 
			end

		STATE_HEADER_RD_1,
		STATE_HEADER_RD_2,
		STATE_HEADER_RD_3,
		STATE_HEADER_RD_4:
					state_reg <= state_reg +1'b1; 
		


		default: begin
		end

	endcase
  end
  
  
  endmodule
  
  
  			
			
			
			
			
