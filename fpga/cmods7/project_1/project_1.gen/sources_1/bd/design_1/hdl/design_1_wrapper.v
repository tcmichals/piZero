//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
//Date        : Wed Jun 22 09:15:41 2022
//Host        : hp running 64-bit Ubuntu 22.04 LTS
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (led_0,
    reset,
    sys_clock);
  output led_0;
  input reset;
  input sys_clock;

  wire led_0;
  wire reset;
  wire sys_clock;

  design_1 design_1_i
       (.led_0(led_0),
        .reset(reset),
        .sys_clock(sys_clock));
endmodule
