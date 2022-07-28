module simplecounter(
    input wire i_clk,
    input wire i_reset,
    output wire o_wire
);

reg [31:0] counter;

initial begin
    counter = 0;
end


    always @(posedge i_clk) begin
        counter <= counter + 1'b1;
    end

assign o_wire =counter[24];

endmodule