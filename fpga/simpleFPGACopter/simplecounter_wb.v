module simplecounter_wb #
(
    parameter DATA_WIDTH = 32,                    // width of data bus in bits (8, 16, 32, or 64)
    parameter ADDR_WIDTH = 32,                    // width of address bus in bits
    parameter SELECT_WIDTH = (DATA_WIDTH/8)       // width of word select bus (1, 2, 4, or 8)
)
(
    input wire i_clk,
    input wire i_rst,
    /*
     * Wishbone master input
     */
    input  wire [5:0]              wb_adr_i,     // ADR_I() address input
    input  wire [DATA_WIDTH-1:0]   wb_dat_i,     // DAT_I() data in
    output wire [DATA_WIDTH-1:0]   wb_dat_o,     // DAT_O() data out
    input  wire                    wb_we_i,      // WE_I write enable input
    input  wire [SELECT_WIDTH-1:0] wb_sel_i,     // SEL_I() select input
    input  wire                    wb_stb_i,     // STB_I strobe input
    output wire                    wb_ack_o,     // ACK_O acknowledge output
    output wire                    wb_err_o,     // ERR_O error output
    output wire                    wb_rty_o,     // RTY_O retry output
    input  wire                    wb_cyc_i     // CYC_I cycle input

);

reg [DATA_WIDTH-1:0]   counter;     // DAT_O() data out
reg                    lcl_wb_ack_o, lcl_ack;     // ACK_O acknowledge output
reg                    lcl_wb_err_o;     // ERR_O error output
reg                    lcl_wb_rty_o;     // RTY_O retry output

initial begin

    counter = 0;
    lcl_wb_ack_o = 0;
    lcl_wb_err_o = 0;
    lcl_wb_rty_o = 0;
    lcl_ack = 0;

end



always @* begin
    lcl_wb_ack_o <= wb_stb_i;  
end

always @(posedge i_clk)
    lcl_ack <= wb_stb_i;        

always @(posedge i_clk)
    lcl_wb_ack_o <= lcl_ack;     

always @(posedge i_clk) begin
    counter <= counter + 1'b1;
 end

assign wb_dat_o = counter;
assign wb_ack_o = lcl_wb_ack_o;
assign wb_err_o = lcl_wb_err_o;
assign wb_rty_o = lcl_wb_rty_o;

endmodule


