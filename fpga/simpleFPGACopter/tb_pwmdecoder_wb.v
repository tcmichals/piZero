`default_nettype none
`timescale 1 us / 1 us


module tb_pwmdecoder();
reg reset = 1'b1;

reg clk = 1'b1;


reg [31:0] wb_adr_o = 32'h0;;   // ADR_O() address
wire [31:0]  wb_dat_i;   // DAT_I() data in
reg [31:0] wb_dat_o = 32'hFFEEDDCC;   // DAT_O() data out
reg        wb_we_o = 1'b0;    // WE_O write enable output
reg [3:0]  wb_sel_o = 3'b0;   // SEL_O() select output
reg        wb_stb_o = 1'b0;   // STB_O strobe output
wire       wb_ack_i;   // ACK_I acknowledge input
wire        wb_err_i;   // ERR_I error input
reg        m_wb_cyc_o = 1'b0;   // CYC_O cycle output

reg pwm_0, pwm_1, pwm_2, pwm_3, pwm_4, pwm_5;



pwmdecoder_wb #().clockFreq(1000000)
                (
                    i_clk(clk),
                    i_rstn(reset),
                    wb_adr_i(wb_adr_o),
                    wb_dat_i(wb_dat_0),
                    wb_dat_o(wb_dat_i),
                    wb_we_i(wb_we_o), 
                    wb_sel_i(),
                    wb_stb_i(),
                    wb_ack_o(),
                    wb_err_o(),
                    wb_rty_o(),
                    wb_cyc_i(),
                    i_pwm_0(pwm_0),
                    i_pwm_1(pwm_1),
                    i_pwm_2(pwm_2),
                    i_pwm_3(pwm_3),
                    i_pwm_4(pwm_4),
                    i_pwm_5(pwm_5))

                );


// this is 100Mhz:
always  #1 clk = ~clk;

always @(posedge clk) begin

    #(2000) pwm_1 <= 0;
    #(500) pwm_1 <= 1;

end

initial begin
    pwm_0 = 0;
    pwm_1 = 0;
    pwm_2= 0;
    pwm_3 = 0;
    pwm_4 = 0;
    pwm_5 = 0;

    $dumpfile("tb_pwmdecoder.vcd");
	$dumpvars(0,tb_pwmdecoder);

    $display("sending");
        #100 pwm_1 <= 1'b0;



    #40000 $finish;	
  	 $display("Done");
end

endmodule