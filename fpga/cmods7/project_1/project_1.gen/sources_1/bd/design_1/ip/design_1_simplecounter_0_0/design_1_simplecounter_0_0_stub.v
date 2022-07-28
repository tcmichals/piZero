// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
// Date        : Wed Jun 22 09:16:47 2022
// Host        : hp running 64-bit Ubuntu 22.04 LTS
// Command     : write_verilog -force -mode synth_stub
//               /media/tcmichals/copter/fpga/cmods7/project_1/project_1.gen/sources_1/bd/design_1/ip/design_1_simplecounter_0_0/design_1_simplecounter_0_0_stub.v
// Design      : design_1_simplecounter_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7s25csga225-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "simplecounter,Vivado 2022.1" *)
module design_1_simplecounter_0_0(i_clk, i_reset, o_wire)
/* synthesis syn_black_box black_box_pad_pin="i_clk,i_reset,o_wire" */;
  input i_clk;
  input i_reset;
  output o_wire;
endmodule
