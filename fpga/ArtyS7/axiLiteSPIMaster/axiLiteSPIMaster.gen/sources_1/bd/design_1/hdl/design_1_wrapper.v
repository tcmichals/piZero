//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
//Date        : Fri Jun 10 15:37:52 2022
//Host        : VERITY-1171 running 64-bit Ubuntu 20.04.4 LTS
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (ddr_clock,
    reset);
  input ddr_clock;
  input reset;

  wire ddr_clock;
  wire reset;

  design_1 design_1_i
       (.ddr_clock(ddr_clock),
        .reset(reset));
endmodule
