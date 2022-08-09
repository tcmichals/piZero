

`timescale 1ns / 1ps

/*
 * Wishbone register
 */
module led_wb #
(
    parameter DATA_WIDTH = 32,                  // width of data bus in bits (8, 16, 32, or 64)
    parameter ADDR_WIDTH = 32,                  // width of address bus in bits
    parameter SELECT_WIDTH = (DATA_WIDTH/8)     // width of word select bus (1, 2, 4, or 8)
)
(
    input  wire                    clk,
    input  wire                    rst,

    // master side
    input  wire [ADDR_WIDTH-1:0]   wb_adr_i,   // ADR_I() address
    input  wire [DATA_WIDTH-1:0]   wb_dat_i,   // DAT_I() data in
    output wire [DATA_WIDTH-1:0]   wb_dat_o,   // DAT_O() data out
    input  wire                    wb_we_i,    // WE_I write enable input
    input  wire [SELECT_WIDTH-1:0] wb_sel_i,   // SEL_I() select input
    input  wire                    wb_stb_i,   // STB_I strobe input
    output wire                    wb_ack_o,   // ACK_O acknowledge output
    output wire                    wb_err_o,   // ERR_O error output
    output wire                    wb_rty_o,   // RTY_O retry output
    input  wire                    wb_cyc_i,   // CYC_I cycle input

    output wire o_led_0,
    output wire o_led_1,
    output wire o_led_2,
    output wire o_led_green,
    output wire o_led_blue,
    output wire o_led_red );

reg [31:0] led = 0;

assign wb_rty_o = 0;
assign wb_err_o = 0;
assign wb_ack_o = wb_cyc_i;
assign wb_dat_o = led;
assign o_led_0 = led[0];
assign o_led_1 = led[1];
assign o_led_2 = led[2];
assign o_led_green = led[3];
assign o_led_blue = led[4];
assign o_led_red = led[5];

always @(posedge clk) begin
    if (~rst) begin
        led <= 0;
    end else begin
            if ((wb_we_i & wb_cyc_i & wb_stb_i)) begin
                led <= wb_dat_i;
            end
    end     

end

endmodule
