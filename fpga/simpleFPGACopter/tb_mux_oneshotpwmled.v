

`default_nettype none
`timescale 1 ns / 1 ns


module tb_mux_oneshotpwmled();

reg resetn  = 1'b1;
reg clk     = 1'b0;



reg [31:0] wb_adr_o = 32'h0000_0000;   // ADR_O() address
reg [31:0]  wb_dat_i= 32'h0000_0000;   // DAT_I() data in
wire [31:0] wb_dat_o;   // DAT_O() data out
reg        wb_we_o = 1'b0;    // WE_O write enable output
reg [3:0]  wb_sel_o = 3'b0;   // SEL_O() select output
reg        wb_stb_o = 1'b0;   // STB_O strobe output
wire       wb_ack_i;   // ACK_I acknowledge input
wire        wb_err_i;   // ERR_I error input
reg        wb_cyc_o = 1'b0;   // CYC_O cycle output


wire [31:0] wb_adr_led_o;   // ADR_O() address
reg [31:0]  wb_dat_led_i= 32'h0000_0000;   // DAT_I() data in
wire [31:0] wb_dat_led_o;   // DAT_O() data out
wire        wb_we_led_o;    // WE_O write enable output
wire [3:0]  wb_sel_led_o ;   // SEL_O() select output
wire        wb_stb_led_o;   // STB_O strobe output
wire        wb_cyc_led_o;   // STB_O strobe output


wire [31:0] wb_adr_pwm_o;   // ADR_O() address
reg [31:0]  wb_dat_pwm_i= 32'h0000_0000;   // DAT_I() data in
wire [31:0] wb_dat_pwm_o;   // DAT_O() data out
wire        wb_we_pwm_o;    // WE_O write enable output
wire [3:0]  wb_sel_pwm_o ;   // SEL_O() select output
wire        wb_stb_pwm_o;   // STB_O strobe output
wire        wb_cyc_pwm_o;   // STB_O strobe output


always  #1 clk = ~clk;

mux_oneshotpwmled mux(.clk(clk),
            .rstn(resetn),
            .wbm_adr_i(wb_adr_o),
            .wbm_dat_i(wb_dat_i),
            .wbm_dat_o(wb_dat_o),
            .wbm_we_i(wb_we_o),
            .wbm_sel_i(wb_sel_o),
            .wbm_stb_i(wb_stb_o),
            .wbm_ack_o(wb_ack_i),
            .wbm_err_o(wb_err_i),
            .wbm_rty_o(),
            .wbm_cyc_i(wb_cyc_o),

            .led_adr_o(wb_adr_led_o),
            .led_dat_i(wb_dat_led_i),
            .led_dat_o(wb_dat_led_o),
            .led_we_o(wb_we_led_o), 
            .led_sel_o(wb_sel_led_o),
            .led_stb_o(wb_stb_led_o),
            .led_ack_i(1'b1),
            .led_err_i(),
            .led_rty_i(),
            .led_cyc_o(),

            .pwmdecoder_adr_o(wb_adr_pwm_o),
            .pwmdecoder_dat_i(wb_dat_pwm_i),
            .pwmdecoder_dat_o(wb_dat_pwm_o),
            .pwmdecoder_we_o(wb_we_pwm_o), 
            .pwmdecoder_sel_o(wb_sel_pwm_o),
            .pwmdecoder_stb_o(wb_stb_pwm_o),
            .pwmdecoder_ack_i(1'b1),
            .pwmdecoder_err_i(),
            .pwmdecoder_rty_i(),
            .pwmdecoder_cyc_o(wb_cyc_pwm_o),

            .oneshot_adr_o(),
            .oneshot_dat_i(),
            .oneshot_dat_o(),
            .oneshot_we_o(),
            .oneshot_sel_o(),
            .oneshot_stb_o(),
            .oneshot_ack_i(),
            .oneshot_err_i(),
            .oneshot_rty_i(),
            .oneshot_cyc_o());

initial begin
    $dumpfile("tb_mux_oneshotpwmled.vcd");
	$dumpvars(0,tb_mux_oneshotpwmled);

        $display("sending");
    #20 resetn <= 1'b0;
    #20 resetn <= 1'b1;

    #100 wb_adr_o = 32'h4;
    wb_we_o = 1'b1;
    wb_sel_o= 3'b111;
    wb_stb_o = 1'b1;
    wb_cyc_o = 1'b1;
    wb_dat_i = 32'h1122_3344;

    #1  wb_adr_o = 32'h4;
    #1  wb_adr_o += 32'h4;
    #1  wb_adr_o += 32'h4;
    #1  wb_adr_o += 32'h4;
    #1  wb_adr_o += 32'h4;
    #1  wb_adr_o += 32'h4;
    #1  wb_adr_o += 32'h4;
    #1  wb_adr_o += 32'h4;

        wb_we_o = 1'b0;
        wb_sel_o= 3'b0;
        wb_stb_o = 1'b0;
        wb_cyc_o = 1'b0;
        wb_dat_i = 32'h0000_0000;


    #10  wb_adr_o = 32'h100;
        wb_we_o = 1'b1;
        wb_sel_o= 3'b111;
        wb_stb_o = 1'b1;
        wb_cyc_o = 1'b1;
            wb_dat_i = 32'h1122_3344;
    #1  wb_adr_o += 32'h4;
    #1  wb_adr_o += 32'h4;
    #1  wb_adr_o += 32'h4;
    #1  wb_adr_o += 32'h4;
    #1  wb_adr_o += 32'h4;
    #1  wb_adr_o += 32'h4;
    #1  wb_adr_o += 32'h4;

    #10  wb_adr_o = 32'h200;
        wb_we_o = 1'b1;
        wb_sel_o= 3'b111;
        wb_stb_o = 1'b1;
        wb_cyc_o = 1'b1;
            wb_dat_i = 32'h1122_3344;                        
    #1  wb_adr_o += 32'h4;
    #1  wb_adr_o += 32'h4;
    #1  wb_adr_o += 32'h4;
    #1  wb_adr_o += 32'h4;
    #1  wb_adr_o += 32'h4;
    #1  wb_adr_o += 32'hFF00_0000;

    #40 $finish;	
  	 $display("Done");            

end

endmodule
