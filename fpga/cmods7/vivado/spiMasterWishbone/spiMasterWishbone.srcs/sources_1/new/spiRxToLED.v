`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2022 11:25:58 AM
// Design Name: 
// Module Name: spiRxToLED
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module spiRxToLED(
    input [7:0] i_data,
    output o_led_0,
    output o_led_1,
    output o_led_2,
    output o_led_3,
    output o_rgb_r,
    output o_rgb_g,
    output o_rgb_b
    );
    
   assign o_led_0 = i_data[0];
   assign o_led_1 = i_data[1];
   assign o_led_2 = i_data[2];
   assign o_led_3 = i_data[3];
   
   assign o_rgb_r = i_data[4];
   assign o_rgb_g = i_data[5];
   assign o_rgb_b = i_data[6];   
       
endmodule
