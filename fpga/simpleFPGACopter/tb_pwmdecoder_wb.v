`default_nettype none
`timescale 1 ns / 1 ns


module tb_pwmdecoder();

reg reset;
reg clk;



reg [31:0] wb_adr_o;   // ADR_O() address
wire [31:0]  wb_dat_i;   // DAT_I() data in
reg [31:0] wb_dat_o;   // DAT_O() data out
reg        wb_we_o;    // WE_O write enable output
reg [3:0]  wb_sel_o;   // SEL_O() select output
reg        wb_stb_o;   // STB_O strobe output
wire       wb_ack_i;   // ACK_I acknowledge input
wire        wb_err_i;   // ERR_I error input
reg        wb_cyc_o;   // CYC_O cycle output

reg pwm_0, pwm_1, pwm_2, pwm_3, pwm_4, pwm_5;



pwmdecoder_wb #(.clockFreq(100_000_000))
                pwm_wb(
                    .i_clk(clk),
                    .i_rstn(reset),
                    .wb_adr_i(wb_adr_o),
                    .wb_dat_i(wb_dat_o),
                    .wb_dat_o(wb_dat_i),
                    .wb_we_i(wb_we_o), 
                    .wb_sel_i(wb_sel_o),
                    .wb_stb_i(wb_stb_o),
                    .wb_ack_o(wb_ack_i),
                    .wb_err_o(wb_err_i),
                    .wb_rty_o(),
                    .wb_cyc_i(wb_cyc_o),
                    .i_pwm_0(pwm_0),
                    .i_pwm_1(pwm_1),
                    .i_pwm_2(pwm_2),
                    .i_pwm_3(pwm_3),
                    .i_pwm_4(pwm_4),
                    .i_pwm_5(pwm_5));


// this is 100Mhz:
always  #5 clk = ~clk;

always @(posedge clk) begin
    #(2_000_000) pwm_0 <= 1;
    #(2_000_000) pwm_0 <= 0;
end

always @(posedge clk) begin
    #(2_000_000) pwm_1 <= 1;
    #(1_900_000) pwm_1 <= 0;
end

always @(posedge clk) begin

    #(2_000_000) pwm_2 <= 1;
    #(1_800_000) pwm_2 <= 0;
end

always @(posedge clk) begin

    #(2_000_000) pwm_2 <= 1;
    #(1_700_000) pwm_2 <= 0;
end

always @(posedge clk) begin
    #(2_000_000) pwm_3 <= 1;
    #(1_600_000) pwm_3 <= 0;
end

always @(posedge clk) begin
    #(2_000_000) pwm_4 <= 1;
    #(1_500_000) pwm_4 <= 0;
end

always @(posedge clk) begin
    #(2_000_000) pwm_5 <= 1;
    #(1_000_000) pwm_5 <= 0;
end

task read_pwm( input [31:0] whichpwm);

    reg [31:0] pwm_value;
   pwm_value = 32'h0;
    wb_adr_o = whichpwm << 2; 

    @(posedge clk) begin
        wb_stb_o = 1'b1;        
        wb_cyc_o = 1;
        wb_sel_o = 4'b1111;
    end

  //  forever begin
     wait (wb_ack_i== 1'b1);
  //  end
    @(posedge clk) begin
       wb_stb_o = 0;        
       wb_cyc_o = 1'b0;
        pwm_value <= wb_dat_i;  
   end

    #1 $display("PWM %d value=%d", whichpwm, pwm_value);

endtask

initial begin
    wb_adr_o = 0;
    wb_dat_o = 0;
    wb_we_o = 0;
    wb_sel_o = 0;
    wb_stb_o = 0;
    wb_cyc_o = 0;
    pwm_0 = 0;
    pwm_1 = 0;
    pwm_2 = 0;
    pwm_3 = 0;
    pwm_4 = 0;
    pwm_5 = 0;
    reset = 1'b1;
    clk = 0;
    $dumpfile("tb_pwmdecoder.vcd");
	$dumpvars(0,tb_pwmdecoder);
end
always @(posedge clk) begin
   
    #100  $display("sending");
    wait (pwm_0 == 1'b1);
    wait (pwm_0 == 1'b0);
    #400  $display("waiting");
    $display("pwm toggled");
    #400  $display("waiting");
    #10 read_pwm(0);
    #10 read_pwm(1);
    #10 read_pwm(2);
    #10 read_pwm(3);
    #10 read_pwm(4);
    #10 read_pwm(5);
    #40 $finish;	
  	 $display("Done");
end

endmodule